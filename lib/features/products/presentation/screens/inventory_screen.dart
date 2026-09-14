import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/widgets/async_value_widget.dart';
import '../../../../core/widgets/category_filter_row.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/inactive_chip.dart';
import '../../../../core/widgets/search_field.dart';
import '../../../categories/domain/entities/category.dart';
import '../../../categories/presentation/providers/category_providers.dart';
import '../providers/product_providers.dart';
import '../widgets/product_card.dart';

class InventoryScreen extends ConsumerWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(productFilterProvider);
    final filterCtl = ref.read(productFilterProvider.notifier);
    final async = ref.watch(productsProvider);
    final categories = ref.watch(categoriesForScopeProvider(CategoryScope.product)).value ?? const [];

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'fab-products',
        onPressed: () => context.push<int>(Routes.productNew),
        icon: const Icon(Icons.add),
        label: const Text('Crear producto'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Row(
              children: [
                Expanded(
                  child: SearchField(
                    hintText: 'Buscar producto',
                    initialValue: filter.query,
                    onChanged: filterCtl.setQuery,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filledTonal(
                  tooltip: filter.viewMode == ProductViewMode.grid ? 'Ver como lista' : 'Ver como cuadrícula',
                  onPressed: filterCtl.toggleViewMode,
                  icon: Icon(
                    filter.viewMode == ProductViewMode.grid ? Icons.view_list_outlined : Icons.grid_view_outlined,
                  ),
                ),
              ],
            ),
          ),
          CategoryFilterRow(
            categories: categories,
            selectedId: filter.categoryId,
            onSelected: filterCtl.setCategory,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: ActiveFilterToggle(value: filter.showInactive, onChanged: filterCtl.setShowInactive),
            ),
          ),
          Expanded(
            child: AsyncValueWidget(
              value: async,
              onRetry: () => ref.invalidate(productsProvider),
              data: (products) {
                if (products.isEmpty) {
                  final filtered = filter.query.isNotEmpty || filter.categoryId != null;
                  return EmptyState(
                    icon: Icons.inventory_2_outlined,
                    title: filtered ? 'Sin resultados' : 'Sin productos',
                    subtitle: filtered
                        ? 'Ningún producto coincide con el filtro.'
                        : 'Crea tu primer producto para empezar a controlar el stock.',
                    actionLabel: filtered ? null : 'Crear producto',
                    onAction: filtered ? null : () => context.push<int>(Routes.productNew),
                  );
                }
                void open(int id) => context.push(Routes.productDetail(id));

                if (filter.viewMode == ProductViewMode.list) {
                  return ListView.separated(
                    padding: const EdgeInsets.only(bottom: 96, top: 4),
                    itemCount: products.length,
                    separatorBuilder: (_, _) => const Divider(indent: 84),
                    itemBuilder: (context, i) => ProductListTile(
                      key: ValueKey(products[i].id),
                      product: products[i],
                      onTap: () => open(products[i].id),
                    ),
                  );
                }
                return GridView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.72,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, i) {
                    final card = ProductCard(
                      key: ValueKey(products[i].id),
                      product: products[i],
                      onTap: () => open(products[i].id),
                    );
                    if (i >= 8) return card;
                    return card
                        .animate()
                        .fadeIn(duration: 250.ms, delay: (40 * i).ms)
                        .scale(begin: const Offset(0.96, 0.96), end: const Offset(1, 1));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
