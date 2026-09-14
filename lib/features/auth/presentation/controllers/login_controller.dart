import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../providers/auth_providers.dart';

/// Estado del formulario de login. `AsyncError` transporta un [Failure].
final loginControllerProvider =
    AsyncNotifierProvider.autoDispose<LoginController, void>(LoginController.new);

class LoginController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  /// Devuelve `true` si el login fue exitoso.
  Future<bool> login({required String email, required String password}) async {
    state = const AsyncLoading();
    final result = await ref.read(loginUseCaseProvider)(email: email, password: password);
    switch (result) {
      case Ok(:final value):
        ref.read(sessionControllerProvider.notifier).login(value.id);
        state = const AsyncData(null);
        return true;
      case Err(:final failure):
        state = AsyncError(failure, StackTrace.current);
        return false;
    }
  }
}

extension AsyncFailureX on AsyncValue<void> {
  /// Mensaje legible del error, si lo hay.
  String? get failureMessage {
    final e = error;
    if (e == null) return null;
    return e is Failure ? e.message : e.toString();
  }
}
