import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/routes.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/widgets/app_image.dart';
import '../../../../core/widgets/app_snackbar.dart';
import '../../../../core/widgets/category_chip.dart';
import '../../../../core/widgets/delete_or_deactivate_dialog.dart';
import '../../../../core/widgets/inactive_chip.dart';
import '../../../../core/widgets/money_text.dart';
import '../../../inventory/domain/entities/inventory_movement.dart';
import '../../../inventory/presentation/widgets/movement_sheet.dart';
import '../../domain/entities/product.dart';
import '../controllers/product_mutations.dart';
import '../providers/product_providers.dart';
import '../widgets/product_card.dart';
import '../widgets/stock_badge.dart';

class ProductDetailScreen extends ConsumerWidget {
  const ProductDetailScreen({super.key, required this.productId});

  final int productId;

  Future<void> _deleteOrDeactivate(
    BuildContext context,
    WidgetRef ref,
    Product p,
  ) async {
    final refs = await ref
        .read(deleteOrDeactivateProductProvider)
        .references(p.id);
    if (!context.mounted) return;
    final count = refs.valueOrNull ?? 0;

    final choice = await showDeleteOrDeactivateDialog(
      context,
      entityLabel: 'el producto',
      entityName: p.name,
      referenceCount: count,
      referenceDescription:
          'Tiene $count transacci${count == 1 ? 'ón' : 'ones'} (ventas o movimientos)',
      isActive: p.isActive,
    );
    if (choice == null || !context.mounted) return;

    final mutations = ref.read(productMutationsProvider.notifier);
    final failure = switch (choice) {
      DeleteAction.delete => await mutations.delete(p),
      DeleteAction.deactivate => await mutations.setActive(p.id, false),
    };
    if (!context.mounted) return;
    if (failure != null) {
      AppSnackBar.failure(context, failure);
      return;
    }
    AppSnackBar.show(
      context,
      choice == DeleteAction.delete
          ? 'Producto eliminado.'
          : 'Producto desactivado.',
    );
    if (choice == DeleteAction.delete) context.pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(productByIdProvider(productId));
    final movementsAsync = ref.watch(productMovementsProvider(productId));
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    final p = async.value;
    if (p == null) {
      return Scaffold(
        appBar: AppBar(),
        body: async.isLoading
            ? const Center(child: CircularProgressIndicator())
            : const Center(child: Text('El producto no existe.')),
      );
    }

    final recent = (movementsAsync.value ?? const <InventoryMovement>[])
        .reversed
        .take(3)
        .toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            actions: [
              IconButton(
                tooltip: 'Editar',
                icon: const Icon(Icons.edit_outlined),
                onPressed: () => context.push<int>(Routes.productEdit(p.id)),
              ),
              PopupMenuButton<String>(
                onSelected: (v) async {
                  if (v == 'toggle') {
                    final f = await ref
                        .read(productMutationsProvider.notifier)
                        .setActive(p.id, !p.isActive);
                    if (!context.mounted) return;
                    if (f != null) AppSnackBar.failure(context, f);
                  } else if (v == 'delete') {
                    await _deleteOrDeactivate(context, ref, p);
                  }
                },
                itemBuilder: (_) => [
                  PopupMenuItem(
                    value: 'toggle',
                    child: ListTile(
                      leading: Icon(
                        p.isActive
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                      title: Text(p.isActive ? 'Desactivar' : 'Activar'),
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: ListTile(
                      leading: Icon(Icons.delete_outline),
                      title: Text('Eliminar'),
                    ),
                  ),
                ],
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: productImageHeroTag(p.id),
                child: AppImage(
                  relativePath: p.imagePath,
                  placeholderIcon: Icons.inventory_2_outlined,
                  cacheWidth: 1024,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
            sliver: SliverList.list(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p.name, style: text.headlineSmall),
                          const SizedBox(height: 6),
                          Wrap(
                            spacing: 8,
                            runSpacing: 6,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              CategoryChip(
                                name: p.categoryName,
                                colorHex: p.categoryColorHex,
                                iconCode: p.categoryIconCode,
                              ),
                              if (!p.isActive) const InactiveChip(),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    MoneyText(
                      p.price,
                      style: text.headlineSmall?.copyWith(
                        color: scheme.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                if (p.description != null) ...[
                  const SizedBox(height: 12),
                  Text(p.description!, style: text.bodyLarge),
                ],
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Stock',
                              style: text.labelMedium?.copyWith(
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 4),
                            StockBadge(product: p, large: true),
                            const SizedBox(height: 4),
                            Text(
                              'Mínimo: ${p.minStock}',
                              style: text.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            FilledButton.tonalIcon(
                              style: FilledButton.styleFrom(
                                minimumSize: const Size(0, 40),
                              ),
                              onPressed: () => showMovementSheet(
                                context,
                                product: p,
                                initialType: MovementType.in_,
                              ),
                              icon: const Icon(Icons.add),
                              label: const Text('Entrada'),
                            ),
                            const SizedBox(height: 8),
                            FilledButton.tonalIcon(
                              style: FilledButton.styleFrom(
                                minimumSize: const Size(0, 40),
                              ),
                              onPressed: () => showMovementSheet(
                                context,
                                product: p,
                                initialType: MovementType.out,
                              ),
                              icon: const Icon(Icons.remove),
                              label: const Text('Salida'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Últimos movimientos',
                        style: text.titleMedium,
                      ),
                    ),
                    TextButton(
                      onPressed: () =>
                          context.push(Routes.productMovements(p.id)),
                      child: const Text('Ver kardex'),
                    ),
                  ],
                ),
                if (recent.isEmpty)
                  Text(
                    'Sin movimientos registrados.',
                    style: text.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  )
                else
                  for (final m in recent) _MovementRow(m),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MovementRow extends StatelessWidget {
  const _MovementRow(this.m);

  final InventoryMovement m;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final positive = m.isIncrease;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: (positive ? Colors.green : scheme.error).withValues(
          alpha: 0.15,
        ),
        foregroundColor: positive ? Colors.green.shade800 : scheme.error,
        child: Icon(
          positive ? Icons.arrow_downward : Icons.arrow_upward,
          size: 20,
        ),
      ),
      title: Text('${m.type.label} · ${m.reason.label}'),
      subtitle: Text(DateFormatter.shortDateTime(m.movedAt)),
      trailing: Text(
        '${positive ? '+' : ''}${m.quantity}',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: positive ? Colors.green.shade800 : scheme.error,
        ),
      ),
    );
  }
}
