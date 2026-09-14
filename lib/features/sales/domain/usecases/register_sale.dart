import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../../customers/domain/repositories/customer_repository.dart';
import '../../../products/domain/repositories/product_repository.dart';
import '../../../services/domain/repositories/service_repository.dart';
import '../entities/cart.dart';
import '../entities/sale.dart';
import '../repositories/sale_repository.dart';
import '../services/sale_calculator.dart';

/// Valida el carrito contra el estado **actual** de la base (cliente e
/// ítems activos, nombres y precios vigentes), calcula totales y registra.
class RegisterSale {
  const RegisterSale(this._sales, this._customers, this._products, this._services);

  final SaleRepository _sales;
  final CustomerRepository _customers;
  final ProductRepository _products;
  final ServiceRepository _services;

  Future<Result<Sale>> call(Cart cart) async {
    final customer = cart.customer;
    if (customer == null) return const Err(ValidationFailure('Selecciona un cliente.'));
    if (cart.isEmpty) return const Err(ValidationFailure('Agrega al menos un producto o servicio.'));
    if (cart.discountType == DiscountType.percent && (cart.discountValue < 0 || cart.discountValue > 100)) {
      return const Err(ValidationFailure('El porcentaje debe estar entre 0 y 100.', field: 'discount'));
    }
    if (cart.discountValue < 0) {
      return const Err(ValidationFailure('El descuento no puede ser negativo.', field: 'discount'));
    }

    final customerResult = await _customers.findById(customer.id);
    switch (customerResult) {
      case Err(:final failure):
        return Err(failure);
      case Ok(:final value):
        if (value == null || !value.isActive) {
          return const Err(ValidationFailure('El cliente no existe o está inactivo.'));
        }
    }

    // Congelar nombre, categoría y precio vigentes.
    final refreshed = <CartItem>[];
    for (final item in cart.items) {
      if (item.quantity <= 0) {
        return Err(ValidationFailure('La cantidad de "${item.name}" debe ser mayor que 0.'));
      }
      switch (item.type) {
        case SaleItemType.product:
          final r = await _products.findById(item.refId);
          if (r case Err(:final failure)) return Err(failure);
          final p = r.valueOrNull;
          if (p == null || !p.isActive) {
            return Err(ValidationFailure('El producto "${item.name}" ya no está disponible.'));
          }
          if (p.stock < item.quantity) {
            return Err(InsufficientStockFailure(
              productName: p.name,
              available: p.stock,
              requested: item.quantity,
            ));
          }
          refreshed.add(item.copyWith(name: p.name, categoryName: p.categoryName, unitPrice: p.price));
        case SaleItemType.service:
          final r = await _services.findById(item.refId);
          if (r case Err(:final failure)) return Err(failure);
          final s = r.valueOrNull;
          if (s == null || !s.isActive) {
            return Err(ValidationFailure('El servicio "${item.name}" ya no está disponible.'));
          }
          refreshed.add(item.copyWith(name: s.name, categoryName: s.categoryName, unitPrice: s.price));
      }
    }

    final cleanCart = cart.copyWith(items: refreshed);
    final totals = computeTotals(cleanCart);
    final note = cart.note?.trim();

    final draft = SaleDraft(
      customerId: customer.id,
      subtotal: totals.subtotal,
      discountType: cart.discountType,
      discountValue: cart.discountType == DiscountType.none ? 0 : cart.discountValue,
      discountAmount: totals.discountAmount,
      total: totals.total,
      note: (note == null || note.isEmpty) ? null : note,
      items: [
        for (final i in refreshed)
          SaleDraftItem(
            type: i.type,
            refId: i.refId,
            nameSnapshot: i.name,
            categorySnapshot: i.categoryName,
            unitPrice: i.unitPrice,
            quantity: i.quantity,
            lineTotal: i.lineTotal,
          ),
      ],
    );

    return _sales.register(draft);
  }
}
