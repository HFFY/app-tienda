import 'package:sqflite/sqflite.dart';

import '../../../../core/database/local_data_source.dart';
import '../../../../core/database/tables.dart';

final class InventoryLocalDataSource extends LocalDataSource {
  const InventoryLocalDataSource(super.appDb);

  Future<List<Map<String, Object?>>> findByProduct(int productId, {DatabaseExecutor? txn}) =>
      exec(txn).query(
        Tables.inventoryMovement,
        where: '${MovementCols.productId} = ?',
        whereArgs: [productId],
        orderBy: '${MovementCols.movedAt} ASC, ${MovementCols.id} ASC',
      );

  Future<Map<String, Object?>> getById(int id, {DatabaseExecutor? txn}) async {
    final rows = await exec(txn).query(
      Tables.inventoryMovement,
      where: '${MovementCols.id} = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (rows.isEmpty) throw StateError('Movimiento $id no existe.');
    return rows.first;
  }

  Future<int> insert(Map<String, Object?> values, {DatabaseExecutor? txn}) =>
      exec(txn).insert(Tables.inventoryMovement, values);

  Future<int> deleteByProduct(int productId, {DatabaseExecutor? txn}) => exec(txn).delete(
        Tables.inventoryMovement,
        where: '${MovementCols.productId} = ?',
        whereArgs: [productId],
      );
}
