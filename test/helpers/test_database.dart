import 'package:app_tienda/core/database/app_database.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

/// Abre una base SQLite en memoria (vía `sqflite_common_ffi`) con el mismo
/// DDL y semillas que la app. Reutiliza `AppDatabase` tal cual.
Future<AppDatabase> openTestDatabase() async {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  return AppDatabase.open(pathOverride: inMemoryDatabasePath);
}
