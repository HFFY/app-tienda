import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

import '../database/database_providers.dart';

/// Copia las imágenes elegidas al directorio de documentos de la app y
/// devuelve rutas **relativas** (`images/products/1694…jpg`).
///
/// Así la imagen sobrevive aunque el usuario la borre de la galería, y la
/// ruta sigue siendo válida si Android reubica el sandbox de la app.
class ImageStorage {
  const ImageStorage(this.docsDir);

  final Directory docsDir;

  Future<String> persist(XFile source, {required String folder}) async {
    final ext = p.extension(source.path).toLowerCase();
    final safeExt = (ext == '.png' || ext == '.webp') ? ext : '.jpg';
    final rel = p.join('images', folder, '${DateTime.now().microsecondsSinceEpoch}$safeExt');
    final target = File(p.join(docsDir.path, rel));
    await target.parent.create(recursive: true);
    await source.saveTo(target.path);
    return rel;
  }

  File resolve(String relativePath) => File(p.join(docsDir.path, relativePath));

  Future<void> delete(String? relativePath) async {
    if (relativePath == null || relativePath.isEmpty) return;
    final f = resolve(relativePath);
    if (await f.exists()) await f.delete();
  }
}

final imageStorageProvider = Provider<ImageStorage>(
  (ref) => ImageStorage(ref.watch(documentsDirProvider)),
);

/// Selector de galería con reducción de tamaño para no guardar fotos de
/// 12 MP en la app.
Future<XFile?> pickImageFromGallery() {
  return ImagePicker().pickImage(
    source: ImageSource.gallery,
    maxWidth: 1024,
    maxHeight: 1024,
    imageQuality: 85,
  );
}
