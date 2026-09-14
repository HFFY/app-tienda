import 'failure.dart';

/// Resultado de una operación: [Ok] con valor o [Err] con [Failure].
sealed class Result<T> {
  const Result();

  bool get isOk => this is Ok<T>;
  bool get isErr => this is Err<T>;

  T? get valueOrNull => switch (this) {
        Ok<T>(:final value) => value,
        Err<T>() => null,
      };

  Failure? get failureOrNull => switch (this) {
        Ok<T>() => null,
        Err<T>(:final failure) => failure,
      };

  R when<R>({
    required R Function(T value) ok,
    required R Function(Failure failure) err,
  }) =>
      switch (this) {
        Ok<T>(:final value) => ok(value),
        Err<T>(:final failure) => err(failure),
      };

  Result<R> map<R>(R Function(T value) transform) => switch (this) {
        Ok<T>(:final value) => Ok(transform(value)),
        Err<T>(:final failure) => Err(failure),
      };

  Future<Result<R>> flatMap<R>(Future<Result<R>> Function(T value) next) async =>
      switch (this) {
        Ok<T>(:final value) => await next(value),
        Err<T>(:final failure) => Err(failure),
      };

  /// Devuelve el valor o lanza el [Failure] envuelto. Útil en tests.
  T getOrThrow() => switch (this) {
        Ok<T>(:final value) => value,
        Err<T>(:final failure) => throw StateError(failure.message),
      };
}

final class Ok<T> extends Result<T> {
  const Ok(this.value);

  final T value;

  @override
  String toString() => 'Ok($value)';
}

final class Err<T> extends Result<T> {
  const Err(this.failure);

  final Failure failure;

  @override
  String toString() => 'Err($failure)';
}
