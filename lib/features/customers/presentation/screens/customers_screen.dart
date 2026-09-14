import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/widgets/app_snackbar.dart';
import '../../../../core/widgets/async_value_widget.dart';
import '../../../../core/widgets/delete_or_deactivate_dialog.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/inactive_chip.dart';
import '../../../../core/widgets/search_field.dart';
import '../../domain/entities/customer.dart';
import '../controllers/customer_mutations.dart';
import '../providers/customer_providers.dart';
import '../widgets/customer_detail_sheet.dart';
import '../widgets/customer_tile.dart';

class CustomersScreen extends ConsumerWidget {
  const CustomersScreen({super.key});

  Future<void> _deleteOrDeactivate(BuildContext context, WidgetRef ref, Customer c) async {
    final refs = await ref.read(deleteOrDeactivateCustomerProvider).references(c.id);
    if (!context.mounted) return;
    final count = refs.valueOrNull ?? 0;

    final choice = await showDeleteOrDeactivateDialog(
      context,
      entityLabel: 'el cliente',
      entityName: c.fullName,
      referenceCount: count,
      referenceDescription: 'Tiene $count venta${count == 1 ? '' : 's'} registrada${count == 1 ? '' : 's'}',
      isActive: c.isActive,
    );
    if (choice == null || !context.mounted) return;

    final mutations = ref.read(customerMutationsProvider.notifier);
    final failure = switch (choice) {
      DeleteAction.delete => await mutations.delete(c.id),
      DeleteAction.deactivate => await mutations.setActive(c.id, false),
    };
    if (!context.mounted) return;
    if (failure != null) {
      AppSnackBar.failure(context, failure);
    } else {
      AppSnackBar.show(
        context,
        choice == DeleteAction.delete ? 'Cliente eliminado.' : 'Cliente desactivado.',
      );
    }
  }

  Future<void> _onAction(
    BuildContext context,
    WidgetRef ref,
    Customer c,
    CustomerMenuAction action,
  ) async {
    switch (action) {
      case CustomerMenuAction.edit:
        await context.push<int>(Routes.customerEdit(c.id));
      case CustomerMenuAction.toggleActive:
        final failure =
            await ref.read(customerMutationsProvider.notifier).setActive(c.id, !c.isActive);
        if (!context.mounted) return;
        if (failure != null) {
          AppSnackBar.failure(context, failure);
        } else {
          AppSnackBar.show(context, c.isActive ? 'Cliente desactivado.' : 'Cliente activado.');
        }
      case CustomerMenuAction.delete:
        await _deleteOrDeactivate(context, ref, c);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(customerFilterProvider);
    final async = ref.watch(customersProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'fab-customers',
        onPressed: () => context.push<int>(Routes.customerNew),
        icon: const Icon(Icons.person_add_alt_1),
        label: const Text('Crear cliente'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: SearchField(
              hintText: 'Buscar por nombre o teléfono',
              initialValue: filter.query,
              onChanged: ref.read(customerFilterProvider.notifier).setQuery,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: ActiveFilterToggle(
                value: filter.showInactive,
                onChanged: ref.read(customerFilterProvider.notifier).setShowInactive,
              ),
            ),
          ),
          Expanded(
            child: AsyncValueWidget(
              value: async,
              onRetry: () => ref.invalidate(customersProvider),
              data: (customers) {
                if (customers.isEmpty) {
                  return EmptyState(
                    icon: Icons.people_outline,
                    title: filter.query.isEmpty ? 'Sin clientes' : 'Sin resultados',
                    subtitle: filter.query.isEmpty
                        ? 'Registra a tu primer cliente para empezar a vender.'
                        : 'Ningún cliente coincide con "${filter.query}".',
                    actionLabel: filter.query.isEmpty ? 'Crear cliente' : null,
                    onAction: filter.query.isEmpty ? () => context.push<int>(Routes.customerNew) : null,
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.only(bottom: 96),
                  itemCount: customers.length,
                  separatorBuilder: (_, _) => const Divider(indent: 72),
                  itemBuilder: (context, i) {
                    final c = customers[i];
                    final tile = CustomerTile(
                      key: ValueKey(c.id),
                      customer: c,
                      onTap: () => showCustomerDetailSheet(
                        context,
                        customerId: c.id,
                        onEdit: () => context.push<int>(Routes.customerEdit(c.id)),
                        onDelete: () => _deleteOrDeactivate(context, ref, c),
                      ),
                      onAction: (a) => _onAction(context, ref, c, a),
                    );
                    // Entrada escalonada solo para los primeros elementos.
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
