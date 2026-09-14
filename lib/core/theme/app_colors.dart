import 'package:flutter/material.dart';

import 'theme_options.dart';

/// Semillas de color de los tres temas. Ningún otro archivo define colores
/// de marca; los widgets usan siempre `Theme.of(context).colorScheme.*`.
abstract final class AppColors {
  static const redSeed = Color(0xFFD32F2F);
  static const blackSeed = Color(0xFF212121);
  static const blueSeed = Color(0xFF1565C0);

  static Color seedOf(ThemeColorOption option) => switch (option) {
        ThemeColorOption.red => redSeed,
        ThemeColorOption.black => blackSeed,
        ThemeColorOption.blue => blueSeed,
      };

  /// Colores semánticos de stock (badge del inventario).
  static const stockOk = Color(0xFF2E7D32);
  static const stockLow = Color(0xFFF9A825);
  static const stockEmpty = Color(0xFFC62828);
}
