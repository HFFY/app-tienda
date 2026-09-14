import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../repositories/auth_repository.dart';
import '../services/password_hasher.dart';

/// Exige la contraseña actual antes de reemplazarla.
class ChangePassword {
  const ChangePassword(this._auth, this._hasher);

  final AuthRepository _auth;
  final PasswordHasher _hasher;

  Future<Result<void>> call({
    required int userId,
    required String current,
    required String next,
    required String confirm,
  }) async {
    if (next.length < 6) {
      return const Err(ValidationFailure('La nueva contraseña debe tener al menos 6 caracteres.', field: 'next'));
    }
    if (next != confirm) {
      return const Err(ValidationFailure('Las contraseñas no coinciden.', field: 'confirm'));
    }
    if (next == current) {
      return const Err(ValidationFailure('La nueva contraseña debe ser distinta de la actual.', field: 'next'));
    }

    final stored = await _auth.getHashedPassword(userId);
    switch (stored) {
      case Err(:final failure):
        return Err(failure);
      case Ok(:final value):
        if (!await _hasher.verify(current, value)) {
          return const Err(ValidationFailure('La contraseña actual es incorrecta.', field: 'current'));
        }
    }

    final hashed = await _hasher.hash(next);
    return _auth.updatePassword(userId, hashed);
  }
}
