import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/widgets/initials_avatar.dart';
import '../../../../core/widgets/search_field.dart';
import '../../../customers/domain/entities/customer.dart';
import '../../../customers/presentation/providers/customer_providers.dart';
import '../providers/sale_providers.dart';

/// Sección "Cliente" de la venta: muestra el seleccionado o abre el selector.
class CustomerSection extends ConsumerWidget {
  const CustomerSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customer = ref.watch(cartControllerProvider.select((c) => c.customer));
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Card(
      child: ListTile(
        onTap: () => _pick(context, ref),
        leading: customer == null
            ? CircleAvatar(
                backgroundColor: scheme.primaryContainer,
                foregroundColor: scheme.onPrimaryContainer,
                child: const Icon(Icons.person_search_outlined),
              )
            : InitialsAvatar(initials: customer.initials, seed: customer.fullName),
        title: Text(
          customer?.fullName ?? 'Seleccionar cliente',
          style: text.titleMedium,
        ),
        subtitle: Text(
          customer == null
              ? 'Obligatorio para registrar la venta'
              : (customer.hasPhone ? customer.phone! : 'Sin teléfono'),
        ),
        trailing: customer == null
            ? const Icon(Icons.chevron_right)
            : IconButton(
                tooltip: 'Quitar cliente',
                icon: const Icon(Icons.close),
                onPressed: () => ref.read(cartControllerProvider.notifier).setCustomer(null),
              ),
      ),
    );
  }

  Future<void> _pick(BuildContext context, WidgetRef ref) async {
    final selected = await showModalBottomSheet<Customer>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => const _CustomerPickerSheet(),
    );
    if (selected != null) ref.read(cartControllerProvider.notifier).setCustomer(selected);
  }
}

class _CustomerPickerSheet extends ConsumerStatefulWidget {
  const _CustomerPickerSheet();

  @override
  ConsumerState<_CustomerPickerSheet> createState() => _CustomerPickerSheetState();
}

class _CustomerPickerSheetState extends ConsumerState<_CustomerPickerSheet> {
  String _query = '';

  Future<void> _create() async {
    final id = await context.push<int>(Routes.customerNew);
    if (id == null || !mounted) return;
    final result = await ref.read(customerRepositoryProvider).findById(id);
    final created = result.valueOrNull;
    if (created != null && mounted) Navigator.of(context).pop(created);
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(activeCustomersProvider);
    final q = _query.trim().toLowerCase();

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.75,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (context, scrollController) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Row(
              children: [
                Expanded(
                  child: SearchField(
                    hintText: 'Buscar cliente',
                    onChanged: (v) => setState(() => _query = v),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton.tonalIcon(
                  style: FilledButton.styleFrom(minimumSize: const Size(0, 48)),
                  onPressed: _create,
                  icon: const Icon(Icons.person_add_alt_1),
                  label: const Text('Nuevo'),
                ),
              ],
            ),
          ),
          Expanded(
            child: async.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
              data: (customers) {
                final filtered = customers
                    .where((c) => q.isEmpty || c.fullName.toLowerCase().contains(q) || (c.phone ?? '').contains(q))
                    .toList();
                if (filtered.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        customers.isEmpty ? 'Todavía no hay clientes. Crea el primero.' : 'Sin resultados.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  controller: scrollController,
                  itemCount: filtered.length,
                  itemBuilder: (context, i) {
                    final c = filtered[i];
                    return ListTile(
                      leading: InitialsAvatar(initials: c.initials, seed: c.fullName),
                      title: Text(c.fullName),
                      subtitle: Text(c.hasPhone ? c.phone! : 'Sin teléfono'),
                      onTap: () => Navigator.of(context).pop(c),
                    );
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
