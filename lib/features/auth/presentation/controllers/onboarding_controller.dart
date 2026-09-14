import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/result.dart';
import '../../../store/presentation/providers/store_providers.dart';
import '../providers/auth_providers.dart';

final onboardingControllerProvider =
    AsyncNotifierProvider.autoDispose<OnboardingController, void>(OnboardingController.new);

class OnboardingController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<bool> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String storeName,
  }) async {
    state = const AsyncLoading();
    final result = await ref.read(registerFirstUserUseCaseProvider)(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      storeName: storeName,
    );
    switch (result) {
      case Ok(:final value):
        // El nombre de la tienda pudo cambiar: refrescar la fuente única.
        await ref.read(storeControllerProvider.notifier).reload();
        ref.read(hasAnyUserProvider.notifier).markCreated();
        ref.read(sessionControllerProvider.notifier).login(value.id);
        state = const AsyncData(null);
        return true;
      case Err(:final failure):
        state = AsyncError(failure, StackTrace.current);
        return false;
    }
  }
}
