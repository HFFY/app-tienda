import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../entities/app_user.dart';
import '../repositories/auth_repository.dart';

class UpdateProfile {
  const UpdateProfile(this._auth);

  final AuthRepository _auth;

  Future<Result<AppUser>> call(AppUser user) {
    final first = user.firstName.trim();
    final last = user.lastName.trim();
    final email = user.email.trim().toLowerCase();
    if (first.isEmpty || last.isEmpty) {
      return Future.value(const Err(ValidationFailure('Nombre y apellido son obligatorios.')));
    }
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
      return Future.value(const Err(ValidationFailure('Ingresa un email válido.', field: 'email')));
    }
    return _auth.updateProfile(user.copyWith(firstName: first, lastName: last, email: email));
  }
}
