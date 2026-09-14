import 'failure.dart';

/// Única excepción que se lanza dentro de una transacción para abortarla
/// con un [Failure] tipado. `guardDb` la convierte en `Err`.
class FailureException implements Exception {
  const FailureException(this.failure);

  final Failure failure;

  @override
  String toString() => 'FailureException($failure)';
}
