import 'package:flutter/material.dart';

import 'waves_painter.dart';

/// Fondo de olas animadas a pantalla completa.
///
/// - Ciclo de 12 s: movimiento lento, no mareante.
/// - Se pausa cuando la app pasa a segundo plano (batería).
/// - Con "Quitar animaciones" en accesibilidad pinta un único fotograma.
/// - `RepaintBoundary` aísla el repintado del formulario que va encima.
class WavesBackground extends StatefulWidget {
  const WavesBackground({super.key});

  @override
  State<WavesBackground> createState() => _WavesBackgroundState();
}

class _WavesBackgroundState extends State<WavesBackground>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 12));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _syncAnimation();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _syncAnimation();
    } else {
      _controller.stop();
    }
  }

  void _syncAnimation() {
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller
        ..stop()
        ..value = 0.35;
    } else if (!_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ExcludeSemantics(
      child: RepaintBoundary(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) => CustomPaint(
            painter: WavesPainter(phase: _controller.value, scheme: scheme),
            size: Size.infinite,
          ),
        ),
      ),
    );
  }
}
