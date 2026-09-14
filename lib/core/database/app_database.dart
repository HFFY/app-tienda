import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import 'migrations.dart';
import 'seed_data.dart';

/// Conexión única a la base de datos SQLite de la app.
///
/// Los DataSources deben usar [db] en cada llamada y nunca cachear la
/// instancia de [Database]: el respaldo en versiones antiguas de SQLite
/// cierra y reabre la conexión ([close] / [reopen]).
class AppDatabase {
  AppDatabase._(this._path, this._db);

  static const fileName = 'app_tienda.db';

  final String _path;
  Database _db;

  String get path => _path;

  Database get db {
    if (!_db.isOpen) {
      throw StateError('La base de datos está cerrada.');
    }
    return _db;
  }

  bool get isOpen => _db.isOpen;

  static Future<AppDatabase> open({String? pathOverride}) async {
    final path = pathOverride ?? p.join(await getDatabasesPath(), fileName);
    final db = await _openAt(path);
    return AppDatabase._(path, db);
  }

  static Future<Database> _openAt(String path) {
    return openDatabase(
      path,
      version: kSchemaVersion,
      onConfigure: (db) async {
        // Es por conexión: no sirve ponerlo en onCreate.
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {
        for (final sql in schemaV1) {
          await db.execute(sql);
        }
        await seedDatabase(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        for (var v = oldVersion + 1; v <= newVersion; v++) {
          for (final sql in upgrades[v] ?? const <String>[]) {
            await db.execute(sql);
          }
        }
      },
    );
  }

  Future<void> close() => _db.close();

  Future<void> reopen() async {
    if (_db.isOpen) return;
    _db = await _openAt(_path);
  }

  /// Versión de la librería SQLite del sistema, p. ej. `3.32.2`.
  Future<String> sqliteVersion() async {
    final rows = await db.rawQuery('SELECT sqlite_version() AS v');
    return rows.first['v'] as String;
  }

  /// `true` si la SQLite del sistema soporta `VACUUM INTO` (≥ 3.27).
  Future<bool> supportsVacuumInto() async {
    final parts = (await sqliteVersion()).split('.').map(int.tryParse).toList();
    final major = parts.elementAtOrNull(0) ?? 0;
    final minor = parts.elementAtOrNull(1) ?? 0;
    return major > 3 || (major == 3 && minor >= 27);
  }
}
