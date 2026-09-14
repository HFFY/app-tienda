import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/date_formatter.dart';
import '../providers/report_providers.dart';

/// ‹ Septiembre 2026 › con `AnimatedSwitcher` que desliza según la dirección.
class MonthSelector extends ConsumerWidget {
  const MonthSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sel = ref.watch(selectedMonthProvider);
    final ctl = ref.read(selectedMonthProvider.notifier);
    final first = ref.watch(firstSaleMonthProvider).value;
    final text = Theme.of(context).textTheme;

    final canGoBack = first == null ||
        sel.year > first.$1 ||
        (sel.year == first.$1 && sel.month > first.$2);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          IconButton(
            tooltip: 'Mes anterior',
            onPressed: canGoBack ? ctl.previous : null,
            icon: const Icon(Icons.chevron_left),
          ),
          Expanded(
            child: ClipRect(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 280),
                switchInCurve: Curves.easeOutCubic,
                switchOutCurve: Curves.easeInCubic,
                transitionBuilder: (child, animation) {
                  final dir = sel.direction == 0 ? 1.0 : sel.direction.toDouble();
                  final isIncoming = child.key == ValueKey('${sel.year}-${sel.month}');
                  final begin = Offset(isIncoming ? dir * 0.6 : -dir * 0.6, 0);
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween(begin: begin, end: Offset.zero).animate(animation),
                      child: child,
                    ),
                  );
                },
                child: Text(
                  DateFormatter.monthYear(sel.year, sel.month),
                  key: ValueKey('${sel.year}-${sel.month}'),
                  textAlign: TextAlign.center,
                  style: text.titleLarge,
                ),
              ),
            ),
          ),
          IconButton(
            tooltip: 'Mes siguiente',
            onPressed: ctl.isCurrent ? null : ctl.next,
            icon: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
