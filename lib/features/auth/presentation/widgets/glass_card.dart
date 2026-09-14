import 'dart:ui';

import 'package:flutter/material.dart';

/// Tarjeta con efecto de vidrio esmerilado. El contenido siempre va sobre
/// un fondo semiopaco para garantizar contraste AA en los tres temas.
class GlassCard extends StatelessWidget {
  const GlassCard({super.key, required this.child, this.padding = const EdgeInsets.all(24)});

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: scheme.surface.withValues(alpha: 0.78),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.6)),
          ),
          child: child,
        ),
      ),
    );
  }
}
