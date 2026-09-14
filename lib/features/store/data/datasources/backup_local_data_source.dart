import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/usecases/export_backup.dart';

/// Genera una copia consistente de la base de datos.
///
/// - SQLite ≥ 3.27 (Android 10+): `VACUUM INTO`, sin cerrar la conexión.
/// - SQLite anterior (Android 7–9, `minSdk 24`): cerrar, copiar el archivo
///   (sin conexión abierta no quedan `-journal`/`-wal` pendientes) y reabrir.
///   Los DataSources leen `appDb.db` en cada llamada, así que la reapertura
///   es transparente.
final class BackupLocalDataSource implements BackupWriter {
  const BackupLocalDataSource(this._appDb);

  final AppDatabase _appDb;

  @override
  Future<File> createBackup(String fileName) async {
    final tmp = await getTemporaryDirectory();
    final dest = File(p.join(tmp.path, fileName));
    if (await dest.exists()) await dest.delete();

    if (await _appDb.supportsVacuumInto()) {
      await _appDb.db.execute('VACUUM INTO ?', [dest.path]);
    } else {
      await _appDb.close();
      try {
        await File(_appDb.path).copy(dest.path);
      } finally {
        await _appDb.reopen();
      }
    }
    return dest;
  }

  @override
  Future<void> deleteTemp(File file) async {
    if (await file.exists()) await file.delete();
  }
}
