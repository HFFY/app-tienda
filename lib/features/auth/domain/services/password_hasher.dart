/// Hash + salt tal como se guardan en `app_user`.
class HashedPassword {
  const HashedPassword({required this.hash, required this.salt});

  /// Formato `pbkdf2-sha256$<iteraciones>$<base64>`; llevar las iteraciones
  /// dentro del hash permite subirlas a futuro sin migración.
  final String hash;

  /// Salt aleatorio en base64 (16 bytes).
  final String salt;
}

abstract interface class PasswordHasher {
  Future<HashedPassword> hash(String password);

  Future<bool> verify(String password, HashedPassword stored);
}
