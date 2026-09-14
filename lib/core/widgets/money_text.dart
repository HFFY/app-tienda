import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/store/presentation/providers/store_providers.dart';

/// Único widget que muestra montos. Observa la configuración de moneda de
/// la tienda, así que cambiarla reformatea toda la app.
class MoneyText extends ConsumerWidget {
  const MoneyText(
    this.amount, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  final double amount;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formatter = ref.watch(moneyFormatterProvider);
    return Text(
      formatter.format(amount),
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
