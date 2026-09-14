import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../entities/app_user.dart';
import '../repositories/auth_repository.dart';
import '../repositories/session_repository.dart';
import '../services/password_hasher.dart';

class Login {
  const Login(this._auth, this._hasher, this._session);

  final AuthRepository _auth;
  final PasswordHasher _hasher;
  final SessionRepository _session;

  Future<Result<AppUser>> call({required String email, required String password}) async {
    final normalized = email.trim().toLowerCase();
    if (normalized.isEmpty || password.isEmpty) {
      return const Err(ValidationFailure('Ingresa tu email y contraseña.'));
    }

    final userResult = await _auth.findByEmail(normalized);
    final AppUser? user;
    switch (userResult) {
      case Err(:final failure):
        return Err(failure);
      case Ok(:final value):
        user = value;
    }
    if (user == null) return const Err(InvalidCredentialsFailure());

    final storedResult = await _auth.getHashedPassword(user.id);
    final HashedPassword stored;
    switch (storedResult) {
      case Err(:final failure):
        return Err(failure);
      case Ok(:final value):
        stored = value;
    }

    if (!await _hasher.verify(password, stored)) {
      return const Err(InvalidCredentialsFailure());
    }

    await _session.save(user.id);
    return Ok(user);
  }
}
