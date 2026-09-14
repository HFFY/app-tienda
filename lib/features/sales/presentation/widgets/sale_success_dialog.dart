import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/widgets/money_text.dart';
import '../../domain/entities/sale.dart';

/// Diálogo de éxito con check animado y resumen de la venta.
Future<void> showSaleSuccessDialog(BuildContext context, Sale sale) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (context) => _SaleSuccessDialog(sale: sale),
  );
}

class _SaleSuccessDialog extends StatelessWidget {
  const _SaleSuccessDialog({required this.sale});

  final Sale sale;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(color: Colors.green.withValues(alpha: 0.15), shape: BoxShape.circle),
            child: const Icon(Icons.check_rounded, size: 52, color: Colors.green),
          )
              .animate()
              .scale(begin: const Offset(0.4, 0.4), end: const Offset(1, 1), duration: 450.ms, curve: Curves.elasticOut)
              .fadeIn(duration: 200.ms),
          const SizedBox(height: 16),
          Text('¡Venta registrada!', style: text.titleLarge).animate().fadeIn(delay: 150.ms),
          const SizedBox(height: 4),
          Text(
            'Venta #${sale.id} · ${DateFormatter.shortDateTime(sale.saleDate)}',
            style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (sale.customerName != null) _row(Icons.person_outline, sale.customerName!, text),
                _row(
                  Icons.shopping_bag_outlined,
                  '${sale.items.length} ítem${sale.items.length == 1 ? '' : 's'} · ${sale.unitsSold} unidad${sale.unitsSold == 1 ? '' : 'es'}',
                  text,
                ),
                if (sale.discountAmount > 0)
                  Row(
                    children: [
                      Icon(Icons.percent, size: 18, color: scheme.onSurfaceVariant),
                      const SizedBox(width: 8),
                      const Text('Descuento: '),
                      MoneyText(sale.discountAmount),
                    ],
                  ),
                const Divider(height: 16),
                Row(
                  children: [
                    Text('Total', style: text.titleMedium),
                    const Spacer(),
                    MoneyText(
                      sale.total,
                      style: text.titleLarge?.copyWith(color: scheme.primary, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ],
            ),
          ).animate().fadeIn(delay: 250.ms).slideY(begin: 0.1, end: 0),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            context.go(Routes.reports);
          },
          child: const Text('Ver reportes'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(minimumSize: const Size(0, 40)),
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Nueva venta'),
        ),
      ],
    );
  }

  Widget _row(IconData icon, String value, TextTheme text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 8),
          Expanded(child: Text(value, style: text.bodyMedium)),
        ],
      ),
    );
  }
}
