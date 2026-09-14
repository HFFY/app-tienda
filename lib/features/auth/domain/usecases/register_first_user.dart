import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../../store/domain/repositories/store_repository.dart';
import '../entities/app_user.dart';
import '../repositories/auth_repository.dart';
import '../repositories/session_repository.dart';
import '../services/password_hasher.dart';

/// Onboarding de primera ejecución: crea el único usuario, opcionalmente
/// nombra la tienda y abre sesión.
class RegisterFirstUser {
  const RegisterFirstUser(this._auth, this._hasher, this._session, this._store);

  final AuthRepository _auth;
  final PasswordHasher _hasher;
  final SessionRepository _session;
  final StoreRepository _store;

  Future<Result<AppUser>> call({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    String? storeName,
  }) async {
    final exists = await _auth.hasAnyUser();
    switch (exists) {
      case Err(:final failure):
        return Err(failure);
      case Ok(value: true):
        return const Err(ValidationFailure('Ya existe un usuario registrado.'));
      case Ok():
        break;
    }

    if (firstName.trim().isEmpty || lastName.trim().isEmpty) {
      return const Err(ValidationFailure('Nombre y apellido son obligatorios.'));
    }
    if (password.length < 6) {
      return const Err(ValidationFailure('La contraseña debe tener al menos 6 caracteres.', field: 'password'));
    }

    final hashed = await _hasher.hash(password);
    final created = await _auth.create(
      firstName: firstName.trim(),
      lastName: lastName.trim(),
      email: email.trim().toLowerCase(),
      password: hashed,
    );

    final AppUser user;
    switch (created) {
      case Err(:final failure):
        return Err(failure);
      case Ok(:final value):
        user = value;
    }

    final name = storeName?.trim();
    if (name != null && name.isNotEmpty) {
      final storeResult = await _store.getStore();
      if (storeResult case Ok(:final value)) {
        await _store.update(value.copyWith(name: name));
      }
    }

    await _session.save(user.id);
    return Ok(user);
  }
}
