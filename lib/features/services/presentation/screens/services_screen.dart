import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/widgets/app_snackbar.dart';
import '../../../../core/widgets/async_value_widget.dart';
import '../../../../core/widgets/category_filter_row.dart';
import '../../../../core/widgets/delete_or_deactivate_dialog.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/inactive_chip.dart';
import '../../../../core/widgets/search_field.dart';
import '../../../categories/domain/entities/category.dart';
import '../../../categories/presentation/providers/category_providers.dart';
import '../../domain/entities/service.dart';
import '../controllers/service_mutations.dart';
import '../providers/service_providers.dart';
import '../widgets/service_tile.dart';

class ServicesScreen extends ConsumerWidget {
  const ServicesScreen({super.key});

  Future<void> _deleteOrDeactivate(BuildContext context, WidgetRef ref, Service s) async {
    final refs = await ref.read(deleteOrDeactivateServiceProvider).references(s.id);
    if (!context.mounted) return;
    final count = refs.valueOrNull ?? 0;

    final choice = await showDeleteOrDeactivateDialog(
      context,
      entityLabel: 'el servicio',
      entityName: s.name,
      referenceCount: count,
      referenceDescription: 'Aparece en $count venta${count == 1 ? '' : 's'}',
      isActive: s.isActive,
    );
    if (choice == null || !context.mounted) return;

    final mutations = ref.read(serviceMutationsProvider.notifier);
    final failure = switch (choice) {
      DeleteAction.delete => await mutations.delete(s),
      DeleteAction.deactivate => await mutations.setActive(s.id, false),
    };
    if (!context.mounted) return;
    if (failure != null) {
      AppSnackBar.failure(context, failure);
    } else {
      AppSnackBar.show(context, choice == DeleteAction.delete ? 'Servicio eliminado.' : 'Servicio desactivado.');
    }
  }

  Future<void> _onAction(BuildContext context, WidgetRef ref, Service s, ServiceMenuAction a) async {
    switch (a) {
      case ServiceMenuAction.edit:
        await context.push<int>(Routes.serviceEdit(s.id));
      case ServiceMenuAction.toggleActive:
        final failure = await ref.read(serviceMutationsProvider.notifier).setActive(s.id, !s.isActive);
        if (!context.mounted) return;
        if (failure != null) {
          AppSnackBar.failure(context, failure);
        } else {
          AppSnackBar.show(context, s.isActive ? 'Servicio desactivado.' : 'Servicio activado.');
        }
      case ServiceMenuAction.delete:
        await _deleteOrDeactivate(context, ref, s);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(serviceFilterProvider);
    final filterCtl = ref.read(serviceFilterProvider.notifier);
    final async = ref.watch(servicesProvider);
    final categories = ref.watch(categoriesForScopeProvider(CategoryScope.service)).value ?? const [];

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'fab-services',
        onPressed: () => context.push<int>(Routes.serviceNew),
        icon: const Icon(Icons.add),
        label: const Text('Crear servicio'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: SearchField(
              hintText: 'Buscar servicio',
              initialValue: filter.query,
              onChanged: filterCtl.setQuery,
            ),
          ),
          CategoryFilterRow(
            categories: categories,
            selectedId: filter.categoryId,
            onSelected: filterCtl.setCategory,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: ActiveFilterToggle(value: filter.showInactive, onChanged: filterCtl.setShowInactive),
            ),
          ),
          Expanded(
            child: AsyncValueWidget(
              value: async,
              onRetry: () => ref.invalidate(servicesProvider),
              data: (services) {
                if (services.isEmpty) {
                  final filtered = filter.query.isNotEmpty || filter.categoryId != null;
                  return EmptyState(
                    icon: Icons.design_services_outlined,
                    title: filtered ? 'Sin resultados' : 'Sin servicios',
                    subtitle: filtered
                        ? 'Ningún servicio coincide con el filtro.'
                        : 'Crea tu primer servicio para ofrecerlo en las ventas.',
                    actionLabel: filtered ? null : 'Crear servicio',
                    onAction: filtered ? null : () => context.push<int>(Routes.serviceNew),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.only(bottom: 96, top: 4),
                  itemCount: services.length,
                  separatorBuilder: (_, _) => const Divider(indent: 84),
                  itemBuilder: (context, i) {
                    final s = services[i];
                    final tile = ServiceTile(
                      key: ValueKey(s.id),
                      service: s,
                      onTap: () => context.push<int>(Routes.serviceEdit(s.id)),
                      onAction: (a) => _onAction(context, ref, s, a),
                    );
                    if (i >= 12) return tile;
                    return tile
                        .animate()
                        .fadeIn(duration: 250.ms, delay: (35 * i).ms)
                        .slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
