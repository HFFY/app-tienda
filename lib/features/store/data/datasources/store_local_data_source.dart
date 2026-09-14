import 'package:sqflite/sqflite.dart';

import '../../../../core/database/local_data_source.dart';
import '../../../../core/database/tables.dart';
import '../../../../core/utils/clock.dart';

final class StoreLocalDataSource extends LocalDataSource {
  const StoreLocalDataSource(super.appDb);

  Future<Map<String, Object?>> getStore({DatabaseExecutor? txn}) async {
    final rows = await exec(txn).query(Tables.store, where: 'id = 1', limit: 1);
    if (rows.isEmpty) {
      throw StateError('La fila de store no existe; la semilla no corrió.');
    }
    return rows.first;
  }

  Future<void> update(Map<String, Object?> values, {DatabaseExecutor? txn}) =>
      exec(txn).update(Tables.store, values, where: 'id = 1');

  Future<void> markBackup(DateTime at, {DatabaseExecutor? txn}) => exec(txn).update(
        Tables.store,
        {StoreCols.lastBackupAt: toUtcIso(at), StoreCols.updatedAt: nowUtcIso()},
        where: 'id = 1',
      );
}
