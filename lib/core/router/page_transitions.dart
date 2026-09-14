import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Transición de desvanecimiento + leve desplazamiento vertical, usada en
/// pantallas de formulario y detalle que se abren sobre el shell.
CustomTransitionPage<T> fadeSlidePage<T>({
  required LocalKey key,
  required Widget child,
  Duration duration = const Duration(milliseconds: 280),
}) {
  return CustomTransitionPage<T>(
    key: key,
    child: child,
    transitionDuration: duration,
    reverseTransitionDuration: duration,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.04),
            end: Offset.zero,
          ).animate(curved),
          child: child,
        ),
      );
    },
  );
}

/// Desvanecimiento puro (login ↔ home) que respeta los `Hero`.
CustomTransitionPage<T> fadePage<T>({
  required LocalKey key,
  required Widget child,
  Duration duration = const Duration(milliseconds: 350),
}) {
  return CustomTransitionPage<T>(
    key: key,
    child: child,
    transitionDuration: duration,
    reverseTransitionDuration: duration,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}
