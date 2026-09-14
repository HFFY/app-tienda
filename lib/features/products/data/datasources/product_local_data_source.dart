import 'package:sqflite/sqflite.dart';

import '../../../../core/database/local_data_source.dart';
import '../../../../core/database/tables.dart';
import '../../../../core/utils/clock.dart';
import '../models/product_mapper.dart';

final class ProductLocalDataSource extends LocalDataSource {
  const ProductLocalDataSource(super.appDb);

  static const _selectWithCategory = '''
    SELECT p.*,
           c.${CategoryCols.name}     AS $kProductCategoryNameCol,
           c.${CategoryCols.colorHex} AS $kProductCategoryColorCol,
           c.${CategoryCols.iconCode} AS $kProductCategoryIconCol
    FROM ${Tables.product} p
    LEFT JOIN ${Tables.category} c ON c.${CategoryCols.id} = p.${ProductCols.categoryId}
  ''';

  Future<List<Map<String, Object?>>> findAll({
    int? categoryId,
    String query = '',
    bool includeInactive = false,
    DatabaseExecutor? txn,
  }) {
    final where = <String>[];
    final args = <Object?>[];
    if (!includeInactive) where.add('p.${ProductCols.isActive} = 1');
    if (categoryId != null) {
      where.add('p.${ProductCols.categoryId} = ?');
      args.add(categoryId);
    }
    final q = query.trim();
    if (q.isNotEmpty) {
      where.add('p.${ProductCols.name} LIKE ?');
      args.add('%$q%');
    }
    final sql = StringBuffer(_selectWithCategory);
    if (where.isNotEmpty) sql.write(' WHERE ${where.join(' AND ')}');
    sql.write(' ORDER BY p.${ProductCols.name} COLLATE NOCASE ASC');
    return exec(txn).rawQuery(sql.toString(), args);
  }

  Future<Map<String, Object?>?> findById(int id, {DatabaseExecutor? txn}) async {
    final rows = await exec(txn).rawQuery('$_selectWithCategory WHERE p.${ProductCols.id} = ?', [id]);
    return rows.isEmpty ? null : rows.first;
  }

  Future<Map<String, Object?>> getById(int id, {DatabaseExecutor? txn}) async {
    final row = await findById(id, txn: txn);
    if (row == null) throw StateError('Producto $id no existe.');
    return row;
  }

  Future<int> insert(Map<String, Object?> values, {DatabaseExecutor? txn}) =>
      exec(txn).insert(Tables.product, values);

  Future<int> update(int id, Map<String, Object?> values, {DatabaseExecutor? txn}) =>
      exec(txn).update(Tables.product, values, where: '${ProductCols.id} = ?', whereArgs: [id]);

  Future<int> delete(int id, {DatabaseExecutor? txn}) =>
      exec(txn).delete(Tables.product, where: '${ProductCols.id} = ?', whereArgs: [id]);

  Future<int> setActive(int id, bool active, {DatabaseExecutor? txn}) => exec(txn).update(
        Tables.product,
        {ProductCols.isActive: dbInt(active), ProductCols.updatedAt: nowUtcIso()},
        where: '${ProductCols.id} = ?',
        whereArgs: [id],
      );

  /// **Única** sentencia que modifica `stock` en toda la app.
  ///
  /// Devuelve 1 si aplicó el delta, 0 si el stock quedaría negativo (o el
  /// producto no existe). El llamador decide qué fallo lanzar.
  Future<int> applyStockDelta(int id, int delta, {required DatabaseExecutor txn}) => txn.rawUpdate(
        'UPDATE ${Tables.product} '
        'SET ${ProductCols.stock} = ${ProductCols.stock} + ?, ${ProductCols.updatedAt} = ? '
        'WHERE ${ProductCols.id} = ? AND ${ProductCols.stock} + ? >= 0',
        [delta, nowUtcIso(), id, delta],
      );

  Future<int> countSaleReferences(int id, {DatabaseExecutor? txn}) async {
    final rows = await exec(txn).rawQuery(
      'SELECT COUNT(*) AS c FROM ${Tables.saleItem} WHERE ${SaleItemCols.productId} = ?',
      [id],
    );
    return (rows.first['c'] as int?) ?? 0;
  }

  Future<int> countNonInitialMovements(int id, {DatabaseExecutor? txn}) async {
    final rows = await exec(txn).rawQuery(
      'SELECT COUNT(*) AS c FROM ${Tables.inventoryMovement} '
      "WHERE ${MovementCols.productId} = ? AND ${MovementCols.reason} <> 'initial'",
      [id],
    );
    return (rows.first['c'] as int?) ?? 0;
  }
}
