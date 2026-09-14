import 'package:flutter/material.dart';

import '../theme/category_icons.dart';

/// Chip compacto con el color e ícono de una categoría, o "Sin categoría".
class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    this.name,
    this.colorHex,
    this.iconCode,
    this.compact = false,
  });

  final String? name;
  final String? colorHex;
  final int? iconCode;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = colorFromHex(colorHex) ?? scheme.outline;
    final label = name ?? 'Sin categoría';
    final fontSize = compact ? 11.0 : 12.0;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: compact ? 6 : 8, vertical: compact ? 2 : 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(categoryIconFor(iconCode), size: fontSize + 3, color: color),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
