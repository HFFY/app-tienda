import 'package:flutter/material.dart';

/// `FilledButton` que muestra un spinner y se deshabilita mientras carga.
class LoadingButton extends StatelessWidget {
  const LoadingButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.loading = false,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool loading;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final child = AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: loading
          ? const SizedBox(
              key: ValueKey('spinner'),
              width: 22,
              height: 22,
              child: CircularProgressIndicator(strokeWidth: 2.5),
            )
          : Row(
              key: const ValueKey('label'),
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[Icon(icon, size: 20), const SizedBox(width: 8)],
                Text(label),
              ],
            ),
    );
    return FilledButton(onPressed: loading ? null : onPressed, child: child);
  }
}
