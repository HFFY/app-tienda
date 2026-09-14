import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'theme_options.dart';

extension ThemeModeOptionX on ThemeModeOption {
  ThemeMode get themeMode => switch (this) {
        ThemeModeOption.light => ThemeMode.light,
        ThemeModeOption.dark => ThemeMode.dark,
        ThemeModeOption.system => ThemeMode.system,
      };
}

/// Construye el `ThemeData` para una semilla y un brillo.
ThemeData buildTheme(ThemeColorOption option, Brightness brightness) {
  final scheme = ColorScheme.fromSeed(
    seedColor: AppColors.seedOf(option),
    brightness: brightness,
    // Para el negro, `tonalSpot` produce un gris-lila sin carácter.
    dynamicSchemeVariant: option == ThemeColorOption.black
        ? DynamicSchemeVariant.monochrome
        : DynamicSchemeVariant.tonalSpot,
  );

  final base = ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    brightness: brightness,
  );

  return base.copyWith(
    appBarTheme: AppBarTheme(
      centerTitle: false,
      backgroundColor: scheme.surface,
      foregroundColor: scheme.onSurface,
      elevation: 0,
      scrolledUnderElevation: 2,
    ),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: scheme.primaryContainer,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.zero,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: scheme.surfaceContainerHighest.withValues(alpha: 0.4),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: scheme.outlineVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: scheme.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: scheme.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: scheme.error, width: 2),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: scheme.primary,
      foregroundColor: scheme.onPrimary,
    ),
    chipTheme: ChipThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
    dividerTheme: DividerThemeData(color: scheme.outlineVariant, space: 1),
  );
}
