// Opciones de tema persistidas en `store`. Sin dependencia de Flutter para
// que el dominio pueda usarlas; la conversión a `ThemeMode` está en
// `app_theme.dart`.

/// Semilla de color elegida por el usuario. Se persiste en `store.theme_color`.
enum ThemeColorOption {
  red('red', 'Rojo'),
  black('black', 'Negro'),
  blue('blue', 'Azul');

  const ThemeColorOption(this.dbValue, this.label);

  final String dbValue;
  final String label;

  static ThemeColorOption fromDb(String? v) =>
      values.firstWhere((e) => e.dbValue == v, orElse: () => ThemeColorOption.red);
}

/// Claro / oscuro / sistema. Se persiste en `store.theme_mode`.
enum ThemeModeOption {
  light('light', 'Claro'),
  dark('dark', 'Oscuro'),
  system('system', 'Sistema');

  const ThemeModeOption(this.dbValue, this.label);

  final String dbValue;
  final String label;

  static ThemeModeOption fromDb(String? v) =>
      values.firstWhere((e) => e.dbValue == v, orElse: () => ThemeModeOption.system);
}
