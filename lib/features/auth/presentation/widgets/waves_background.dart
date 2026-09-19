import 'package:flutter/material.dart';

import 'waves_painter.dart';

/// Fase fija con la que se pintan las olas (elegida para que las tres capas
/// queden bien repartidas en pantalla).
const double kWavesStaticPhase = 0.35;

/// Fondo de olas a pantalla completa, **estático**: se pinta un único
/// fotograma y no hay ningún controlador de animación.
///
/// `RepaintBoundary` aísla el canvas del formulario que va encima, así el
/// fondo no se vuelve a pintar cuando el usuario escribe.
class WavesBackground extends StatelessWidget {
  const WavesBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ExcludeSemantics(
      child: RepaintBoundary(
        child: CustomPaint(
          painter: WavesPainter(phase: kWavesStaticPhase, scheme: scheme),
          size: Size.infinite,
        ),
      ),
    );
  }
}
