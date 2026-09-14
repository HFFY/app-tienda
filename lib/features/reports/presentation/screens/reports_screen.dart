import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/widgets/async_value_widget.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../domain/entities/monthly_report.dart';
import '../providers/report_providers.dart';
import '../widgets/category_pie_chart.dart';
import '../widgets/daily_bar_chart.dart';
import '../widgets/month_selector.dart';
import '../widgets/sold_items_list.dart';
import '../widgets/summary_cards.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sel = ref.watch(selectedMonthProvider);
    final async = ref.watch(monthlyReportProvider((sel.year, sel.month)));

    return Scaffold(
      body: Column(
        children: [
          const MonthSelector(),
          Expanded(
            child: AsyncValueWidget(
              value: async,
              onRetry: () => ref.invalidate(monthlyReportProvider),
              data: (report) => AnimatedSwitcher(
                duration: const Duration(milliseconds: 280),
                transitionBuilder: (child, animation) {
                  final dir = sel.direction == 0 ? 1.0 : sel.direction.toDouble();
                  final incoming = child.key == ValueKey('${report.year}-${report.month}');
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween(
                        begin: Offset(incoming ? dir * 0.15 : -dir * 0.15, 0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  );
                },
                child: _ReportBody(key: ValueKey('${report.year}-${report.month}'), report: report),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReportBody extends StatelessWidget {
  const _ReportBody({super.key, required this.report});

  final MonthlyReport report;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    if (!report.hasSales) {
      return EmptyState(
        icon: Icons.insights_outlined,
        title: 'Sin ventas este mes',
        subtitle: 'Cuando registres ventas verás aquí el ingreso, los gráficos y lo más vendido.',
        actionLabel: 'Registrar venta',
        onAction: () => context.go(Routes.newSale),
      );
    }

    Widget section(String title, Widget child, {int index = 0}) => Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: text.titleMedium),
              const SizedBox(height: 10),
              child,
            ],
          ),
        ).animate().fadeIn(duration: 300.ms, delay: (80 * index).ms).slideY(begin: 0.05, end: 0);

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
      children: [
        SummaryCards(report: report).animate().fadeIn(duration: 300.ms),
        section(
          'Ingreso por día',
          Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 16, 16, 8),
              child: DailyBarChart(daily: report.daily),
            ),
          ),
          index: 1,
        ),
        section(
          'Ingreso por categoría',
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: CategoryPieChart(data: report.byCategory),
            ),
          ),
          index: 2,
        ),
        section(
          'Qué se vendió',
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: SoldItemsList(items: report.soldItems),
            ),
          ),
          index: 3,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(
            'Ingreso bruto = total facturado antes de descuentos. No se registra el costo de los productos, '
            'por lo que no se calcula utilidad.',
            style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
          ),
        ),
      ],
    );
  }
}
