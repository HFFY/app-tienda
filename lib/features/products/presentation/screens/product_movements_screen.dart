import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/date_formatter.dart';
import '../../../../core/widgets/async_value_widget.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../inventory/domain/entities/inventory_movement.dart';
import '../providers/product_providers.dart';

/// Kardex: todos los movimientos del producto con saldo acumulado.
class ProductMovementsScreen extends ConsumerWidget {
  const ProductMovementsScreen({super.key, required this.productId});

  final int productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(productByIdProvider(productId)).value;
    final async = ref.watch(productMovementsProvider(productId));
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(product == null ? 'Kardex' : 'Kardex · ${product.name}'),
      ),
      body: AsyncValueWidget(
        value: async,
        onRetry: () => ref.invalidate(productMovementsProvider(productId)),
        data: (movements) {
          if (movements.isEmpty) {
            return const EmptyState(
              icon: Icons.swap_vert,
              title: 'Sin movimientos',
              subtitle: 'Las entradas, salidas y ventas aparecerán aquí.',
            );
          }
          // Saldo acumulado en orden cronológico; se muestra del más reciente.
          final rows = <({InventoryMovement m, int balance})>[];
          var balance = 0;
          for (final m in movements) {
            balance += m.quantity;
            rows.add((m: m, balance: balance));
          }
          final reversed = rows.reversed.toList();

          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: reversed.length,
            separatorBuilder: (_, _) => const Divider(indent: 72),
            itemBuilder: (context, i) {
              final r = reversed[i];
              final m = r.m;
              final positive = m.isIncrease;
              final color = positive ? Colors.green.shade800 : scheme.error;
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: color.withValues(alpha: 0.15),
                  foregroundColor: color,
                  child: Icon(
                    switch (m.type) {
                      MovementType.in_ => Icons.arrow_downward,
                      MovementType.out => Icons.arrow_upward,
                      MovementType.adjustment => Icons.tune,
                    },
                    size: 20,
                  ),
                ),
                title: Text('${m.type.label} · ${m.reason.label}${m.saleId != null ? ' #${m.saleId}' : ''}'),
                subtitle: Text(
                  [
                    DateFormatter.dateTime(m.movedAt),
                    if (m.note != null && m.note!.isNotEmpty) m.note!,
                  ].join('\n'),
                ),
                isThreeLine: m.note != null && m.note!.isNotEmpty,
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${positive ? '+' : ''}${m.quantity}',
                      style: text.titleMedium?.copyWith(fontWeight: FontWeight.w700, color: color),
                    ),
                    Text('Saldo: ${r.balance}', style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant)),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
