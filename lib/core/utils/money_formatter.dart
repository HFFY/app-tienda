import 'package:intl/intl.dart';

/// Formateador de montos según la configuración de la tienda.
///
/// Ningún widget formatea dinero a mano: todo pasa por aquí (vía
/// `moneyFormatterProvider`), así que cambiar la moneda en configuración
/// actualiza toda la app al instante.
///
/// El símbolo va siempre **delante** ("Bs 1.234,50"), independientemente
/// del patrón del locale; el locale solo decide separadores de miles y
/// decimales.
class MoneyFormatter {
  MoneyFormatter({
    required this.locale,
    required this.symbol,
    required this.decimals,
  }) : _number = NumberFormat.decimalPatternDigits(
          locale: Intl.verifiedLocale(locale, NumberFormat.localeExists) ?? 'es',
          decimalDigits: decimals,
        );

  final String locale;
  final String symbol;
  final int decimals;
  final NumberFormat _number;

  String format(double amount) {
    final n = _number.format(amount);
    return symbol.isEmpty ? n : '$symbol $n';
  }

  /// Solo el número, sin símbolo (para inputs y tablas compactas).
  String formatPlain(double amount) => _number.format(amount);

  /// Versión compacta para gráficos: "1,2 mil".
  String formatCompact(double amount) {
    final f = NumberFormat.compact(locale: _number.locale);
    return f.format(amount);
  }

  @override
  bool operator ==(Object other) =>
      other is MoneyFormatter &&
      other.locale == locale &&
      other.symbol == symbol &&
      other.decimals == decimals;

  @override
  int get hashCode => Object.hash(locale, symbol, decimals);
}

/// Locales con datos de formato numérico incluidos en `intl`. Un locale sin
/// datos hace que `NumberFormat` lance, por eso la UI ofrece una lista
/// cerrada.
const List<({String code, String label})> kSupportedNumberLocales = [
  (code: 'es_BO', label: 'Bolivia (1.234,50)'),
  (code: 'es_AR', label: 'Argentina (1.234,50)'),
  (code: 'es_CL', label: 'Chile (1.234,50)'),
  (code: 'es_CO', label: 'Colombia (1.234,50)'),
  (code: 'es_ES', label: 'España (1.234,50)'),
  (code: 'es_PE', label: 'Perú (1,234.50)'),
  (code: 'es_MX', label: 'México (1,234.50)'),
  (code: 'en_US', label: 'Estados Unidos (1,234.50)'),
];
