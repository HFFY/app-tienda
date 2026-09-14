import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/app_snackbar.dart';
import '../../../../core/widgets/money_text.dart';
import '../../../store/presentation/providers/store_providers.dart';
import '../../domain/entities/cart.dart';
import '../providers/sale_providers.dart';

/// Ítems del carrito con stepper de cantidad y deslizar para eliminar.
class CartList extends ConsumerWidget {
  const CartList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(cartControllerProvider.select((c) => c.items));
    final ctl = ref.read(cartControllerProvider.notifier);
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        for (var i = 0; i < items.length; i++)
          Dismissible(
            key: ValueKey(items[i].key),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              color: scheme.errorContainer,
              child: Icon(Icons.delete_outline, color: scheme.onErrorContainer),
            ),
            onDismissed: (_) {
              final removed = items[i];
              final index = i;
              ctl.remove(removed.key);
              AppSnackBar.show(
                context,
                '"${removed.name}" quitado del carrito.',
                action: SnackBarAction(label: 'Deshacer', onPressed: () => ctl.restore(removed, index)),
              );
            },
            child: _CartRow(item: items[i]),
          ),
      ],
    );
  }
}

class _CartRow extends ConsumerWidget {
  const _CartRow({required this.item});

  final CartItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ctl = ref.read(cartControllerProvider.notifier);
    final fmt = ref.watch(moneyFormatterProvider);
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    final subtitle = [
      '${fmt.format(item.unitPrice)} c/u',
      if (item.availableStock != null) '${item.availableStock} disp.',
    ].join(' · ');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Icon(
            item.isProduct ? Icons.inventory_2_outlined : Icons.design_services_outlined,
            color: scheme.onSurfaceVariant,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: text.bodyLarge),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          _StepperButton(icon: Icons.remove, onTap: item.quantity > 1 ? () => ctl.decrement(item.key) : null),
          SizedBox(
            width: 28,
            child: Text('${item.quantity}', textAlign: TextAlign.center, style: text.titleMedium),
          ),
          _StepperButton(icon: Icons.add, onTap: item.canIncrement ? () => ctl.increment(item.key) : null),
          const SizedBox(width: 6),
          SizedBox(
            width: 76,
            child: MoneyText(
              item.lineTotal,
              textAlign: TextAlign.right,
              maxLines: 1,
              style: text.titleSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepperButton extends StatelessWidget {
  const _StepperButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: 32,
      height: 32,
      child: IconButton.filledTonal(
        padding: EdgeInsets.zero,
        iconSize: 18,
        onPressed: onTap,
        icon: Icon(icon),
        style: IconButton.styleFrom(
          backgroundColor: onTap == null ? scheme.surfaceContainerHighest : null,
        ),
      ),
    );
  }
}
