import 'package:intl/intl.dart';

/// Formato de fechas de la interfaz. El idioma es siempre español; el
/// locale configurable de la tienda solo afecta al formato numérico.
abstract final class DateFormatter {
  static const _locale = 'es';

  /// "Septiembre 2026"
  static String monthYear(int year, int month) {
    final text = DateFormat.yMMMM(_locale).format(DateTime(year, month));
    return text.isEmpty ? text : text[0].toUpperCase() + text.substring(1);
  }

  /// "13/09/2026"
  static String date(DateTime dt) => DateFormat('dd/MM/yyyy', _locale).format(dt.toLocal());

  /// "13/09/2026 18:45"
  static String dateTime(DateTime dt) =>
      DateFormat('dd/MM/yyyy HH:mm', _locale).format(dt.toLocal());

  /// "13 sep, 18:45"
  static String shortDateTime(DateTime dt) =>
      DateFormat('d MMM, HH:mm', _locale).format(dt.toLocal());

  /// "hace 3 días" / "hoy" / "ayer"
  static String relativeDays(DateTime dt) {
    final now = DateTime.now();
    final local = dt.toLocal();
    final days = DateTime(now.year, now.month, now.day)
        .difference(DateTime(local.year, local.month, local.day))
        .inDays;
    if (days <= 0) return 'hoy';
    if (days == 1) return 'ayer';
    return 'hace $days días';
  }
}
