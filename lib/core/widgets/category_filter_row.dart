import 'package:flutter/material.dart';

import '../../features/categories/domain/entities/category.dart';
import '../theme/category_icons.dart';

/// Fila horizontal de `FilterChip`: "Todas" + una por categoría.
class CategoryFilterRow extends StatelessWidget {
  const CategoryFilterRow({
    super.key,
    required this.categories,
    required this.selectedId,
    required this.onSelected,
  });

  final List<Category> categories;
  final int? selectedId;
  final ValueChanged<int?> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: const Text('Todas'),
              selected: selectedId == null,
              onSelected: (_) => onSelected(null),
            ),
          ),
          for (final c in categories)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                avatar: Icon(
                  categoryIconFor(c.iconCode),
                  size: 18,
                  color: colorFromHex(c.colorHex),
                ),
                label: Text(c.name),
                selected: selectedId == c.id,
                onSelected: (_) => onSelected(selectedId == c.id ? null : c.id),
              ),
            ),
        ],
      ),
    );
  }
}
