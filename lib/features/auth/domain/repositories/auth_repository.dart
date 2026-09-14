import '../../../../core/error/result.dart';
import '../entities/app_user.dart';
import '../services/password_hasher.dart';

abstract interface class AuthRepository {
  Future<Result<bool>> hasAnyUser();

  /// Búsqueda insensible a mayúsculas (`COLLATE NOCASE`).
  Future<Result<AppUser?>> findByEmail(String email);

  Future<Result<AppUser?>> findById(int id);

  Future<Result<AppUser>> create({
    required String firstName,
    required String lastName,
    required String email,
    required HashedPassword password,
  });

  Future<Result<AppUser>> updateProfile(AppUser user);

  Future<Result<void>> updatePassword(int userId, HashedPassword password);

  Future<Result<HashedPassword>> getHashedPassword(int userId);
}
