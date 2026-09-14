import 'package:flutter/material.dart';

import '../../../../core/theme/category_icons.dart';
import '../../domain/entities/category.dart';

enum CategoryMenuAction { edit, toggleActive, delete }

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    super.key,
    required this.usage,
    required this.index,
    required this.onTap,
    required this.onAction,
  });

  final CategoryUsage usage;
  final int index;
  final VoidCallback onTap;
  final ValueChanged<CategoryMenuAction> onAction;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final c = usage.category;
    final color = colorFromHex(c.colorHex) ?? scheme.primary;

    final parts = <String>[
      c.scope.label,
      if (usage.productCount > 0) '${usage.productCount} producto${usage.productCount == 1 ? '' : 's'}',
      if (usage.serviceCount > 0) '${usage.serviceCount} servicio${usage.serviceCount == 1 ? '' : 's'}',
    ];

    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: color.withValues(alpha: c.isActive ? 0.18 : 0.08),
        foregroundColor: c.isActive ? color : scheme.outline,
        child: Icon(categoryIconFor(c.iconCode)),
      ),
      title: Row(
        children: [
          Flexible(
            child: Text(
              c.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: c.isActive ? null : scheme.outline),
            ),
          ),
          if (!c.isActive) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'Inactiva',
                style: TextStyle(fontSize: 11, color: scheme.onSurfaceVariant),
              ),
            ),
          ],
        ],
      ),
      subtitle: Text(parts.join(' · ')),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          PopupMenuButton<CategoryMenuAction>(
            tooltip: 'Opciones',
            onSelected: onAction,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: CategoryMenuAction.edit,
                child: ListTile(leading: Icon(Icons.edit_outlined), title: Text('Editar')),
              ),
              PopupMenuItem(
                value: CategoryMenuAction.toggleActive,
                child: ListTile(
                  leading: Icon(c.isActive ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                  title: Text(c.isActive ? 'Desactivar' : 'Activar'),
                ),
              ),
              const PopupMenuItem(
                value: CategoryMenuAction.delete,
                child: ListTile(leading: Icon(Icons.delete_outline), title: Text('Eliminar')),
              ),
            ],
          ),
          ReorderableDragStartListener(
            index: index,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: Icon(Icons.drag_handle),
            ),
          ),
        ],
      ),
    );
  }
}
