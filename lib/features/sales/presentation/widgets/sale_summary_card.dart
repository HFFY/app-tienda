import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/animated_counter.dart';
import '../../../../core/widgets/money_text.dart';
import '../providers/sale_providers.dart';

/// Tarjeta fija al pie con subtotales, descuento y TOTAL animado.
class SaleSummaryCard extends ConsumerWidget {
  const SaleSummaryCard({super.key, required this.onRegister, required this.enabled, required this.loading});

  final VoidCallback onRegister;
  final bool enabled;
  final bool loading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totals = ref.watch(saleTotalsProvider);
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Material(
      elevation: 8,
      color: scheme.surfaceContainerLow,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _line('Productos', totals.subtotalProducts, text),
              _line('Servicios', totals.subtotalServices, text),
              if (totals.discountAmount > 0)
                _line('Descuento', -totals.discountAmount, text, color: scheme.error),
              const Divider(height: 16),
              Row(
                children: [
                  Text('TOTAL', style: text.titleMedium?.copyWith(fontWeight: FontWeight.w800, letterSpacing: 1)),
                  const Spacer(),
                  AnimatedMoneyText(
                    totals.total,
                    style: text.headlineMedium?.copyWith(color: scheme.primary, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: enabled && !loading ? onRegister : null,
                icon: loading
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2.5))
                    : const Icon(Icons.point_of_sale),
                label: const Text('Registrar venta'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _line(String label, double amount, TextTheme text, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(label, style: text.bodyMedium?.copyWith(color: color)),
          const Spacer(),
          MoneyText(amount, style: text.bodyMedium?.copyWith(color: color)),
        ],
      ),
    );
  }
}
