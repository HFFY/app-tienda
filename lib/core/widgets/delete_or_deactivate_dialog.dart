import 'package:flutter/material.dart';

enum DeleteAction { delete, deactivate }

/// Popup único para "eliminar o desactivar" clientes, productos, servicios
/// y categorías.
///
/// - Sin referencias: ofrece Eliminar o Desactivar.
/// - Con referencias y [allowDeleteWhenReferenced] = false: solo Desactivar.
/// - Con referencias y [allowDeleteWhenReferenced] = true (categorías):
///   avisa el impacto y ofrece ambas.
///
/// Devuelve `null` si se cancela.
Future<DeleteAction?> showDeleteOrDeactivateDialog(
  BuildContext context, {
  required String entityLabel,
  required String entityName,
  required int referenceCount,
  String? referenceDescription,
  bool allowDeleteWhenReferenced = false,
  bool isActive = true,
}) {
  final referenced = referenceCount > 0;
  final canDelete = !referenced || allowDeleteWhenReferenced;

  final String body;
  if (!referenced) {
    body = 'Puedes eliminar $entityLabel "$entityName" definitivamente, o solo desactivar '
        'el registro para que deje de aparecer en las listas de selección.';
  } else if (allowDeleteWhenReferenced) {
    body = '${referenceDescription ?? 'Tiene $referenceCount registros asociados'}. '
        'Si eliminas la categoría quedarán "Sin categoría". También puedes desactivarla.';
  } else {
    body = '${referenceDescription ?? 'Tiene $referenceCount transacciones registradas'} '
        'y no puede eliminarse para conservar el historial. Puedes desactivar el registro.';
  }

  return showDialog<DeleteAction>(
    context: context,
    builder: (context) {
      final scheme = Theme.of(context).colorScheme;
      return AlertDialog(
        icon: Icon(
          canDelete ? Icons.delete_outline : Icons.visibility_off_outlined,
          color: scheme.primary,
        ),
        title: Text(canDelete ? '¿Eliminar o desactivar?' : 'No se puede eliminar'),
        content: Text(body),
        actionsAlignment: MainAxisAlignment.end,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          if (isActive)
            TextButton(
              onPressed: () => Navigator.of(context).pop(DeleteAction.deactivate),
              child: const Text('Desactivar'),
            ),
          if (canDelete)
            FilledButton.tonal(
              style: FilledButton.styleFrom(
                foregroundColor: scheme.onErrorContainer,
                backgroundColor: scheme.errorContainer,
                minimumSize: const Size(0, 40),
              ),
              onPressed: () => Navigator.of(context).pop(DeleteAction.delete),
              child: const Text('Eliminar'),
            ),
        ],
      );
    },
  );
}
