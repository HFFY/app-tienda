import '../../../../core/error/result.dart';
import '../entities/inventory_movement.dart';

abstract interface class InventoryRepository {
  /// Kardex del producto, del más antiguo al más reciente.
  Future<Result<List<InventoryMovement>>> findByProduct(int productId);

  /// Registra el movimiento y aplica el delta al stock en una transacción.
  /// Falla con `InsufficientStockFailure` si el stock quedaría negativo.
  Future<Result<InventoryMovement>> register(NewMovement movement);
}
