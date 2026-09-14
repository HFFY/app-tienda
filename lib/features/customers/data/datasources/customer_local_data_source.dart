import 'package:sqflite/sqflite.dart';

import '../../../../core/database/local_data_source.dart';
import '../../../../core/database/tables.dart';
import '../../../../core/utils/clock.dart';

final class CustomerLocalDataSource extends LocalDataSource {
  const CustomerLocalDataSource(super.appDb);

  Future<List<Map<String, Object?>>> findAll({
    String query = '',
    bool includeInactive = false,
    DatabaseExecutor? txn,
  }) {
    final where = <String>[];
    final args = <Object?>[];
    if (!includeInactive) where.add('${CustomerCols.isActive} = 1');
    final q = query.trim();
    if (q.isNotEmpty) {
      where.add(
        "(${CustomerCols.firstName} || ' ' || ${CustomerCols.lastName} LIKE ? "
        'OR ${CustomerCols.phone} LIKE ?)',
      );
      args.addAll(['%$q%', '%$q%']);
    }
    return exec(txn).query(
      Tables.customer,
      where: where.isEmpty ? null : where.join(' AND '),
      whereArgs: args,
      orderBy: '${CustomerCols.lastName} COLLATE NOCASE ASC, ${CustomerCols.firstName} COLLATE NOCASE ASC',
    );
  }

  Future<Map<String, Object?>?> findById(int id, {DatabaseExecutor? txn}) async {
    final rows = await exec(txn).query(
      Tables.customer,
      where: '${CustomerCols.id} = ?',
      whereArgs: [id],
      limit: 1,
    );
    return rows.isEmpty ? null : rows.first;
  }

  Future<Map<String, Object?>> getById(int id, {DatabaseExecutor? txn}) async {
    final row = await findById(id, txn: txn);
    if (row == null) throw StateError('Cliente $id no existe.');
    return row;
  }

  Future<int> insert(Map<String, Object?> values, {DatabaseExecutor? txn}) =>
      exec(txn).insert(Tables.customer, values);

  Future<int> update(int id, Map<String, Object?> values, {DatabaseExecutor? txn}) =>
      exec(txn).update(Tables.customer, values, where: '${CustomerCols.id} = ?', whereArgs: [id]);

  Future<int> delete(int id, {DatabaseExecutor? txn}) =>
      exec(txn).delete(Tables.customer, where: '${CustomerCols.id} = ?', whereArgs: [id]);

  Future<int> setActive(int id, bool active, {DatabaseExecutor? txn}) => exec(txn).update(
        Tables.customer,
        {CustomerCols.isActive: dbInt(active), CustomerCols.updatedAt: nowUtcIso()},
        where: '${CustomerCols.id} = ?',
        whereArgs: [id],
      );

  Future<int> countSales(int id, {DatabaseExecutor? txn}) async {
    final rows = await exec(txn).rawQuery(
      'SELECT COUNT(*) AS c FROM ${Tables.sale} WHERE ${SaleCols.customerId} = ?',
      [id],
    );
    return (rows.first['c'] as int?) ?? 0;
  }

  Future<({int count, double spent, String? lastAt})> stats(int id, {DatabaseExecutor? txn}) async {
    final rows = await exec(txn).rawQuery(
      'SELECT COUNT(*) AS c, COALESCE(SUM(${SaleCols.total}), 0) AS t, MAX(${SaleCols.saleDate}) AS d '
      'FROM ${Tables.sale} WHERE ${SaleCols.customerId} = ?',
      [id],
    );
    final r = rows.first;
    return (
      count: (r['c'] as int?) ?? 0,
      spent: ((r['t'] as num?) ?? 0).toDouble(),
      lastAt: r['d'] as String?,
    );
  }
}
