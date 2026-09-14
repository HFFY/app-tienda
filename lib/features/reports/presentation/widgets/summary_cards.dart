import 'package:flutter/material.dart';

import '../../../../core/widgets/animated_counter.dart';
import '../../../../core/widgets/initials_avatar.dart';
import '../../../../core/widgets/money_text.dart';
import '../../domain/entities/monthly_report.dart';

/// Cuatro tarjetas de resumen en `GridView.count(crossAxisCount: 2)`.
class SummaryCards extends StatelessWidget {
  const SummaryCards({super.key, required this.report});

  final MonthlyReport report;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final top = report.topCustomer;

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.15,
      children: [
        _StatCard(
          icon: Icons.payments_outlined,
          label: 'Ingreso bruto',
          value: AnimatedMoneyText(
            report.grossTotal,
            style: text.titleLarge?.copyWith(fontWeight: FontWeight.w800, color: scheme.primary),
          ),
          footer: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _MiniLine('Productos', report.productsGross, text),
              _MiniLine('Servicios', report.servicesGross, text),
            ],
          ),
        ),
        _StatCard(
          icon: Icons.receipt_long_outlined,
          label: 'Ventas',
          value: AnimatedCounter(
            report.salesCount,
            style: text.headlineSmall?.copyWith(fontWeight: FontWeight.w800, color: scheme.primary),
          ),
          footer: Text(
            '${report.unitsSold} unidad${report.unitsSold == 1 ? '' : 'es'} vendida${report.unitsSold == 1 ? '' : 's'}',
            style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
          ),
        ),
        _StatCard(
          icon: Icons.emoji_events_outlined,
          label: 'Mejor cliente',
          fitValue: false,
          value: top == null
              ? Text('—', style: text.titleLarge)
              : Row(
                  children: [
                    InitialsAvatar(initials: _initials(top.name), seed: top.name, size: 32),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        top.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: text.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
          footer: top == null
              ? Text('Sin ventas este mes', style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant))
              : Row(
                  children: [
                    Text('${top.purchases} compra${top.purchases == 1 ? '' : 's'} · ', style: text.bodySmall),
                    Flexible(child: MoneyText(top.spent, style: text.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis)),
                  ],
                ),
        ),
        _StatCard(
          icon: Icons.sell_outlined,
          label: 'Descuentos',
          value: AnimatedMoneyText(
            report.discountsGiven,
            style: text.titleLarge?.copyWith(fontWeight: FontWeight.w800, color: scheme.primary),
          ),
          footer: Row(
            children: [
              Text('Neto: ', style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant)),
              Flexible(child: MoneyText(report.netTotal, style: text.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis)),
            ],
          ),
        ),
      ],
    );
  }

  static String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.footer,
    this.fitValue = true,
  });

  final IconData icon;
  final String label;
  final Widget value;
  final Widget footer;

  /// `false` cuando [value] contiene `Expanded`/`Flexible` (un `FittedBox`
  /// daría ancho no acotado).
  final bool fitValue;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 18, color: scheme.onSurfaceVariant),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    label,
                    style: text.labelMedium?.copyWith(color: scheme.onSurfaceVariant),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const Spacer(),
            if (fitValue)
              FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.centerLeft, child: value)
            else
              value,
            const SizedBox(height: 6),
            footer,
          ],
        ),
      ),
    );
  }
}

class _MiniLine extends StatelessWidget {
  const _MiniLine(this.label, this.amount, this.text);

  final String label;
  final double amount;
  final TextTheme text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Text('$label ', style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant)),
        Flexible(child: MoneyText(amount, style: text.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis)),
      ],
    );
  }
}
