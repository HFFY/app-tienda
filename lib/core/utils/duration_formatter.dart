/// `90` → "1 h 30 min", `45` → "45 min", `120` → "2 h".
String formatMinutes(int minutes) {
  if (minutes <= 0) return '0 min';
  final h = minutes ~/ 60;
  final m = minutes % 60;
  if (h == 0) return '$m min';
  if (m == 0) return '$h h';
  return '$h h $m min';
}
