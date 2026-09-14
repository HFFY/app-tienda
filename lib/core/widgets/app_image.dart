import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/image_storage.dart';

/// Muestra una imagen guardada por ruta relativa, con placeholder.
class AppImage extends ConsumerWidget {
  const AppImage({
    super.key,
    required this.relativePath,
    this.fit = BoxFit.cover,
    this.placeholderIcon = Icons.image_outlined,
    this.cacheWidth = 400,
    this.width,
    this.height,
  });

  final String? relativePath;
  final BoxFit fit;
  final IconData placeholderIcon;
  final int cacheWidth;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final placeholder = Container(
      width: width,
      height: height,
      color: scheme.surfaceContainerHighest,
      alignment: Alignment.center,
      child: Icon(placeholderIcon, size: 36, color: scheme.onSurfaceVariant.withValues(alpha: 0.6)),
    );
    if (relativePath == null || relativePath!.isEmpty) return placeholder;

    final file = ref.watch(imageStorageProvider).resolve(relativePath!);
    return Image.file(
      file,
      width: width,
      height: height,
      fit: fit,
      cacheWidth: cacheWidth,
      gaplessPlayback: true,
      errorBuilder: (_, _, _) => placeholder,
    );
  }
}
