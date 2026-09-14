import 'package:sqflite/sqflite.dart';

import '../../../../core/database/local_data_source.dart';
import '../../../../core/database/tables.dart';
import '../../../../core/utils/clock.dart';

final class UserLocalDataSource extends LocalDataSource {
  const UserLocalDataSource(super.appDb);

  static const _publicCols = [
    UserCols.id,
    UserCols.firstName,
    UserCols.lastName,
    UserCols.email,
    UserCols.createdAt,
    UserCols.updatedAt,
  ];

  Future<int> count({DatabaseExecutor? txn}) async {
    final rows = await exec(txn).rawQuery('SELECT COUNT(*) AS c FROM ${Tables.appUser}');
    return (rows.first['c'] as int?) ?? 0;
  }

  Future<Map<String, Object?>?> findByEmail(String email, {DatabaseExecutor? txn}) async {
    final rows = await exec(txn).query(
      Tables.appUser,
      columns: _publicCols,
      where: '${UserCols.email} = ? COLLATE NOCASE',
      whereArgs: [email],
      limit: 1,
    );
    return rows.isEmpty ? null : rows.first;
  }

  Future<Map<String, Object?>?> findById(int id, {DatabaseExecutor? txn}) async {
    final rows = await exec(txn).query(
      Tables.appUser,
      columns: _publicCols,
      where: '${UserCols.id} = ?',
      whereArgs: [id],
      limit: 1,
    );
    return rows.isEmpty ? null : rows.first;
  }

  Future<Map<String, Object?>> getById(int id, {DatabaseExecutor? txn}) async {
    final row = await findById(id, txn: txn);
    if (row == null) throw StateError('Usuario $id no existe.');
    return row;
  }

  Future<int> insert({
    required String firstName,
    required String lastName,
    required String email,
    required String passwordHash,
    required String passwordSalt,
    DatabaseExecutor? txn,
  }) {
    final now = nowUtcIso();
    return exec(txn).insert(Tables.appUser, {
      UserCols.firstName: firstName,
      UserCols.lastName: lastName,
      UserCols.email: email,
      UserCols.passwordHash: passwordHash,
      UserCols.passwordSalt: passwordSalt,
      UserCols.createdAt: now,
      UserCols.updatedAt: now,
    });
  }

  Future<int> update(int id, Map<String, Object?> values, {DatabaseExecutor? txn}) =>
      exec(txn).update(Tables.appUser, values, where: '${UserCols.id} = ?', whereArgs: [id]);

  Future<int> updatePassword(int id, String hash, String salt, {DatabaseExecutor? txn}) =>
      exec(txn).update(
        Tables.appUser,
        {
          UserCols.passwordHash: hash,
          UserCols.passwordSalt: salt,
          UserCols.updatedAt: nowUtcIso(),
        },
        where: '${UserCols.id} = ?',
        whereArgs: [id],
      );

  Future<({String hash, String salt})?> getCredentials(int id, {DatabaseExecutor? txn}) async {
    final rows = await exec(txn).query(
      Tables.appUser,
      columns: [UserCols.passwordHash, UserCols.passwordSalt],
      where: '${UserCols.id} = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return (
      hash: rows.first[UserCols.passwordHash] as String,
      salt: rows.first[UserCols.passwordSalt] as String,
    );
  }
}
