import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/product.dart';

/// Badge de stock: verde (ok), ámbar (bajo) o rojo (agotado). Anima el
/// cambio de color con `AnimatedContainer`.
class StockBadge extends StatelessWidget {
  const StockBadge({super.key, required this.product, this.large = false});

  final Product product;
  final bool large;

  @override
  Widget build(BuildContext context) {
    final (color, label, icon) = product.isOutOfStock
        ? (AppColors.stockEmpty, 'Agotado', Icons.remove_shopping_cart_outlined)
        : product.isLowStock
            ? (AppColors.stockLow, 'Stock bajo', Icons.warning_amber_rounded)
            : (AppColors.stockOk, 'En stock', Icons.check_circle_outline);

    final fontSize = large ? 13.0 : 11.0;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.symmetric(horizontal: large ? 10 : 6, vertical: large ? 6 : 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: fontSize + 3, color: color),
          const SizedBox(width: 4),
          Text(
            large ? '${product.stock} · $label' : '${product.stock}',
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w700, color: color),
          ),
        ],
      ),
    );
  }
}
