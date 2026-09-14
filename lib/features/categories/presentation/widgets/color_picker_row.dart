import 'package:flutter/material.dart';

import '../../../../core/theme/category_icons.dart';

/// Fila de círculos de color de la paleta fija.
class ColorPickerRow extends StatelessWidget {
  const ColorPickerRow({super.key, required this.selected, required this.onSelected});

  final String? selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        for (final hex in kCategoryColors)
          _ColorDot(
            color: colorFromHex(hex)!,
            selected: hex.toUpperCase() == selected?.toUpperCase(),
            onTap: () => onSelected(hex),
            checkColor: scheme.surface,
          ),
      ],
    );
  }
}

class _ColorDot extends StatelessWidget {
  const _ColorDot({
    required this.color,
    required this.selected,
    required this.onTap,
    required this.checkColor,
  });

  final Color color;
  final bool selected;
  final VoidCallback onTap;
  final Color checkColor;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: 'Color',
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(
              color: selected ? Theme.of(context).colorScheme.onSurface : Colors.transparent,
              width: 3,
            ),
          ),
          child: selected ? Icon(Icons.check, color: checkColor, size: 20) : null,
        ),
      ),
    );
  }
}
