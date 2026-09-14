import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../entities/inventory_movement.dart';
import '../repositories/inventory_repository.dart';

/// Única puerta de entrada para cambiar el stock desde la UI. Las ventas
/// usan el mismo DataSource dentro de su propia transacción.
class RegisterInventoryMovement {
  const RegisterInventoryMovement(this._repo);

  final InventoryRepository _repo;

  Future<Result<InventoryMovement>> call({
    required int productId,
    required MovementType type,
    required int quantity,
    required MovementReason reason,
    String? note,
  }) {
    if (quantity == 0) {
      return Future.value(const Err(ValidationFailure('La cantidad no puede ser 0.', field: 'quantity')));
    }
    final cleanNote = note?.trim();
    if (type == MovementType.adjustment && (cleanNote == null || cleanNote.isEmpty)) {
      return Future.value(
        const Err(ValidationFailure('Los ajustes requieren una nota explicativa.', field: 'note')),
      );
    }

    final delta = switch (type) {
      MovementType.in_ => quantity.abs(),
      MovementType.out => -quantity.abs(),
      MovementType.adjustment => quantity,
    };

    return _repo.register(
      NewMovement(
        productId: productId,
        type: type,
        delta: delta,
        reason: reason,
        note: (cleanNote == null || cleanNote.isEmpty) ? null : cleanNote,
      ),
    );
  }
}
