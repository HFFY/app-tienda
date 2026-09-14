import '../../../../core/database/app_database.dart';
import '../../../../core/error/db_guard.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/error/failure_exception.dart';
import '../../../../core/error/result.dart';
import '../../../inventory/data/datasources/inventory_local_data_source.dart';
import '../../../inventory/data/models/movement_mapper.dart';
import '../../../inventory/domain/entities/inventory_movement.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_data_source.dart';
import '../models/product_mapper.dart';

final class ProductRepositoryImpl implements ProductRepository {
  const ProductRepositoryImpl(this._appDb, this._products, this._movements);

  final AppDatabase _appDb;
  final ProductLocalDataSource _products;
  final InventoryLocalDataSource _movements;

  @override
  Future<Result<List<Product>>> findAll({
    int? categoryId,
    String query = '',
    bool includeInactive = false,
  }) =>
      guardDb(() async {
        final rows = await _products.findAll(
          categoryId: categoryId,
          query: query,
          includeInactive: includeInactive,
        );
        return rows.map(productFromMap).toList();
      });

  @override
  Future<Result<Product?>> findById(int id) => guardDb(() async {
        final row = await _products.findById(id);
        return row == null ? null : productFromMap(row);
      });

  @override
  Future<Result<Product>> create(Product draft, {required int initialStock}) =>
      guardDb(() => _appDb.db.transaction((txn) async {
            final id = await _products.insert(draft.toInsertMap(initialStock: initialStock), txn: txn);
            if (initialStock > 0) {
              await _movements.insert(
                NewMovement(
                  productId: id,
                  type: MovementType.in_,
                  delta: initialStock,
                  reason: MovementReason.initial,
                ).toInsertMap(),
                txn: txn,
              );
            }
            return productFromMap(await _products.getById(id, txn: txn));
          }));

  @override
  Future<Result<Product>> update(Product product) => guardDb(() async {
        final changed = await _products.update(product.id, product.toUpdateMap());
        if (changed == 0) throw const FailureException(NotFoundFailure('El producto no existe.'));
        return productFromMap(await _products.getById(product.id));
      });

  @override
  Future<Result<void>> delete(int id) => guardDb(() => _appDb.db.transaction((txn) async {
        // FK RESTRICT: primero los movimientos (solo 'initial' llegan aquí).
        await _movements.deleteByProduct(id, txn: txn);
        await _products.delete(id, txn: txn);
      }));

  @override
  Future<Result<void>> setActive(int id, bool active) => guardDb(() => _products.setActive(id, active));

  @override
  Future<Result<int>> countSaleReferences(int id) => guardDb(() => _products.countSaleReferences(id));

  @override
  Future<Result<int>> countNonInitialMovements(int id) =>
      guardDb(() => _products.countNonInitialMovements(id));
}
