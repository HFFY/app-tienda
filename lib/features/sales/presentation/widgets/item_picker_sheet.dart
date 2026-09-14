import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/duration_formatter.dart';
import '../../../../core/widgets/app_image.dart';
import '../../../../core/widgets/category_chip.dart';
import '../../../../core/widgets/category_filter_row.dart';
import '../../../../core/widgets/money_text.dart';
import '../../../../core/widgets/search_field.dart';
import '../../../categories/domain/entities/category.dart';
import '../../../categories/presentation/providers/category_providers.dart';
import '../../../products/presentation/providers/product_providers.dart';
import '../../../products/presentation/widgets/stock_badge.dart';
import '../../../services/presentation/providers/service_providers.dart';
import '../../domain/entities/sale.dart';
import '../providers/sale_providers.dart';

/// Hoja con dos pestañas (Productos / Servicios), buscador y filtro por
/// categoría. Tocar un ítem lo agrega al carrito.
Future<void> showItemPickerSheet(BuildContext context, {SaleItemType initialTab = SaleItemType.product}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => _ItemPickerSheet(initialTab: initialTab),
  );
}

class _ItemPickerSheet extends ConsumerStatefulWidget {
  const _ItemPickerSheet({required this.initialTab});

  final SaleItemType initialTab;

  @override
  ConsumerState<_ItemPickerSheet> createState() => _ItemPickerSheetState();
}

class _ItemPickerSheetState extends ConsumerState<_ItemPickerSheet> with SingleTickerProviderStateMixin {
  late final TabController _tabs = TabController(
    length: 2,
    vsync: this,
    initialIndex: widget.initialTab == SaleItemType.product ? 0 : 1,
  );
  String _query = '';
  int? _productCategory;
  int? _serviceCategory;

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartControllerProvider);
    final scheme = Theme.of(context).colorScheme;

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) => Column(
        children: [
          TabBar(
            controller: _tabs,
            tabs: const [
              Tab(text: 'Productos', icon: Icon(Icons.inventory_2_outlined)),
              Tab(text: 'Servicios', icon: Icon(Icons.design_services_outlined)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: SearchField(hintText: 'Buscar', onChanged: (v) => setState(() => _query = v)),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabs,
              children: [
                _ProductsTab(
                  query: _query,
                  categoryId: _productCategory,
                  onCategory: (id) => setState(() => _productCategory = id),
                  scrollController: scrollController,
                  quantityInCart: (id) =>
                      cart.items.where((i) => i.type == SaleItemType.product && i.refId == id).fold(0, (a, i) => a + i.quantity),
                ),
                _ServicesTab(
                  query: _query,
                  categoryId: _serviceCategory,
                  onCategory: (id) => setState(() => _serviceCategory = id),
                  scrollController: scrollController,
                  quantityInCart: (id) =>
                      cart.items.where((i) => i.type == SaleItemType.service && i.refId == id).fold(0, (a, i) => a + i.quantity),
                ),
              ],
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: FilledButton.icon(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.shopping_cart_checkout),
                label: Text(
                  cart.isEmpty ? 'Volver al carrito' : 'Listo · ${cart.unitCount} ítem${cart.unitCount == 1 ? '' : 's'}',
                ),
                style: FilledButton.styleFrom(backgroundColor: scheme.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductsTab extends ConsumerWidget {
  const _ProductsTab({
    required this.query,
    required this.categoryId,
    required this.onCategory,
    required this.scrollController,
    required this.quantityInCart,
  });

  final String query;
  final int? categoryId;
  final ValueChanged<int?> onCategory;
  final ScrollController scrollController;
  final int Function(int id) quantityInCart;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesForScopeProvider(CategoryScope.product)).value ?? const [];
    final async = ref.watch(activeProductsProvider);
    final q = query.trim().toLowerCase();

    return Column(
      children: [
        CategoryFilterRow(categories: categories, selectedId: categoryId, onSelected: onCategory),
        Expanded(
          child: async.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error: $e')),
            data: (products) {
              final list = products
                  .where((p) => categoryId == null || p.categoryId == categoryId)
                  .where((p) => q.isEmpty || p.name.toLowerCase().contains(q))
                  .toList();
              if (list.isEmpty) return const Center(child: Text('Sin productos.'));
              return ListView.builder(
                controller: scrollController,
                itemCount: list.length,
                itemBuilder: (context, i) {
                  final p = list[i];
                  final inCart = quantityInCart(p.id);
                  final soldOut = p.stock - inCart <= 0;
                  return ListTile(
                    enabled: !soldOut,
                    onTap: soldOut ? null : () => ref.read(cartControllerProvider.notifier).addProduct(p),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        width: 44,
                        height: 44,
                        child: AppImage(relativePath: p.imagePath, placeholderIcon: Icons.inventory_2_outlined, cacheWidth: 120),
                      ),
                    ),
                    title: Text(p.name),
                    subtitle: Row(
                      children: [
                        StockBadge(product: p),
                        const SizedBox(width: 8),
                        Flexible(
                          child: CategoryChip(
                            name: p.categoryName,
                            colorHex: p.categoryColorHex,
                            iconCode: p.categoryIconCode,
                            compact: true,
                          ),
                        ),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        MoneyText(p.price, style: const TextStyle(fontWeight: FontWeight.w700)),
                        if (inCart > 0)
                          Text('$inCart en carrito', style: Theme.of(context).textTheme.labelSmall),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ServicesTab extends ConsumerWidget {
  const _ServicesTab({
    required this.query,
    required this.categoryId,
    required this.onCategory,
    required this.scrollController,
    required this.quantityInCart,
  });

  final String query;
  final int? categoryId;
  final ValueChanged<int?> onCategory;
  final ScrollController scrollController;
  final int Function(int id) quantityInCart;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesForScopeProvider(CategoryScope.service)).value ?? const [];
    final async = ref.watch(activeServicesProvider);
    final q = query.trim().toLowerCase();

    return Column(
      children: [
        CategoryFilterRow(categories: categories, selectedId: categoryId, onSelected: onCategory),
        Expanded(
          child: async.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error: $e')),
            data: (services) {
              final list = services
                  .where((s) => categoryId == null || s.categoryId == categoryId)
                  .where((s) => q.isEmpty || s.name.toLowerCase().contains(q))
                  .toList();
              if (list.isEmpty) return const Center(child: Text('Sin servicios.'));
              return ListView.builder(
                controller: scrollController,
                itemCount: list.length,
                itemBuilder: (context, i) {
                  final s = list[i];
                  final inCart = quantityInCart(s.id);
                  return ListTile(
                    onTap: () => ref.read(cartControllerProvider.notifier).addService(s),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        width: 44,
                        height: 44,
                        child: AppImage(relativePath: s.imagePath, placeholderIcon: Icons.design_services_outlined, cacheWidth: 120),
                      ),
                    ),
                    title: Text(s.name),
                    subtitle: Text('${formatMinutes(s.durationMinutes)}${s.categoryName != null ? ' · ${s.categoryName}' : ''}'),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        MoneyText(s.price, style: const TextStyle(fontWeight: FontWeight.w700)),
                        if (inCart > 0)
                          Text('$inCart en carrito', style: Theme.of(context).textTheme.labelSmall),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
