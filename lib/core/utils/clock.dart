/// Fechas en base de datos: siempre ISO-8601 en UTC. El formato ordena
/// lexicográficamente igual que cronológicamente.
String nowUtcIso() => DateTime.now().toUtc().toIso8601String();

String toUtcIso(DateTime dt) => dt.toUtc().toIso8601String();

DateTime parseUtc(String iso) => DateTime.parse(iso).toUtc();

/// Límites `[start, end)` de un mes calendario **local**, expresados en
/// ISO UTC para usarse en `WHERE sale_date >= ? AND sale_date < ?`.
///
/// Se calculan en hora local porque el usuario piensa en "septiembre" según
/// su reloj; en Bolivia (UTC−4) una venta a las 22:00 del 30 de septiembre
/// es 02:00 UTC del 1 de octubre y aun así pertenece a septiembre.
({String start, String end}) monthBoundsUtc(int year, int month) {
  final start = DateTime(year, month, 1);
  final end = DateTime(year, month + 1, 1);
  return (start: toUtcIso(start), end: toUtcIso(end));
}

/// Mes anterior/siguiente como `(year, month)`.
(int, int) previousMonth(int year, int month) =>
    month == 1 ? (year - 1, 12) : (year, month - 1);

(int, int) nextMonth(int year, int month) =>
    month == 12 ? (year + 1, 1) : (year, month + 1);

int daysInMonth(int year, int month) => DateTime(year, month + 1, 0).day;
