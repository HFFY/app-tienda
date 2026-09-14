import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/image_storage.dart';
import 'app_image.dart';

/// Miniatura + botones "Elegir de galería" / "Quitar".
///
/// Mantiene tres estados: imagen existente (ruta relativa), imagen nueva
/// (`XFile` aún sin copiar) o sin imagen. El formulario decide qué hacer
/// al guardar con [newImage] y [removed].
class ImagePickerField extends StatefulWidget {
  const ImagePickerField({
    super.key,
    this.existingPath,
    required this.onChanged,
    this.size = 120,
    this.placeholderIcon = Icons.image_outlined,
  });

  final String? existingPath;
  final void Function({XFile? newImage, required bool removed}) onChanged;
  final double size;
  final IconData placeholderIcon;

  @override
  State<ImagePickerField> createState() => _ImagePickerFieldState();
}

class _ImagePickerFieldState extends State<ImagePickerField> {
  XFile? _picked;
  bool _removed = false;

  bool get _hasImage => _picked != null || (!_removed && widget.existingPath != null);

  Future<void> _pick() async {
    final file = await pickImageFromGallery();
    if (file == null) return;
    setState(() {
      _picked = file;
      _removed = false;
    });
    widget.onChanged(newImage: file, removed: false);
  }

  void _remove() {
    setState(() {
      _picked = null;
      _removed = true;
    });
    widget.onChanged(newImage: null, removed: true);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final Widget preview;
    if (_picked != null) {
      preview = Image.file(File(_picked!.path), fit: BoxFit.cover, cacheWidth: 400);
    } else if (!_removed && widget.existingPath != null) {
      preview = AppImage(relativePath: widget.existingPath, placeholderIcon: widget.placeholderIcon);
    } else {
      preview = Container(
        color: scheme.surfaceContainerHighest,
        alignment: Alignment.center,
        child: Icon(widget.placeholderIcon, size: 40, color: scheme.onSurfaceVariant),
      );
    }

    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(width: widget.size, height: widget.size, child: preview),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OutlinedButton.icon(
                onPressed: _pick,
                icon: const Icon(Icons.photo_library_outlined),
                label: Text(_hasImage ? 'Cambiar imagen' : 'Elegir de galería'),
              ),
              if (_hasImage) ...[
                const SizedBox(height: 8),
                TextButton.icon(
                  onPressed: _remove,
                  icon: const Icon(Icons.delete_outline),
                  label: const Text('Quitar'),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
