/// Sesión persistente ("recordarme"). Lectura síncrona para que el router
/// pueda redirigir sin estados intermedios.
abstract interface class SessionRepository {
  int? readUserId();

  Future<void> save(int userId);

  Future<void> clear();
}
