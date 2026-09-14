import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/usecases/change_password.dart';
import '../../domain/usecases/update_profile.dart';
import '../providers/auth_providers.dart';

final updateProfileProvider = Provider<UpdateProfile>(
  (ref) => UpdateProfile(ref.watch(authRepositoryProvider)),
);

final changePasswordProvider = Provider<ChangePassword>(
  (ref) => ChangePassword(ref.watch(authRepositoryProvider), ref.watch(passwordHasherProvider)),
);

/// Mutaciones del usuario. No `autoDispose`.
final userMutationsProvider = AsyncNotifierProvider<UserMutations, void>(UserMutations.new);

class UserMutations extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<Failure?> updateProfile(AppUser user) async {
    state = const AsyncLoading();
    final result = await ref.read(updateProfileProvider)(user);
    return _finish(result);
  }

  Future<Failure?> changePassword({
    required int userId,
    required String current,
    required String next,
    required String confirm,
  }) async {
    state = const AsyncLoading();
    final result = await ref.read(changePasswordProvider)(
      userId: userId,
      current: current,
      next: next,
      confirm: confirm,
    );
    return _finish(result);
  }

  Failure? _finish<T>(Result<T> result) {
    switch (result) {
      case Ok():
        state = const AsyncData(null);
        ref.invalidate(currentUserProvider);
        return null;
      case Err(:final failure):
        state = AsyncError(failure, StackTrace.current);
        return failure;
    }
  }
}
