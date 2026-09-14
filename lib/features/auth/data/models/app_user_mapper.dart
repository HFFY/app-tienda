import '../../../../core/database/tables.dart';
import '../../../../core/utils/clock.dart';
import '../../domain/entities/app_user.dart';

AppUser appUserFromMap(Map<String, Object?> m) => AppUser(
      id: m[UserCols.id] as int,
      firstName: m[UserCols.firstName] as String,
      lastName: m[UserCols.lastName] as String,
      email: m[UserCols.email] as String,
      createdAt: parseUtc(m[UserCols.createdAt] as String),
      updatedAt: parseUtc(m[UserCols.updatedAt] as String),
    );

extension AppUserMapper on AppUser {
  Map<String, Object?> toProfileMap() => {
        UserCols.firstName: firstName,
        UserCols.lastName: lastName,
        UserCols.email: email.trim().toLowerCase(),
        UserCols.updatedAt: nowUtcIso(),
      };
}
