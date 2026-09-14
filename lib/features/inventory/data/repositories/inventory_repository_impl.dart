import '../../../../core/database/app_database.dart';
import '../../../../core/database/tables.dart';
import '../../../../core/error/db_guard.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/error/failure_exception.dart';
import '../../../../core/error/result.dart';
import '../../../products/data/datasources/product_local_data_source.dart';
import '../../domain/entities/inventory_movement.dart';
import '../../domain/repositories/inventory_repository.dart';
import '../datasources/inventory_local_data_source.dart';
import '../models/movement_mapper.dart';

final class InventoryRepositoryImpl implements InventoryRepository {
  const InventoryRepositoryImpl(this._appDb, this._movements, this._products);

  final AppDatabase _appDb;
  final InventoryLocalDataSource _movements;
  final ProductLocalDataSource _products;

  @override
  Future<Result<List<InventoryMovement>>> findByProduct(int productId) => guardDb(() async {
        final rows = await _movements.findByProduct(productId);
        return rows.map(movementFromMap).toList();
      });

  @override
  Future<Result<InventoryMovement>> register(NewMovement movement) =>
      guardDb(() => _appDb.db.transaction((txn) async {
            final product = await _products.findById(movement.productId, txn: txn);
            if (product == null) {
              throw const FailureException(NotFoundFailure('El producto no existe.'));
            }
            final applied = await _products.applyStockDelta(movement.productId, movement.delta, txn: txn);
            if (applied == 0) {
              throw FailureException(
                InsufficientStockFailure(
                  productName: product[ProductCols.name] as String,
                  available: (product[ProductCols.stock] as int?) ?? 0,
                  requested: movement.delta.abs(),
                ),
              );
            }
            final id = await _movements.insert(movement.toInsertMap(), txn: txn);
            return movementFromMap(await _movements.getById(id, txn: txn));
          }));
}
