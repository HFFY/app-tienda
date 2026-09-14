import 'dart:convert';
import 'dart:isolate';
import 'dart:math';

import 'package:cryptography/cryptography.dart';

import '../../domain/services/password_hasher.dart';

/// Iteraciones por defecto. Si en el dispositivo objetivo `hash()` tarda más
/// de ~1.5 s, bajar a 60 000 sigue siendo defendible. Los hashes existentes
/// no se ven afectados porque llevan su propio conteo.
const int kPbkdf2Iterations = 120000;

const String _algoTag = 'pbkdf2-sha256';

/// PBKDF2-HMAC-SHA256 en Dart puro. La derivación corre en un isolate para
/// no bloquear la UI (1–3 s en gama baja).
final class Pbkdf2PasswordHasher implements PasswordHasher {
  const Pbkdf2PasswordHasher({this.iterations = kPbkdf2Iterations});

  final int iterations;

  @override
  Future<HashedPassword> hash(String password) async {
    final salt = _randomSalt();
    final derived = await Isolate.run(() => _derive(password, salt, iterations));
    return HashedPassword(
      hash: '$_algoTag\$$iterations\$${base64Encode(derived)}',
      salt: base64Encode(salt),
    );
  }

  @override
  Future<bool> verify(String password, HashedPassword stored) async {
    final parts = stored.hash.split(r'$');
    if (parts.length != 3 || parts[0] != _algoTag) return false;
    final iter = int.tryParse(parts[1]);
    if (iter == null || iter <= 0) return false;

    final expected = base64Decode(parts[2]);
    final salt = base64Decode(stored.salt);
    final derived = await Isolate.run(() => _derive(password, salt, iter));
    return _constantTimeEquals(derived, expected);
  }

  static List<int> _randomSalt() {
    final rng = Random.secure();
    return List<int>.generate(16, (_) => rng.nextInt(256));
  }

  static bool _constantTimeEquals(List<int> a, List<int> b) {
    if (a.length != b.length) return false;
    var diff = 0;
    for (var i = 0; i < a.length; i++) {
      diff |= a[i] ^ b[i];
    }
    return diff == 0;
  }
}

/// Función de nivel superior para que `Isolate.run` pueda enviarla.
Future<List<int>> _derive(String password, List<int> salt, int iterations) async {
  final algorithm = Pbkdf2.hmacSha256(iterations: iterations, bits: 256);
  final key = await algorithm.deriveKeyFromPassword(password: password, nonce: salt);
  return key.extractBytes();
}
