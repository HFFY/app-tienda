import 'package:sqflite/sqflite.dart';

import '../../../../core/database/local_data_source.dart';
import '../../../../core/database/tables.dart';
import '../../../../core/utils/clock.dart';
import '../models/service_mapper.dart';

final class ServiceLocalDataSource extends LocalDataSource {
  const ServiceLocalDataSource(super.appDb);

  static const _selectWithCategory = '''
    SELECT s.*,
           c.${CategoryCols.name}     AS $kServiceCategoryNameCol,
           c.${CategoryCols.colorHex} AS $kServiceCategoryColorCol,
           c.${CategoryCols.iconCode} AS $kServiceCategoryIconCol
    FROM ${Tables.service} s
    LEFT JOIN ${Tables.category} c ON c.${CategoryCols.id} = s.${ServiceCols.categoryId}
  ''';

  Future<List<Map<String, Object?>>> findAll({
    int? categoryId,
    String query = '',
    bool includeInactive = false,
    DatabaseExecutor? txn,
  }) {
    final where = <String>[];
    final args = <Object?>[];
    if (!includeInactive) where.add('s.${ServiceCols.isActive} = 1');
    if (categoryId != null) {
      where.add('s.${ServiceCols.categoryId} = ?');
      args.add(categoryId);
    }
    final q = query.trim();
    if (q.isNotEmpty) {
      where.add('s.${ServiceCols.name} LIKE ?');
      args.add('%$q%');
    }
    final sql = StringBuffer(_selectWithCategory);
    if (where.isNotEmpty) sql.write(' WHERE ${where.join(' AND ')}');
    sql.write(' ORDER BY s.${ServiceCols.name} COLLATE NOCASE ASC');
    return exec(txn).rawQuery(sql.toString(), args);
  }

  Future<Map<String, Object?>?> findById(int id, {DatabaseExecutor? txn}) async {
    final rows = await exec(txn).rawQuery('$_selectWithCategory WHERE s.${ServiceCols.id} = ?', [id]);
    return rows.isEmpty ? null : rows.first;
  }

  Future<Map<String, Object?>> getById(int id, {DatabaseExecutor? txn}) async {
    final row = await findById(id, txn: txn);
    if (row == null) throw StateError('Servicio $id no existe.');
    return row;
  }

  Future<int> insert(Map<String, Object?> values, {DatabaseExecutor? txn}) =>
      exec(txn).insert(Tables.service, values);

  Future<int> update(int id, Map<String, Object?> values, {DatabaseExecutor? txn}) =>
      exec(txn).update(Tables.service, values, where: '${ServiceCols.id} = ?', whereArgs: [id]);

  Future<int> delete(int id, {DatabaseExecutor? txn}) =>
      exec(txn).delete(Tables.service, where: '${ServiceCols.id} = ?', whereArgs: [id]);

  Future<int> setActive(int id, bool active, {DatabaseExecutor? txn}) => exec(txn).update(
        Tables.service,
        {ServiceCols.isActive: dbInt(active), ServiceCols.updatedAt: nowUtcIso()},
        where: '${ServiceCols.id} = ?',
        whereArgs: [id],
      );

  Future<int> countSaleReferences(int id, {DatabaseExecutor? txn}) async {
    final rows = await exec(txn).rawQuery(
      'SELECT COUNT(*) AS c FROM ${Tables.saleItem} WHERE ${SaleItemCols.serviceId} = ?',
      [id],
    );
    return (rows.first['c'] as int?) ?? 0;
  }
}
