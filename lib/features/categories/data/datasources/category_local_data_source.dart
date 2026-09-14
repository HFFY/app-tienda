import 'package:sqflite/sqflite.dart';

import '../../../../core/database/local_data_source.dart';
import '../../../../core/database/tables.dart';
import '../../../../core/utils/clock.dart';

final class CategoryLocalDataSource extends LocalDataSource {
  const CategoryLocalDataSource(super.appDb);

  Future<List<Map<String, Object?>>> findAll({
    String? scopeDb,
    bool includeInactive = false,
    DatabaseExecutor? txn,
  }) {
    final where = <String>[];
    final args = <Object?>[];
    if (!includeInactive) where.add('${CategoryCols.isActive} = 1');
    if (scopeDb != null) {
      where.add("${CategoryCols.scope} IN (?, 'both')");
      args.add(scopeDb);
    }
    return exec(txn).query(
      Tables.category,
      where: where.isEmpty ? null : where.join(' AND '),
      whereArgs: args,
      orderBy: '${CategoryCols.sortOrder} ASC, ${CategoryCols.name} COLLATE NOCASE ASC',
    );
  }

  /// Categorías con conteo de productos y servicios que las usan.
  Future<List<Map<String, Object?>>> findAllWithUsage({DatabaseExecutor? txn}) {
    return exec(txn).rawQuery('''
      SELECT c.*,
        (SELECT COUNT(*) FROM ${Tables.product} p WHERE p.${ProductCols.categoryId} = c.${CategoryCols.id}) AS product_count,
        (SELECT COUNT(*) FROM ${Tables.service} s WHERE s.${ServiceCols.categoryId} = c.${CategoryCols.id}) AS service_count
      FROM ${Tables.category} c
      ORDER BY c.${CategoryCols.sortOrder} ASC, c.${CategoryCols.name} COLLATE NOCASE ASC
    ''');
  }

  Future<Map<String, Object?>?> findById(int id, {DatabaseExecutor? txn}) async {
    final rows = await exec(txn).query(
      Tables.category,
      where: '${CategoryCols.id} = ?',
      whereArgs: [id],
      limit: 1,
    );
    return rows.isEmpty ? null : rows.first;
  }

  Future<Map<String, Object?>> getById(int id, {DatabaseExecutor? txn}) async {
    final row = await findById(id, txn: txn);
    if (row == null) throw StateError('Categoría $id no existe.');
    return row;
  }

  Future<int> nextSortOrder({DatabaseExecutor? txn}) async {
    final rows = await exec(txn)
        .rawQuery('SELECT COALESCE(MAX(${CategoryCols.sortOrder}), -1) + 1 AS n FROM ${Tables.category}');
    return (rows.first['n'] as int?) ?? 0;
  }

  Future<int> insert(Map<String, Object?> values, {DatabaseExecutor? txn}) =>
      exec(txn).insert(Tables.category, values);

  Future<int> update(int id, Map<String, Object?> values, {DatabaseExecutor? txn}) =>
      exec(txn).update(Tables.category, values, where: '${CategoryCols.id} = ?', whereArgs: [id]);

  Future<int> delete(int id, {DatabaseExecutor? txn}) =>
      exec(txn).delete(Tables.category, where: '${CategoryCols.id} = ?', whereArgs: [id]);

  Future<int> setActive(int id, bool active, {DatabaseExecutor? txn}) => exec(txn).update(
        Tables.category,
        {CategoryCols.isActive: dbInt(active), CategoryCols.updatedAt: nowUtcIso()},
        where: '${CategoryCols.id} = ?',
        whereArgs: [id],
      );

  Future<void> reorder(List<int> orderedIds, {required DatabaseExecutor txn}) async {
    final batch = txn.batch();
    final now = nowUtcIso();
    for (var i = 0; i < orderedIds.length; i++) {
      batch.update(
        Tables.category,
        {CategoryCols.sortOrder: i, CategoryCols.updatedAt: now},
        where: '${CategoryCols.id} = ?',
        whereArgs: [orderedIds[i]],
      );
    }
    await batch.commit(noResult: true);
  }

  Future<({int products, int services})> countReferences(int id, {DatabaseExecutor? txn}) async {
    final rows = await exec(txn).rawQuery('''
      SELECT
        (SELECT COUNT(*) FROM ${Tables.product} WHERE ${ProductCols.categoryId} = ?) AS p,
        (SELECT COUNT(*) FROM ${Tables.service} WHERE ${ServiceCols.categoryId} = ?) AS s
    ''', [id, id]);
    return (
      products: (rows.first['p'] as int?) ?? 0,
      services: (rows.first['s'] as int?) ?? 0,
    );
  }
}
