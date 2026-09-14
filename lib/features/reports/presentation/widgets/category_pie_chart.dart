import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/category_icons.dart';
import '../../../../core/widgets/money_text.dart';
import '../../../store/presentation/providers/store_providers.dart';
import '../../domain/entities/monthly_report.dart';

/// Torta de ingreso por categoría. El color sigue a la entidad (el color de
/// la categoría); las que no tienen color usan una paleta fija en orden.
/// Leyenda siempre presente con porcentaje y monto.
class CategoryPieChart extends ConsumerStatefulWidget {
  const CategoryPieChart({super.key, required this.data});

  final List<CategoryRevenue> data;

  @override
  ConsumerState<CategoryPieChart> createState() => _CategoryPieChartState();
}

class _CategoryPieChartState extends ConsumerState<CategoryPieChart> {
  int? _touched;

  static const _fallback = [
    Color(0xFF1E88E5),
    Color(0xFF43A047),
    Color(0xFFFB8C00),
    Color(0xFF8E24AA),
    Color(0xFF00897B),
    Color(0xFFE53935),
    Color(0xFF6D4C41),
    Color(0xFF757575),
  ];

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final fmt = ref.watch(moneyFormatterProvider);

    // Máximo 7 categorías + "Otras" para no saturar.
    final sorted = [...widget.data]..sort((a, b) => b.revenue.compareTo(a.revenue));
    final shown = sorted.take(7).toList();
    final rest = sorted.skip(7).fold<double>(0, (s, c) => s + c.revenue);
    if (rest > 0) shown.add(CategoryRevenue(name: 'Otras', revenue: rest));
    final total = shown.fold<double>(0, (s, c) => s + c.revenue);
    if (total <= 0) return const SizedBox.shrink();

    var fallbackIdx = 0;
    final colors = <Color>[
      for (final c in shown) colorFromHex(c.colorHex) ?? _fallback[(fallbackIdx++) % _fallback.length],
    ];

    return Column(
      children: [
        SizedBox(
          height: 190,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 46,
              pieTouchData: PieTouchData(
                touchCallback: (event, response) {
                  setState(() {
                    _touched = (!event.isInterestedForInteractions || response?.touchedSection == null)
                        ? null
                        : response!.touchedSection!.touchedSectionIndex;
                  });
                },
              ),
              sections: [
                for (var i = 0; i < shown.length; i++)
                  PieChartSectionData(
                    value: shown[i].revenue,
                    color: colors[i],
                    radius: _touched == i ? 58 : 50,
                    showTitle: shown[i].revenue / total >= 0.08,
                    title: '${(shown[i].revenue / total * 100).round()}%',
                    titleStyle: text.labelSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                    borderSide: BorderSide(color: scheme.surface, width: 2),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: [
            for (var i = 0; i < shown.length; i++)
              _LegendItem(
                color: colors[i],
                icon: categoryIconFor(shown[i].iconCode),
                label: shown[i].name,
                detail: '${(shown[i].revenue / total * 100).round()}% · ${fmt.format(shown[i].revenue)}',
                highlighted: _touched == i,
              ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Total ', style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant)),
            MoneyText(total, style: text.bodySmall?.copyWith(fontWeight: FontWeight.w700)),
          ],
        ),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({
    required this.color,
    required this.icon,
    required this.label,
    required this.detail,
    required this.highlighted,
  });

  final Color color;
  final IconData icon;
  final String label;
  final String detail;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3)),
        ),
        const SizedBox(width: 6),
        Text(label, style: text.bodySmall?.copyWith(fontWeight: highlighted ? FontWeight.w700 : FontWeight.w500)),
        const SizedBox(width: 4),
        Text(detail, style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant)),
      ],
    );
  }
}
