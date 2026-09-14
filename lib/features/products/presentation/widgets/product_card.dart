import 'package:flutter/material.dart';

import '../../../../core/widgets/app_image.dart';
import '../../../../core/widgets/category_chip.dart';
import '../../../../core/widgets/inactive_chip.dart';
import '../../../../core/widgets/money_text.dart';
import '../../domain/entities/product.dart';
import 'stock_badge.dart';

String productImageHeroTag(int id) => 'product-image-$id';

/// Tarjeta del grid de inventario.
class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product, required this.onTap});

  final Product product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final p = product;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 1.15,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: productImageHeroTag(p.id),
                    child: Opacity(
                      opacity: p.isActive ? 1 : 0.5,
                      child: AppImage(relativePath: p.imagePath, placeholderIcon: Icons.inventory_2_outlined),
                    ),
                  ),
                  Positioned(top: 8, right: 8, child: StockBadge(product: p)),
                  if (!p.isActive) const Positioned(top: 8, left: 8, child: InactiveChip()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: text.titleSmall?.copyWith(color: p.isActive ? null : scheme.outline),
                  ),
                  const SizedBox(height: 2),
                  MoneyText(
                    p.price,
                    style: text.titleMedium?.copyWith(color: scheme.primary, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  CategoryChip(
                    name: p.categoryName,
                    colorHex: p.categoryColorHex,
                    iconCode: p.categoryIconCode,
                    compact: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Fila del modo lista.
class ProductListTile extends StatelessWidget {
  const ProductListTile({super.key, required this.product, required this.onTap});

  final Product product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final p = product;
    return ListTile(
      onTap: onTap,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          width: 52,
          height: 52,
          child: Hero(
            tag: productImageHeroTag(p.id),
            child: AppImage(relativePath: p.imagePath, placeholderIcon: Icons.inventory_2_outlined, cacheWidth: 160),
          ),
        ),
      ),
      title: Row(
        children: [
          Flexible(
            child: Text(
              p.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: p.isActive ? null : scheme.outline),
            ),
          ),
          if (!p.isActive) ...[const SizedBox(width: 8), const InactiveChip()],
        ],
      ),
      subtitle: Row(
        children: [
          Flexible(
            child: CategoryChip(
              name: p.categoryName,
              colorHex: p.categoryColorHex,
              iconCode: p.categoryIconCode,
              compact: true,
            ),
          ),
          const SizedBox(width: 8),
          StockBadge(product: p),
        ],
      ),
      trailing: MoneyText(
        p.price,
        style: TextStyle(color: scheme.primary, fontWeight: FontWeight.w700),
      ),
    );
  }
}
