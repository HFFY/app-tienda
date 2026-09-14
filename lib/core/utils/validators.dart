/// Validadores para `TextFormField.validator`. Devuelven `null` si el valor
/// es válido o un mensaje en español si no.
abstract final class Validators {
  static String? required(String? v, [String label = 'Este campo']) =>
      (v == null || v.trim().isEmpty) ? '$label es obligatorio.' : null;

  static final _emailRe = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  static String? email(String? v) {
    if (v == null || v.trim().isEmpty) return 'El email es obligatorio.';
    if (!_emailRe.hasMatch(v.trim())) return 'Ingresa un email válido.';
    return null;
  }

  static String? password(String? v, {int minLength = 6}) {
    if (v == null || v.isEmpty) return 'La contraseña es obligatoria.';
    if (v.length < minLength) return 'Mínimo $minLength caracteres.';
    return null;
  }

  static String? confirmPassword(String? v, String original) {
    if (v != original) return 'Las contraseñas no coinciden.';
    return null;
  }

  static String? nonNegativeNumber(String? v, [String label = 'El valor']) {
    if (v == null || v.trim().isEmpty) return '$label es obligatorio.';
    final n = parseNumber(v);
    if (n == null) return 'Ingresa un número válido.';
    if (n < 0) return '$label no puede ser negativo.';
    return null;
  }

  static String? positiveInt(String? v, [String label = 'La cantidad']) {
    if (v == null || v.trim().isEmpty) return '$label es obligatoria.';
    final n = int.tryParse(v.trim());
    if (n == null) return 'Ingresa un entero válido.';
    if (n <= 0) return '$label debe ser mayor que 0.';
    return null;
  }

  static String? nonNegativeInt(String? v, [String label = 'La cantidad']) {
    if (v == null || v.trim().isEmpty) return '$label es obligatoria.';
    final n = int.tryParse(v.trim());
    if (n == null) return 'Ingresa un entero válido.';
    if (n < 0) return '$label no puede ser negativa.';
    return null;
  }

  static String? nonZeroInt(String? v, [String label = 'La cantidad']) {
    if (v == null || v.trim().isEmpty) return '$label es obligatoria.';
    final n = int.tryParse(v.trim());
    if (n == null) return 'Ingresa un entero válido.';
    if (n == 0) return '$label no puede ser 0.';
    return null;
  }

  static String? optionalPhone(String? v) {
    if (v == null || v.trim().isEmpty) return null;
    final digits = v.replaceAll(RegExp(r'[\s\-\(\)\+]'), '');
    if (!RegExp(r'^\d{6,15}$').hasMatch(digits)) return 'Ingresa un teléfono válido.';
    return null;
  }

  /// Acepta coma o punto como separador decimal.
  static double? parseNumber(String v) => double.tryParse(v.trim().replaceAll(',', '.'));
}
