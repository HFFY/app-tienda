import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/store/presentation/providers/store_providers.dart';

/// Número entero que se anima desde el valor anterior al nuevo.
class AnimatedCounter extends StatelessWidget {
  const AnimatedCounter(this.value, {super.key, this.style, this.duration = const Duration(milliseconds: 600)});

  final int value;
  final TextStyle? style;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(end: value.toDouble()),
      duration: duration,
      curve: Curves.easeOutCubic,
      builder: (context, v, _) => Text('${v.round()}', style: style),
    );
  }
}

/// Monto que se anima entre valores, formateado con la moneda de la tienda.
class AnimatedMoneyText extends ConsumerWidget {
  const AnimatedMoneyText(
    this.amount, {
    super.key,
    this.style,
    this.duration = const Duration(milliseconds: 500),
    this.textAlign,
  });

  final double amount;
  final TextStyle? style;
  final Duration duration;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formatter = ref.watch(moneyFormatterProvider);
    return TweenAnimationBuilder<double>(
      tween: Tween(end: amount),
      duration: duration,
      curve: Curves.easeOutCubic,
      builder: (context, v, _) => Text(formatter.format(v), style: style, textAlign: textAlign),
    );
  }
}
