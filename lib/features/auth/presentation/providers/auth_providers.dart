import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_providers.dart';
import '../../../store/presentation/providers/store_providers.dart';
import '../../data/datasources/session_local_data_source.dart';
import '../../data/datasources/user_local_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/session_repository_impl.dart';
import '../../data/services/pbkdf2_password_hasher.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/session_repository.dart';
import '../../domain/services/password_hasher.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/register_first_user.dart';

// ─── Infraestructura ────────────────────────────────────────────────────────

final passwordHasherProvider = Provider<PasswordHasher>((_) => const Pbkdf2PasswordHasher());

final userLocalDataSourceProvider = Provider<UserLocalDataSource>(
  (ref) => UserLocalDataSource(ref.watch(appDatabaseProvider)),
);

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(ref.watch(userLocalDataSourceProvider)),
);

final sessionRepositoryProvider = Provider<SessionRepository>(
  (ref) => SessionRepositoryImpl(SessionLocalDataSource(ref.watch(sharedPreferencesProvider))),
);

// ─── Casos de uso ───────────────────────────────────────────────────────────

final loginUseCaseProvider = Provider<Login>(
  (ref) => Login(
    ref.watch(authRepositoryProvider),
    ref.watch(passwordHasherProvider),
    ref.watch(sessionRepositoryProvider),
  ),
);

final registerFirstUserUseCaseProvider = Provider<RegisterFirstUser>(
  (ref) => RegisterFirstUser(
    ref.watch(authRepositoryProvider),
    ref.watch(passwordHasherProvider),
    ref.watch(sessionRepositoryProvider),
    ref.watch(storeRepositoryProvider),
  ),
);

// ─── Estado de sesión (síncrono gracias a bootstrap) ────────────────────────

/// Valores resueltos en `bootstrap()`; se sobreescriben en `ProviderScope`.
final initialSessionUserIdProvider = Provider<int?>((_) => null);
final initialHasAnyUserProvider = Provider<bool>((_) => false);

/// `id` del usuario logueado o `null`. El router lo observa para redirigir.
final sessionControllerProvider = NotifierProvider<SessionController, int?>(SessionController.new);

class SessionController extends Notifier<int?> {
  @override
  int? build() => ref.watch(initialSessionUserIdProvider);

  void login(int userId) => state = userId;

  Future<void> logout() async {
    await ref.read(sessionRepositoryProvider).clear();
    state = null;
  }
}

/// `true` cuando ya existe un usuario; si es `false` el router manda al
/// onboarding.
final hasAnyUserProvider = NotifierProvider<HasAnyUserController, bool>(HasAnyUserController.new);

class HasAnyUserController extends Notifier<bool> {
  @override
  bool build() => ref.watch(initialHasAnyUserProvider);

  void markCreated() => state = true;
}

final currentUserProvider = FutureProvider<AppUser?>((ref) async {
  final id = ref.watch(sessionControllerProvider);
  if (id == null) return null;
  final result = await ref.watch(authRepositoryProvider).findById(id);
  return result.valueOrNull;
});
