import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/money_text.dart';
import '../../../sales/domain/entities/sale.dart';
import '../../domain/entities/monthly_report.dart';
import '../providers/report_providers.dart';

/// "Qué se vendió y cuántas veces", ordenado por unidades, con filtro por
/// categoría (snapshot).
class SoldItemsList extends ConsumerWidget {
  const SoldItemsList({super.key, required this.items});

  final List<SoldItem> items;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(reportCategoryFilterProvider);
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    final categories = items.map((i) => i.category ?? 'Sin categoría').toSet().toList()..sort();
    final visible = items.where((i) => filter == null || (i.category ?? 'Sin categoría') == filter).toList();
    final maxUnits = visible.fold<int>(0, (m, i) => i.unitsSold > m ? i.unitsSold : m);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (categories.length > 1)
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: const Text('Todas'),
                    selected: filter == null,
                    onSelected: (_) => ref.read(reportCategoryFilterProvider.notifier).set(null),
                  ),
                ),
                for (final c in categories)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(c),
                      selected: filter == c,
                      onSelected: (_) => ref.read(reportCategoryFilterProvider.notifier).set(filter == c ? null : c),
                    ),
                  ),
              ],
            ),
          ),
        const SizedBox(height: 8),
        for (var i = 0; i < visible.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                SizedBox(
                  width: 24,
                  child: Text('${i + 1}', style: text.labelLarge?.copyWith(color: scheme.onSurfaceVariant)),
                ),
                Icon(
                  visible[i].type == SaleItemType.product ? Icons.inventory_2_outlined : Icons.design_services_outlined,
                  size: 18,
                  color: scheme.onSurfaceVariant,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(visible[i].name, maxLines: 1, overflow: TextOverflow.ellipsis, style: text.bodyLarge),
                      const SizedBox(height: 4),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: LinearProgressIndicator(
                          value: maxUnits == 0 ? 0 : visible[i].unitsSold / maxUnits,
                          minHeight: 5,
                          backgroundColor: scheme.surfaceContainerHighest,
                          color: scheme.primary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${visible[i].category ?? 'Sin categoría'} · ${visible[i].timesSold} venta${visible[i].timesSold == 1 ? '' : 's'}',
                        style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('${visible[i].unitsSold} ud.', style: text.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                    MoneyText(visible[i].revenue, style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant)),
                  ],
                ),
              ],
            ),
          ),
        if (visible.isEmpty)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text('Sin ítems en esta categoría.', textAlign: TextAlign.center, style: text.bodyMedium),
          ),
      ],
    );
  }
}
