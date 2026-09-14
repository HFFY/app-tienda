import 'package:sqflite/sqflite.dart';

import '../../../../core/database/local_data_source.dart';
import '../../../../core/database/tables.dart';
import '../models/sale_mapper.dart';

final class SaleLocalDataSource extends LocalDataSource {
  const SaleLocalDataSource(super.appDb);

  Future<int> insertSale(Map<String, Object?> values, {required DatabaseExecutor txn}) =>
      txn.insert(Tables.sale, values);

  Future<int> insertItem(Map<String, Object?> values, {required DatabaseExecutor txn}) =>
      txn.insert(Tables.saleItem, values);

  Future<Map<String, Object?>?> findById(int id, {DatabaseExecutor? txn}) async {
    final rows = await exec(txn).rawQuery('''
      SELECT s.*, c.${CustomerCols.firstName} || ' ' || c.${CustomerCols.lastName} AS $kSaleCustomerNameCol
      FROM ${Tables.sale} s
      JOIN ${Tables.customer} c ON c.${CustomerCols.id} = s.${SaleCols.customerId}
      WHERE s.${SaleCols.id} = ?
    ''', [id]);
    return rows.isEmpty ? null : rows.first;
  }

  Future<List<Map<String, Object?>>> findItems(int saleId, {DatabaseExecutor? txn}) => exec(txn).query(
        Tables.saleItem,
        where: '${SaleItemCols.saleId} = ?',
        whereArgs: [saleId],
        orderBy: '${SaleItemCols.id} ASC',
      );
}
