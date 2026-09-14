import 'package:flutter/material.dart';

/// Círculo con iniciales y un color derivado del nombre, estable entre
/// sesiones (hash determinista).
class InitialsAvatar extends StatelessWidget {
  const InitialsAvatar({
    super.key,
    required this.initials,
    required this.seed,
    this.size = 44,
    this.muted = false,
  });

  final String initials;

  /// Texto del que se deriva el color (normalmente el nombre completo).
  final String seed;
  final double size;

  /// Para registros inactivos.
  final bool muted;

  static const _palette = [
    Color(0xFFE53935),
    Color(0xFFD81B60),
    Color(0xFF8E24AA),
    Color(0xFF5E35B1),
    Color(0xFF3949AB),
    Color(0xFF1E88E5),
    Color(0xFF00897B),
    Color(0xFF43A047),
    Color(0xFFFB8C00),
    Color(0xFFF4511E),
    Color(0xFF6D4C41),
    Color(0xFF546E7A),
  ];

  static Color colorFor(String seed) {
    var h = 0;
    for (final c in seed.toLowerCase().codeUnits) {
      h = (h * 31 + c) & 0x7fffffff;
    }
    return _palette[h % _palette.length];
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = muted ? scheme.outline : colorFor(seed);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: muted ? 0.12 : 0.18),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: TextStyle(
          fontSize: size * 0.38,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}
