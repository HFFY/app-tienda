import '../../../../core/error/db_guard.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/error/failure_exception.dart';
import '../../../../core/error/result.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/services/password_hasher.dart';
import '../datasources/user_local_data_source.dart';
import '../models/app_user_mapper.dart';

final class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._ds);

  final UserLocalDataSource _ds;

  @override
  Future<Result<bool>> hasAnyUser() => guardDb(() async => await _ds.count() > 0);

  @override
  Future<Result<AppUser?>> findByEmail(String email) => guardDb(() async {
        final row = await _ds.findByEmail(email);
        return row == null ? null : appUserFromMap(row);
      });

  @override
  Future<Result<AppUser?>> findById(int id) => guardDb(() async {
        final row = await _ds.findById(id);
        return row == null ? null : appUserFromMap(row);
      });

  @override
  Future<Result<AppUser>> create({
    required String firstName,
    required String lastName,
    required String email,
    required HashedPassword password,
  }) =>
      guardDb(() async {
        final id = await _ds.insert(
          firstName: firstName,
          lastName: lastName,
          email: email,
          passwordHash: password.hash,
          passwordSalt: password.salt,
        );
        return appUserFromMap(await _ds.getById(id));
      });

  @override
  Future<Result<AppUser>> updateProfile(AppUser user) => guardDb(() async {
        await _ds.update(user.id, user.toProfileMap());
        return appUserFromMap(await _ds.getById(user.id));
      });

  @override
  Future<Result<void>> updatePassword(int userId, HashedPassword password) =>
      guardDb(() => _ds.updatePassword(userId, password.hash, password.salt));

  @override
  Future<Result<HashedPassword>> getHashedPassword(int userId) => guardDb(() async {
        final creds = await _ds.getCredentials(userId);
        if (creds == null) throw const FailureException(NotFoundFailure('El usuario no existe.'));
        return HashedPassword(hash: creds.hash, salt: creds.salt);
      });
}
