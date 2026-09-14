import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_providers.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../../customers/domain/entities/customer.dart';
import '../../../customers/presentation/providers/customer_providers.dart';
import '../../../products/domain/entities/product.dart';
import '../../../products/presentation/providers/product_providers.dart';
import '../../../reports/presentation/providers/report_providers.dart';
import '../../../services/domain/entities/service.dart';
import '../../../services/presentation/providers/service_providers.dart';
import '../../data/datasources/sale_local_data_source.dart';
import '../../data/repositories/sale_repository_impl.dart';
import '../../domain/entities/cart.dart';
import '../../domain/entities/sale.dart';
import '../../domain/repositories/sale_repository.dart';
import '../../domain/services/sale_calculator.dart';
import '../../domain/usecases/register_sale.dart';

// ─── Infraestructura ────────────────────────────────────────────────────────

final saleLocalDataSourceProvider = Provider<SaleLocalDataSource>(
  (ref) => SaleLocalDataSource(ref.watch(appDatabaseProvider)),
);

final saleRepositoryProvider = Provider<SaleRepository>(
  (ref) => SaleRepositoryImpl(
    ref.watch(appDatabaseProvider),
    ref.watch(saleLocalDataSourceProvider),
    ref.watch(productLocalDataSourceProvider),
    ref.watch(inventoryLocalDataSourceProvider),
  ),
);

final registerSaleUseCaseProvider = Provider<RegisterSale>(
  (ref) => RegisterSale(
    ref.watch(saleRepositoryProvider),
    ref.watch(customerRepositoryProvider),
    ref.watch(productRepositoryProvider),
    ref.watch(serviceRepositoryProvider),
  ),
);

// ─── Carrito (sobrevive al cambio de pestaña: no autoDispose) ───────────────

final cartControllerProvider = NotifierProvider<CartController, Cart>(CartController.new);

class CartController extends Notifier<Cart> {
  @override
  Cart build() => const Cart();

  void setCustomer(Customer? customer) => state = state.copyWith(customer: customer);

  void addProduct(Product p) {
    _addOrIncrement(
      CartItem(
        type: SaleItemType.product,
        refId: p.id,
        name: p.name,
        categoryName: p.categoryName,
        unitPrice: p.price,
        availableStock: p.stock,
      ),
    );
  }

  void addService(Service s) {
    _addOrIncrement(
      CartItem(
        type: SaleItemType.service,
        refId: s.id,
        name: s.name,
        categoryName: s.categoryName,
        unitPrice: s.price,
      ),
    );
  }

  void _addOrIncrement(CartItem item) {
    final idx = state.items.indexWhere((i) => i.key == item.key);
    if (idx == -1) {
      state = state.copyWith(items: [...state.items, item]);
    } else {
      increment(item.key);
    }
  }

  void increment(String key) => _update(key, (i) => i.canIncrement ? i.copyWith(quantity: i.quantity + 1) : i);

  void decrement(String key) => _update(key, (i) => i.copyWith(quantity: i.quantity > 1 ? i.quantity - 1 : 1));

  void setQuantity(String key, int qty) =>
      _update(key, (i) => i.copyWith(quantity: qty.clamp(1, i.availableStock ?? 1 << 30)));

  void remove(String key) => state = state.copyWith(items: state.items.where((i) => i.key != key).toList());

  /// Deshacer un `Dismissible`: vuelve a insertar en su posición original.
  void restore(CartItem item, int index) {
    final items = [...state.items];
    items.insert(index.clamp(0, items.length), item);
    state = state.copyWith(items: items);
  }

  void setDiscount(DiscountType type, double value) =>
      state = state.copyWith(discountType: type, discountValue: type == DiscountType.none ? 0 : value);

  void setNote(String? note) => state = state.copyWith(note: note);

  void clear() => state = const Cart();

  void _update(String key, CartItem Function(CartItem) f) =>
      state = state.copyWith(items: [for (final i in state.items) i.key == key ? f(i) : i]);
}

final saleTotalsProvider = Provider<SaleTotals>((ref) => computeTotals(ref.watch(cartControllerProvider)));

// ─── Registro ───────────────────────────────────────────────────────────────

final registerSaleControllerProvider =
    AsyncNotifierProvider<RegisterSaleController, void>(RegisterSaleController.new);

class RegisterSaleController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<({Sale? sale, Failure? failure})> register() async {
    state = const AsyncLoading();
    final cart = ref.read(cartControllerProvider);
    final result = await ref.read(registerSaleUseCaseProvider)(cart);
    switch (result) {
      case Ok(:final value):
        state = const AsyncData(null);
        ref.read(cartControllerProvider.notifier).clear();
        // El stock y las estadísticas cambiaron.
        invalidateProducts(ref);
        ref.invalidate(customerStatsProvider);
        invalidateReports(ref);
        return (sale: value, failure: null);
      case Err(:final failure):
        state = AsyncError(failure, StackTrace.current);
        // Si falló por stock, refrescar para que el carrito muestre lo real.
        if (failure is InsufficientStockFailure) invalidateProducts(ref);
        return (sale: null, failure: failure);
    }
  }
}
