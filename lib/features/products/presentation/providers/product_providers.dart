import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_providers.dart';
import '../../../../core/utils/image_storage.dart';
import '../../../inventory/data/datasources/inventory_local_data_source.dart';
import '../../../inventory/data/repositories/inventory_repository_impl.dart';
import '../../../inventory/domain/entities/inventory_movement.dart';
import '../../../inventory/domain/repositories/inventory_repository.dart';
import '../../../inventory/domain/usecases/register_inventory_movement.dart';
import '../../data/datasources/product_local_data_source.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/usecases/delete_or_deactivate_product.dart';
import '../../domain/usecases/save_product.dart';

// ─── Infraestructura ────────────────────────────────────────────────────────

final productLocalDataSourceProvider = Provider<ProductLocalDataSource>(
  (ref) => ProductLocalDataSource(ref.watch(appDatabaseProvider)),
);

final inventoryLocalDataSourceProvider = Provider<InventoryLocalDataSource>(
  (ref) => InventoryLocalDataSource(ref.watch(appDatabaseProvider)),
);

final productRepositoryProvider = Provider<ProductRepository>(
  (ref) => ProductRepositoryImpl(
    ref.watch(appDatabaseProvider),
    ref.watch(productLocalDataSourceProvider),
    ref.watch(inventoryLocalDataSourceProvider),
  ),
);

final inventoryRepositoryProvider = Provider<InventoryRepository>(
  (ref) => InventoryRepositoryImpl(
    ref.watch(appDatabaseProvider),
    ref.watch(inventoryLocalDataSourceProvider),
    ref.watch(productLocalDataSourceProvider),
  ),
);

final saveProductProvider = Provider<SaveProduct>(
  (ref) => SaveProduct(ref.watch(productRepositoryProvider), ref.watch(imageStorageProvider)),
);

final deleteOrDeactivateProductProvider = Provider<DeleteOrDeactivateProduct>(
  (ref) => DeleteOrDeactivateProduct(
    ref.watch(productRepositoryProvider),
    ref.watch(imageStorageProvider),
  ),
);

final registerInventoryMovementProvider = Provider<RegisterInventoryMovement>(
  (ref) => RegisterInventoryMovement(ref.watch(inventoryRepositoryProvider)),
);

// ─── Filtro de la lista ─────────────────────────────────────────────────────

enum ProductViewMode { grid, list }

typedef ProductFilter = ({
  int? categoryId,
  String query,
  bool showInactive,
  ProductViewMode viewMode,
});

final productFilterProvider =
    NotifierProvider<ProductFilterController, ProductFilter>(ProductFilterController.new);

class ProductFilterController extends Notifier<ProductFilter> {
  @override
  ProductFilter build() =>
      (categoryId: null, query: '', showInactive: false, viewMode: ProductViewMode.grid);

  void setCategory(int? id) => state = (
        categoryId: id,
        query: state.query,
        showInactive: state.showInactive,
        viewMode: state.viewMode,
      );

  void setQuery(String q) => state = (
        categoryId: state.categoryId,
        query: q,
        showInactive: state.showInactive,
        viewMode: state.viewMode,
      );

  void setShowInactive(bool v) => state = (
        categoryId: state.categoryId,
        query: state.query,
        showInactive: v,
        viewMode: state.viewMode,
      );

  void toggleViewMode() => state = (
        categoryId: state.categoryId,
        query: state.query,
        showInactive: state.showInactive,
        viewMode: state.viewMode == ProductViewMode.grid ? ProductViewMode.list : ProductViewMode.grid,
      );
}

// ─── Lecturas ───────────────────────────────────────────────────────────────

final productsProvider = FutureProvider<List<Product>>((ref) async {
  final f = ref.watch(productFilterProvider);
  final result = await ref.watch(productRepositoryProvider).findAll(
        categoryId: f.categoryId,
        query: f.query,
        includeInactive: f.showInactive,
      );
  return result.getOrThrow();
});

/// Productos activos sin filtro (selector de la venta).
final activeProductsProvider = FutureProvider<List<Product>>((ref) async {
  final result = await ref.watch(productRepositoryProvider).findAll();
  return result.getOrThrow();
});

final productByIdProvider = FutureProvider.family<Product?, int>((ref, id) async {
  final result = await ref.watch(productRepositoryProvider).findById(id);
  return result.getOrThrow();
});

final productMovementsProvider =
    FutureProvider.family<List<InventoryMovement>, int>((ref, productId) async {
  final result = await ref.watch(inventoryRepositoryProvider).findByProduct(productId);
  return result.getOrThrow();
});

void invalidateProducts(Ref ref) {
  ref.invalidate(productsProvider);
  ref.invalidate(activeProductsProvider);
  ref.invalidate(productByIdProvider);
  ref.invalidate(productMovementsProvider);
}
