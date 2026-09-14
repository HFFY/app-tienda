import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';

/// Usuario de la aplicación. Nunca transporta el hash de la contraseña.
@freezed
abstract class AppUser with _$AppUser {
  const AppUser._();

  const factory AppUser({
    required int id,
    required String firstName,
    required String lastName,
    required String email,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _AppUser;

  String get fullName => '$firstName $lastName'.trim();

  String get initials {
    final f = firstName.trim().isEmpty ? '' : firstName.trim()[0];
    final l = lastName.trim().isEmpty ? '' : lastName.trim()[0];
    final r = (f + l).toUpperCase();
    return r.isEmpty ? '?' : r;
  }
}
