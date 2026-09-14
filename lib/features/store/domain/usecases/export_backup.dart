import 'dart:io';

import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';

/// Contrato mínimo que el caso de uso necesita del respaldo y del share,
/// para no depender de `sqflite` ni `share_plus` desde el dominio.
abstract interface class BackupWriter {
  Future<File> createBackup(String fileName);
  Future<void> deleteTemp(File file);
}

abstract interface class FileSharer {
  Future<bool> shareFile(File file, {required String subject, String? text});
}

/// Exporta un `.db` y lo comparte. Devuelve `true` si el usuario llegó a la
/// hoja de compartir (no se puede saber si envió o canceló).
class ExportBackup {
  const ExportBackup(this._backup, this._sharer);

  final BackupWriter _backup;
  final FileSharer _sharer;

  Future<Result<DateTime>> call({required String storeName}) async {
    final now = DateTime.now();
    final safeName = storeName
        .trim()
        .replaceAll(RegExp(r'[^\w\s-]'), '')
        .replaceAll(RegExp(r'\s+'), '_');
    final stamp = '${now.year}${pad2(now.month)}${pad2(now.day)}_${pad2(now.hour)}${pad2(now.minute)}';
    final fileName = 'respaldo_${safeName.isEmpty ? 'tienda' : safeName}_$stamp.db';

    File file;
    try {
      file = await _backup.createBackup(fileName);
    } catch (e) {
      return Err(StorageFailure('No se pudo generar el respaldo: $e'));
    }

    try {
      final shared = await _sharer.shareFile(
        file,
        subject: 'Respaldo $storeName ${pad2(now.day)}/${pad2(now.month)}/${now.year}',
        text: 'Copia de seguridad de la base de datos de $storeName.',
      );
      if (!shared) return const Err(StorageFailure('No hay ninguna app para compartir el archivo.'));
      return Ok(now);
    } catch (e) {
      return Err(StorageFailure('No se pudo compartir el respaldo: $e'));
    } finally {
      await _backup.deleteTemp(file);
    }
  }

  static String pad2(int n) => n.toString().padLeft(2, '0');
}
