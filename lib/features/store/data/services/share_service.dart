import 'dart:io';

import 'package:share_plus/share_plus.dart';

import '../../domain/usecases/export_backup.dart';

/// Abre la hoja de compartir de Android (Gmail, WhatsApp, Drive…).
/// El `Future` se resuelve al cerrar la hoja, momento en que el llamador
/// puede borrar el archivo temporal.
final class ShareService implements FileSharer {
  const ShareService();

  @override
  Future<bool> shareFile(File file, {required String subject, String? text}) async {
    final result = await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path, mimeType: 'application/octet-stream')],
        subject: subject,
        text: text,
      ),
    );
    return result.status != ShareResultStatus.unavailable;
  }
}
