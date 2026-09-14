import 'dart:math';

import 'package:flutter/material.dart';

/// Capa de ola: amplitud (px), longitud de onda relativa al ancho, desfase,
/// altura base (0..1 de la pantalla), opacidad, velocidad relativa y si se
/// rellena hacia arriba (borde superior) o hacia abajo.
typedef _Layer = ({
  double amp,
  double wave,
  double off,
  double base,
  double alpha,
  double speed,
  bool top,
});

/// Olas bezier superpuestas. `phase` avanza en bucle 0..1 y cada capa se
/// mueve a su propia velocidad, lo que da la sensación de profundidad.
class WavesPainter extends CustomPainter {
  WavesPainter({required this.phase, required this.scheme});

  final double phase;
  final ColorScheme scheme;

  static const List<_Layer> _layers = [
    // Borde superior: una sola capa discreta.
    (amp: 18.0, wave: 1.30, off: 0.90, base: 0.14, alpha: 0.22, speed: 0.8, top: true),
    // Tercio inferior: tres capas de atrás hacia adelante.
    (amp: 28.0, wave: 1.15, off: 0.00, base: 0.74, alpha: 0.28, speed: 1.0, top: false),
    (amp: 20.0, wave: 0.85, off: 1.30, base: 0.80, alpha: 0.45, speed: 0.7, top: false),
    (amp: 34.0, wave: 1.40, off: 2.60, base: 0.86, alpha: 0.85, speed: 1.3, top: false),
  ];

  /// Paso de muestreo horizontal. Con tangentes exactas, 24 px bastan para
  /// una curva suave y mantienen el costo por frame bajo.
  static const double _step = 24;

  @override
  void paint(Canvas canvas, Size size) {
    for (final layer in _layers) {
      final path = _buildPath(layer, size);
      final paint = Paint()
        ..shader = LinearGradient(
          begin: layer.top ? Alignment.bottomCenter : Alignment.topCenter,
          end: layer.top ? Alignment.topCenter : Alignment.bottomCenter,
          colors: [
            scheme.primary.withValues(alpha: layer.alpha * 0.75),
            scheme.secondary.withValues(alpha: layer.alpha),
          ],
        ).createShader(Offset.zero & size);
      canvas.drawPath(path, paint);
    }
  }

  Path _buildPath(_Layer l, Size size) {
    final baseY = size.height * l.base;
    final k = 2 * pi / (size.width * l.wave);
    final ph = phase * 2 * pi * l.speed + l.off;

    double y(double x) => baseY + l.amp * sin(k * x + ph);
    double dy(double x) => l.amp * k * cos(k * x + ph);

    final path = Path()..moveTo(0, y(0));
    var x0 = 0.0;
    while (x0 < size.width) {
      final x1 = min(x0 + _step, size.width);
      final dx = x1 - x0;
      // Hermite → Bézier cúbica con las tangentes exactas del seno.
      path.cubicTo(
        x0 + dx / 3,
        y(x0) + dy(x0) * dx / 3,
        x1 - dx / 3,
        y(x1) - dy(x1) * dx / 3,
        x1,
        y(x1),
      );
      x0 = x1;
    }

    if (l.top) {
      path
        ..lineTo(size.width, 0)
        ..lineTo(0, 0);
    } else {
      path
        ..lineTo(size.width, size.height)
        ..lineTo(0, size.height);
    }
    return path..close();
  }

  @override
  bool shouldRepaint(WavesPainter old) => old.phase != phase || old.scheme != scheme;
}
