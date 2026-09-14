import 'package:sqflite/sqflite.dart';

import 'app_database.dart';

/// Base de todos los DataSources locales.
///
/// Cada método público de un DataSource acepta `{DatabaseExecutor? txn}` y
/// resuelve el ejecutor con [exec], de modo que la misma consulta pueda
/// correr suelta o dentro de una transacción abierta por otro repositorio.
abstract base class LocalDataSource {
  const LocalDataSource(this.appDb);

  final AppDatabase appDb;

  DatabaseExecutor exec([DatabaseExecutor? txn]) => txn ?? appDb.db;
}

/// Convierte 0/1 de SQLite a bool.
bool dbBool(Object? v) => v == 1 || v == true;

/// Convierte bool a 0/1 para SQLite.
int dbInt(bool v) => v ? 1 : 0;
