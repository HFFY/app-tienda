import '../../../../core/database/app_database.dart';
import '../../../../core/database/tables.dart';
import '../../../../core/error/db_guard.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/error/failure_exception.dart';
import '../../../../core/error/result.dart';
import '../../../inventory/data/datasources/inventory_local_data_source.dart';
import '../../../inventory/data/models/movement_mapper.dart';
import '../../../inventory/domain/entities/inventory_movement.dart';
import '../../../products/data/datasources/product_local_data_source.dart';
import '../../domain/entities/sale.dart';
import '../../domain/repositories/sale_repository.dart';
import '../datasources/sale_local_data_source.dart';
import '../models/sale_mapper.dart';

final class SaleRepositoryImpl implements SaleRepository {
  const SaleRepositoryImpl(this._appDb, this._sales, this._products, this._movements);

  final AppDatabase _appDb;
  final SaleLocalDataSource _sales;
  final ProductLocalDataSource _products;
  final InventoryLocalDataSource _movements;

  @override
  Future<Result<Sale>> register(SaleDraft draft) => guardDb(() => _appDb.db.transaction((txn) async {
        final saleId = await _sales.insertSale(draft.toInsertMap(), txn: txn);

        for (final item in draft.items) {
          await _sales.insertItem(item.toInsertMap(saleId), txn: txn);

          if (item.type != SaleItemType.product) continue;

          // Única puerta de cambio de stock; 0 filas = no alcanza.
          final applied = await _products.applyStockDelta(item.refId, -item.quantity, txn: txn);
          if (applied == 0) {
            final row = await _products.findById(item.refId, txn: txn);
            // El throw revierte la transacción completa.
            throw FailureException(
              InsufficientStockFailure(
                productName: item.nameSnapshot,
                available: (row?[ProductCols.stock] as int?) ?? 0,
                requested: item.quantity,
              ),
            );
          }
          await _movements.insert(
            NewMovement(
              productId: item.refId,
              type: MovementType.out,
              delta: -item.quantity,
              reason: MovementReason.sale,
              saleId: saleId,
            ).toInsertMap(),
            txn: txn,
          );
        }

        return _load(saleId, txn: txn);
      }));

  @override
  Future<Result<Sale?>> findById(int id) => guardDb(() async {
        final row = await _sales.findById(id);
        if (row == null) return null;
        return _load(id);
      });

  Future<Sale> _load(int id, {dynamic txn}) async {
    final row = await _sales.findById(id, txn: txn);
    if (row == null) throw const FailureException(NotFoundFailure('La venta no existe.'));
    final items = (await _sales.findItems(id, txn: txn)).map(saleItemFromMap).toList();
    return saleFromMap(row, items: items);
  }
}
