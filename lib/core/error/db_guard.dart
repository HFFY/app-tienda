import 'package:sqflite/sqflite.dart';

import 'failure.dart';
import 'failure_exception.dart';
import 'result.dart';

/// Ejecuta [body] y convierte cualquier error en un [Result].
///
/// - [FailureException] → su [Failure] (p. ej. stock insuficiente dentro de
///   una transacción).
/// - [DatabaseException] de unicidad → [DuplicateFailure].
/// - [DatabaseException] de clave foránea → [ReferencedEntityFailure].
/// - Cualquier otro [DatabaseException] → [DatabaseFailure].
/// - Cualquier otro error → [UnexpectedFailure].
///
/// Los repositorios envuelven todos sus métodos con este helper y no
/// contienen `try/catch` propios.
Future<Result<T>> guardDb<T>(Future<T> Function() body) async {
  try {
    return Ok(await body());
  } on FailureException catch (e) {
    return Err(e.failure);
  } on DatabaseException catch (e) {
    if (e.isUniqueConstraintError()) {
      return const Err(DuplicateFailure());
    }
    final msg = e.toString();
    if (msg.contains('FOREIGN KEY constraint failed')) {
      return const Err(
        ReferencedEntityFailure(
          count: 0,
          message: 'El registro está en uso y no puede eliminarse.',
        ),
      );
    }
    return Err(DatabaseFailure(e));
  } catch (e) {
    return Err(UnexpectedFailure(e));
  }
}
