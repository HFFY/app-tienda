import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/theme/category_icons.dart';
import '../../../categories/domain/entities/category.dart';
import '../../../categories/presentation/providers/category_providers.dart';

/// Selector de categoría con la opción "+ Nueva categoría" en línea, que
/// abre el formulario y selecciona la categoría recién creada.
class CategoryDropdown extends ConsumerWidget {
  const CategoryDropdown({
    super.key,
    required this.scope,
    required this.value,
    required this.onChanged,
  });

  final CategoryScope scope;
  final int? value;
  final ValueChanged<int?> onChanged;

  static const _newSentinel = -1;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(categoriesForScopeProvider(scope));
    final categories = async.value ?? const <Category>[];
    // Si el valor actual ya no está (inactiva), igual se muestra para no perderlo.
    final knownIds = categories.map((c) => c.id).toSet();
    final effectiveValue = (value != null && !knownIds.contains(value)) ? null : value;

    return DropdownButtonFormField<int?>(
      initialValue: effectiveValue,
      decoration: const InputDecoration(labelText: 'Categoría', prefixIcon: Icon(Icons.category_outlined)),
      items: [
        const DropdownMenuItem<int?>(value: null, child: Text('Sin categoría')),
        for (final c in categories)
          DropdownMenuItem<int?>(
            value: c.id,
            child: Row(
              children: [
                Icon(categoryIconFor(c.iconCode), size: 18, color: colorFromHex(c.colorHex)),
                const SizedBox(width: 8),
                Text(c.name),
              ],
            ),
          ),
        DropdownMenuItem<int?>(
          value: _newSentinel,
          child: Row(
            children: [
              Icon(Icons.add, size: 18, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                'Nueva categoría',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
        ),
      ],
      onChanged: (v) async {
        if (v == _newSentinel) {
          final created = await context.push<int>('${Routes.categoryNew}?scope=${scope.dbValue}');
          if (created != null) onChanged(created);
          return;
        }
        onChanged(v);
      },
    );
  }
}
