import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_providers.dart';
import '../../../../core/database/tables.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../../../core/utils/clock.dart';
import '../../../categories/presentation/providers/category_providers.dart';
import '../../../customers/domain/entities/customer.dart';
import '../../../customers/presentation/providers/customer_providers.dart';
import '../../../products/domain/entities/product.dart';
import '../../../products/presentation/providers/product_providers.dart';
import '../../../reports/presentation/providers/report_providers.dart';
import '../../../sales/domain/entities/cart.dart';
import '../../../sales/domain/entities/sale.dart';
import '../../../sales/presentation/providers/sale_providers.dart';
import '../../../services/domain/entities/service.dart';
import '../../../services/presentation/providers/service_providers.dart';

/// Carga datos de demostración **a través de los casos de uso** (nunca con
/// INSERT directos), así el stock y los movimientos quedan consistentes.
/// Solo se retro-fechan las ventas y sus movimientos al final.
final demoDataLoaderProvider = Provider<DemoDataLoader>((ref) => DemoDataLoader(ref));

class DemoDataLoader {
  DemoDataLoader(this._ref);

  final Ref _ref;
  final _rng = Random(42);

  Future<Result<int>> load() async {
    final customers = await _createCustomers();
    if (customers case Err(:final failure)) return Err(failure);
    final products = await _createProducts();
    if (products case Err(:final failure)) return Err(failure);
    final services = await _createServices();
    if (services case Err(:final failure)) return Err(failure);

    final sales = await _createSales(
      customers.valueOrNull!,
      products.valueOrNull!,
      services.valueOrNull!,
    );
    if (sales case Err(:final failure)) return Err(failure);

    invalidateCustomers(_ref);
    invalidateProducts(_ref);
    invalidateServices(_ref);
    invalidateCategories(_ref);
    invalidateReports(_ref);
    return Ok(sales.valueOrNull!);
  }

  Future<Result<List<Customer>>> _createCustomers() async {
    const names = [
      ('Ana', 'Rojas', 'F', '71234567'),
      ('Luis', 'Mamani', 'M', '76543210'),
      ('Carla', 'Vargas', 'F', '70011223'),
      ('Jorge', 'Choque', 'M', null),
      ('Daniela', 'Torrez', 'F', '69887766'),
      ('Marcelo', 'Suárez', 'M', '72345678'),
      ('Paola', 'Gutiérrez', 'F', null),
      ('Rodrigo', 'Flores', 'M', '78901234'),
    ];
    final uc = _ref.read(saveCustomerProvider);
    final out = <Customer>[];
    for (final (f, l, g, phone) in names) {
      final r = await uc(Customer.draft().copyWith(
        firstName: f,
        lastName: l,
        gender: Gender.fromDb(g),
        phone: phone,
      ));
      switch (r) {
        case Err(:final failure):
          return Err(failure);
        case Ok(:final value):
          out.add(value);
      }
    }
    return Ok(out);
  }

  Future<Map<String, int>> _categoryIds() async {
    final r = await _ref.read(categoryRepositoryProvider).findAll(includeInactive: true);
    return {for (final c in r.valueOrNull ?? const []) c.name: c.id};
  }

  Future<Result<List<Product>>> _createProducts() async {
    final cats = await _categoryIds();
    final items = <(String, String?, double, int, int)>[
      ('Agua mineral 600ml', 'Bebidas', 5.0, 60, 12),
      ('Gaseosa 2L', 'Bebidas', 14.0, 30, 6),
      ('Jugo de naranja', 'Bebidas', 9.5, 24, 6),
      ('Papas fritas', 'Snacks', 7.0, 40, 10),
      ('Galletas de chocolate', 'Snacks', 6.5, 35, 8),
      ('Maní salado', 'Snacks', 4.0, 50, 10),
      ('Shampoo herbal', 'Cuidado personal', 32.0, 18, 4),
      ('Crema hidratante', 'Cuidado personal', 45.0, 12, 3),
      ('Jabón artesanal', 'Cuidado personal', 12.0, 25, 5),
      ('Aretes de plata', 'Accesorios', 55.0, 10, 2),
      ('Pulsera tejida', 'Accesorios', 18.0, 20, 4),
      ('Gorra bordada', 'Accesorios', 65.0, 8, 2),
    ];
    final uc = _ref.read(saveProductProvider);
    final out = <Product>[];
    for (final (name, cat, price, stock, min) in items) {
      final r = await uc(
        Product.draft().copyWith(name: name, categoryId: cats[cat], price: price, minStock: min),
        initialStock: stock,
      );
      switch (r) {
        case Err(:final failure):
          return Err(failure);
        case Ok(:final value):
          out.add(value);
      }
    }
    return Ok(out);
  }

  Future<Result<List<Service>>> _createServices() async {
    final cats = await _categoryIds();
    final items = <(String, String?, double, int)>[
      ('Corte dama', 'Cortes', 60.0, 45),
      ('Corte caballero', 'Cortes', 35.0, 30),
      ('Manicure', 'Tratamientos', 40.0, 40),
      ('Pedicure', 'Tratamientos', 50.0, 50),
      ('Limpieza facial', 'Cuidado personal', 90.0, 60),
      ('Tinte completo', 'Tratamientos', 150.0, 120),
    ];
    final uc = _ref.read(saveServiceProvider);
    final out = <Service>[];
    for (final (name, cat, price, minutes) in items) {
      final r = await uc(
        Service.draft().copyWith(name: name, categoryId: cats[cat], price: price, durationMinutes: minutes),
      );
      switch (r) {
        case Err(:final failure):
          return Err(failure);
        case Ok(:final value):
          out.add(value);
      }
    }
    return Ok(out);
  }

  Future<Result<int>> _createSales(List<Customer> customers, List<Product> products, List<Service> services) async {
    final register = _ref.read(registerSaleUseCaseProvider);
    final db = _ref.read(appDatabaseProvider).db;
    final now = DateTime.now();
    var created = 0;

    for (var i = 0; i < 60; i++) {
      final customer = customers[_rng.nextInt(customers.length)];
      final items = <CartItem>[];
      final n = 1 + _rng.nextInt(3);
      for (var k = 0; k < n; k++) {
        if (_rng.nextBool() || services.isEmpty) {
          final p = products[_rng.nextInt(products.length)];
          if (items.any((it) => it.isProduct && it.refId == p.id)) continue;
          items.add(CartItem(
            type: SaleItemType.product,
            refId: p.id,
            name: p.name,
            unitPrice: p.price,
            quantity: 1 + _rng.nextInt(3),
          ));
        } else {
          final s = services[_rng.nextInt(services.length)];
          if (items.any((it) => !it.isProduct && it.refId == s.id)) continue;
          items.add(CartItem(type: SaleItemType.service, refId: s.id, name: s.name, unitPrice: s.price));
        }
      }
      if (items.isEmpty) continue;

      final discountRoll = _rng.nextInt(10);
      final cart = Cart(
        customer: customer,
        items: items,
        discountType: discountRoll < 2 ? DiscountType.percent : (discountRoll < 3 ? DiscountType.amount : DiscountType.none),
        discountValue: discountRoll < 2 ? 10 : (discountRoll < 3 ? 5 : 0),
      );

      final r = await register(cart);
      switch (r) {
        case Err(:final failure):
          // Stock agotado en la simulación: se omite esa venta.
          if (failure is InsufficientStockFailure) continue;
          return Err(failure);
        case Ok(:final value):
          // Retro-fechar la venta y sus movimientos (últimos 90 días, horario comercial).
          final daysAgo = _rng.nextInt(90);
          final hour = 9 + _rng.nextInt(10);
          final when = DateTime(now.year, now.month, now.day - daysAgo, hour, _rng.nextInt(60));
          final iso = toUtcIso(when);
          await db.update(
            Tables.sale,
            {SaleCols.saleDate: iso, SaleCols.createdAt: iso},
            where: '${SaleCols.id} = ?',
            whereArgs: [value.id],
          );
          await db.update(
            Tables.inventoryMovement,
            {MovementCols.movedAt: iso, MovementCols.createdAt: iso},
            where: '${MovementCols.saleId} = ?',
            whereArgs: [value.id],
          );
          created++;
      }
    }
    return Ok(created);
  }
}
