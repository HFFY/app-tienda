/// Fallos de dominio. Cada uno lleva un mensaje en español listo para
/// mostrarse en un `SnackBar` o en el estado de error de una pantalla.
sealed class Failure {
  const Failure(this.message);

  final String message;

  @override
  String toString() => '$runtimeType($message)';
}

final class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'El registro no existe.']);
}

final class ValidationFailure extends Failure {
  const ValidationFailure(super.message, {this.field});

  final String? field;
}

final class DuplicateFailure extends Failure {
  const DuplicateFailure([super.message = 'Ya existe un registro con ese valor.']);
}

/// La entidad tiene transacciones asociadas y no puede eliminarse.
final class ReferencedEntityFailure extends Failure {
  const ReferencedEntityFailure({
    required this.count,
    this.productCount = 0,
    this.serviceCount = 0,
    String? message,
  }) : super(message ?? 'Tiene $count transacciones registradas y no puede eliminarse.');

  final int count;
  final int productCount;
  final int serviceCount;
}

final class InsufficientStockFailure extends Failure {
  InsufficientStockFailure({
    required this.productName,
    required this.available,
    required this.requested,
  }) : super('Stock insuficiente de "$productName": hay $available y se piden $requested.');

  final String productName;
  final int available;
  final int requested;
}

final class InvalidCredentialsFailure extends Failure {
  const InvalidCredentialsFailure([super.message = 'Email o contraseña incorrectos.']);
}

final class StorageFailure extends Failure {
  const StorageFailure([super.message = 'No se pudo acceder al almacenamiento.']);
}

final class DatabaseFailure extends Failure {
  const DatabaseFailure(this.cause, [super.message = 'Error en la base de datos.']);

  final Object cause;
}

final class UnexpectedFailure extends Failure {
  const UnexpectedFailure(this.cause, [super.message = 'Ocurrió un error inesperado.']);

  final Object cause;
}
