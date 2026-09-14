import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/widgets/app_snackbar.dart';
import '../../../../core/widgets/async_value_widget.dart';
import '../../../../core/widgets/delete_or_deactivate_dialog.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../domain/entities/category.dart';
import '../controllers/category_form_controller.dart';
import '../providers/category_providers.dart';
import '../widgets/category_tile.dart';

class CategoriesScreen extends ConsumerStatefulWidget {
  const CategoriesScreen({super.key});

  @override
  ConsumerState<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends ConsumerState<CategoriesScreen> {
  /// Copia local para reordenar de forma optimista.
  List<CategoryUsage>? _items;

  Future<void> _onReorder(int oldIndex, int newIndex) async {
    // onReorderItem ya entrega newIndex ajustado por el ítem removido.
    final list = List<CategoryUsage>.of(_items!);
    final moved = list.removeAt(oldIndex);
    list.insert(newIndex, moved);
    setState(() => _items = list);

    final failure = await ref
        .read(categoryMutationsProvider.notifier)
        .reorder(list.map((u) => u.category.id).toList());
    if (failure != null && mounted) AppSnackBar.failure(context, failure);
  }

  Future<void> _onAction(CategoryUsage usage, CategoryMenuAction action) async {
    final c = usage.category;
    final mutations = ref.read(categoryMutationsProvider.notifier);
    switch (action) {
      case CategoryMenuAction.edit:
        await context.push<int>(Routes.categoryEdit(c.id));
      case CategoryMenuAction.toggleActive:
        final failure = await mutations.setActive(c.id, !c.isActive);
        if (!mounted) return;
        if (failure != null) {
          AppSnackBar.failure(context, failure);
        } else {
          AppSnackBar.show(context, c.isActive ? 'Categoría desactivada.' : 'Categoría activada.');
        }
      case CategoryMenuAction.delete:
        final choice = await showDeleteOrDeactivateDialog(
          context,
          entityLabel: 'la categoría',
          entityName: c.name,
          referenceCount: usage.total,
          referenceDescription: _usageText(usage),
          allowDeleteWhenReferenced: true,
          isActive: c.isActive,
        );
        if (choice == null || !mounted) return;
        final failure = switch (choice) {
          DeleteAction.delete => await mutations.delete(c.id),
          DeleteAction.deactivate => await mutations.setActive(c.id, false),
        };
        if (!mounted) return;
        if (failure != null) {
          AppSnackBar.failure(context, failure);
        } else {
          AppSnackBar.show(
            context,
            choice == DeleteAction.delete ? 'Categoría eliminada.' : 'Categoría desactivada.',
          );
        }
    }
  }

  String _usageText(CategoryUsage u) {
    final parts = <String>[
      if (u.productCount > 0) '${u.productCount} producto${u.productCount == 1 ? '' : 's'}',
      if (u.serviceCount > 0) '${u.serviceCount} servicio${u.serviceCount == 1 ? '' : 's'}',
    ];
    return 'La usan ${parts.join(' y ')}';
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(categoriesWithUsageProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Categorías')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push<int>(Routes.categoryNew),
        icon: const Icon(Icons.add),
        label: const Text('Crear categoría'),
      ),
      body: AsyncValueWidget(
        value: async,
        onRetry: () => ref.invalidate(categoriesWithUsageProvider),
        data: (items) {
          // Sincronizar la copia local cuando llegan datos nuevos.
          _items = items;
          if (items.isEmpty) {
            return EmptyState(
              icon: Icons.category_outlined,
              title: 'Sin categorías',
              subtitle: 'Crea categorías para organizar tus productos y servicios.',
              actionLabel: 'Crear categoría',
              onAction: () => context.push<int>(Routes.categoryNew),
            );
          }
          return ReorderableListView.builder(
            padding: const EdgeInsets.only(bottom: 96),
            buildDefaultDragHandles: false,
            itemCount: items.length,
            onReorderItem: _onReorder,
            itemBuilder: (context, index) {
              final usage = items[index];
              return CategoryTile(
                key: ValueKey(usage.category.id),
                usage: usage,
                index: index,
                onTap: () => context.push<int>(Routes.categoryEdit(usage.category.id)),
                onAction: (a) => _onAction(usage, a),
              );
            },
          );
        },
      ),
    );
  }
}
