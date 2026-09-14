import 'package:flutter/material.dart';

import '../../../../core/theme/category_icons.dart';

/// Rejilla de íconos de la tabla fija `kCategoryIcons`.
class IconPickerGrid extends StatelessWidget {
  const IconPickerGrid({
    super.key,
    required this.selectedCodePoint,
    required this.onSelected,
    this.tint,
  });

  final int? selectedCodePoint;
  final ValueChanged<int> onSelected;
  final Color? tint;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = tint ?? scheme.primary;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 56,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: kCategoryIcons.length,
      itemBuilder: (context, i) {
        final icon = kCategoryIcons[i];
        final selected = icon.codePoint == selectedCodePoint;
        return Semantics(
          button: true,
          selected: selected,
          child: Material(
            color: selected ? color.withValues(alpha: 0.18) : scheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => onSelected(icon.codePoint),
              child: Icon(icon, color: selected ? color : scheme.onSurfaceVariant),
            ),
          ),
        );
      },
    );
  }
}
