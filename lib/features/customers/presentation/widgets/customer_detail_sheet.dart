import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/date_formatter.dart';
import '../../../../core/utils/whatsapp_launcher.dart';
import '../../../../core/widgets/app_snackbar.dart';
import '../../../../core/widgets/inactive_chip.dart';
import '../../../../core/widgets/initials_avatar.dart';
import '../../../../core/widgets/money_text.dart';
import '../../../store/presentation/providers/store_providers.dart';
import '../providers/customer_providers.dart';

/// Hoja inferior con el detalle del cliente: datos, historial de compras,
/// WhatsApp y accesos a editar / eliminar.
Future<void> showCustomerDetailSheet(
  BuildContext context, {
  required int customerId,
  required VoidCallback onEdit,
  required VoidCallback onDelete,
}) {
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (context) => _CustomerDetailSheet(
      customerId: customerId,
      onEdit: onEdit,
      onDelete: onDelete,
    ),
  );
}

class _CustomerDetailSheet extends ConsumerWidget {
  const _CustomerDetailSheet({
    required this.customerId,
    required this.onEdit,
    required this.onDelete,
  });

  final int customerId;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customerAsync = ref.watch(customerByIdProvider(customerId));
    final statsAsync = ref.watch(customerStatsProvider(customerId));
    final countryCode = ref.watch(storeControllerProvider.select((s) => s.whatsappCountryCode));
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    final customer = customerAsync.value;
    if (customer == null) {
      return const SizedBox(height: 200, child: Center(child: CircularProgressIndicator()));
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                InitialsAvatar(
                  initials: customer.initials,
                  seed: customer.fullName,
                  size: 56,
                  muted: !customer.isActive,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              customer.fullName,
                              style: text.titleLarge,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (!customer.isActive) ...[
                            const SizedBox(width: 8),
                            const InactiveChip(),
                          ],
                        ],
                      ),
                      Text(
                        customer.gender.label,
                        style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _InfoRow(
              icon: Icons.phone_outlined,
              label: 'Teléfono',
              value: customer.hasPhone ? customer.phone! : 'Sin teléfono',
            ),
            if (customer.notes != null && customer.notes!.isNotEmpty)
              _InfoRow(icon: Icons.notes_outlined, label: 'Notas', value: customer.notes!),
            _InfoRow(
              icon: Icons.calendar_today_outlined,
              label: 'Cliente desde',
              value: DateFormatter.date(customer.createdAt),
            ),
            const SizedBox(height: 12),
            statsAsync.when(
              loading: () => const LinearProgressIndicator(),
              error: (e, _) => const SizedBox.shrink(),
              data: (s) => Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: scheme.primaryContainer.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _Stat(
                        label: 'Compras',
                        child: Text('${s.salesCount}', style: text.titleLarge),
                      ),
                    ),
                    Expanded(
                      child: _Stat(
                        label: 'Total histórico',
                        child: MoneyText(s.totalSpent, style: text.titleLarge),
                      ),
                    ),
                    Expanded(
                      child: _Stat(
                        label: 'Última compra',
                        child: Text(
                          s.lastPurchaseAt == null ? '—' : DateFormatter.relativeDays(s.lastPurchaseAt!),
                          style: text.titleMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (customer.hasPhone)
              FilledButton.icon(
                onPressed: () async {
                  final ok = await WhatsAppLauncher.open(customer.phone!, countryCode: countryCode);
                  if (!ok && context.mounted) {
                    AppSnackBar.show(context, 'No se pudo abrir WhatsApp.');
                  }
                },
                icon: const Icon(Icons.chat_outlined),
                label: const Text('Escribir por WhatsApp'),
              ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onEdit();
                    },
                    icon: const Icon(Icons.edit_outlined),
                    label: const Text('Editar'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onDelete();
                    },
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('Eliminar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.label, required this.value});

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: scheme.onSurfaceVariant),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: text.labelSmall?.copyWith(color: scheme.onSurfaceVariant)),
                Text(value, style: text.bodyLarge),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: text.labelSmall?.copyWith(color: scheme.onSurfaceVariant)),
        const SizedBox(height: 2),
        child,
      ],
    );
  }
}
