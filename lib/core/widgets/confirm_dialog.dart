import 'package:flutter/material.dart';

/// Diálogo de confirmación genérico. Devuelve `true` si se confirma.
Future<bool> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  String confirmLabel = 'Confirmar',
  String cancelLabel = 'Cancelar',
  IconData? icon,
  bool destructive = false,
  Widget? content,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) {
      final scheme = Theme.of(context).colorScheme;
      return AlertDialog(
        icon: icon == null ? null : Icon(icon, color: destructive ? scheme.error : scheme.primary),
        title: Text(title),
        content: content ??
            Text(message),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text(cancelLabel)),
          FilledButton(
            style: destructive
                ? FilledButton.styleFrom(
                    backgroundColor: scheme.error,
                    foregroundColor: scheme.onError,
                    minimumSize: const Size(0, 40),
                  )
                : FilledButton.styleFrom(minimumSize: const Size(0, 40)),
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(confirmLabel),
          ),
        ],
      );
    },
  );
  return result ?? false;
}
