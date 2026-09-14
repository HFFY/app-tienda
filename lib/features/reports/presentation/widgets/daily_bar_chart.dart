import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../store/presentation/providers/store_providers.dart';
import '../../domain/entities/monthly_report.dart';

/// Barras de ingreso neto por día del mes. Una sola serie (color primario),
/// grilla recesiva, tooltip al tocar cada barra.
class DailyBarChart extends ConsumerWidget {
  const DailyBarChart({super.key, required this.daily});

  final List<DailyTotal> daily;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final fmt = ref.watch(moneyFormatterProvider);
    final maxY = daily.fold<double>(0, (m, d) => d.total > m ? d.total : m);
    final days = daily.length;
    // Etiquetas del eje X cada ~5 días para evitar colisiones.
    final labelEvery = days > 20 ? 5 : 2;

    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          maxY: maxY == 0 ? 10 : maxY * 1.15,
          alignment: BarChartAlignment.spaceBetween,
          gridData: FlGridData(
            drawVerticalLine: false,
            horizontalInterval: _niceInterval(maxY),
            getDrawingHorizontalLine: (_) => FlLine(color: scheme.outlineVariant.withValues(alpha: 0.5), strokeWidth: 1),
          ),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(),
            rightTitles: const AxisTitles(),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 44,
                interval: _niceInterval(maxY),
                getTitlesWidget: (v, meta) {
                  // Sin etiqueta en el tope del eje (no coincide con la grilla).
                  if (v > maxY) return const SizedBox.shrink();
                  return Text(
                    fmt.formatCompact(v),
                    style: text.labelSmall?.copyWith(color: scheme.onSurfaceVariant),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 22,
                getTitlesWidget: (v, meta) {
                  final d = v.toInt();
                  if (d != 1 && d != days && d % labelEvery != 0) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text('$d', style: text.labelSmall?.copyWith(color: scheme.onSurfaceVariant)),
                  );
                },
              ),
            ),
          ),
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (_) => scheme.inverseSurface,
              getTooltipItem: (group, _, rod, _) {
                final d = daily[group.x - 1];
                return BarTooltipItem(
                  'Día ${d.day}\n${fmt.format(d.total)} · ${d.salesCount} venta${d.salesCount == 1 ? '' : 's'}',
                  TextStyle(color: scheme.onInverseSurface, fontWeight: FontWeight.w600),
                );
              },
            ),
          ),
          barGroups: [
            for (final d in daily)
              BarChartGroupData(
                x: d.day,
                barRods: [
                  BarChartRodData(
                    toY: d.total,
                    width: days > 20 ? 6 : 10,
                    color: d.total == 0 ? scheme.outlineVariant.withValues(alpha: 0.35) : scheme.primary,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  static double _niceInterval(double maxY) {
    if (maxY <= 0) return 5;
    final raw = maxY / 4;
    final mag = _pow10((raw).floor().toString().length - 1);
    final norm = raw / mag;
    final nice = norm <= 1 ? 1 : norm <= 2 ? 2 : norm <= 5 ? 5 : 10;
    return (nice * mag).toDouble();
  }

  static int _pow10(int e) {
    var r = 1;
    for (var i = 0; i < e; i++) {
      r *= 10;
    }
    return r;
  }
}
