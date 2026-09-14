import 'package:flutter/material.dart';

/// Etiqueta pequeña "Inactivo/a".
class InactiveChip extends StatelessWidget {
  const InactiveChip({super.key, this.label = 'Inactivo'});

  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(label, style: TextStyle(fontSize: 11, color: scheme.onSurfaceVariant)),
    );
  }
}

/// Interruptor "Mostrar inactivos" para las barras de filtro.
class ActiveFilterToggle extends StatelessWidget {
  const ActiveFilterToggle({super.key, required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: const Text('Mostrar inactivos'),
      selected: value,
      onSelected: onChanged,
      showCheckmark: true,
      avatar: value ? null : const Icon(Icons.visibility_off_outlined, size: 18),
    );
  }
}
