import '../../../../core/database/tables.dart';
import '../../../../core/utils/clock.dart';
import '../../domain/entities/inventory_movement.dart';

InventoryMovement movementFromMap(Map<String, Object?> m) => InventoryMovement(
      id: m[MovementCols.id] as int,
      productId: m[MovementCols.productId] as int,
      type: MovementType.fromDb(m[MovementCols.movementType] as String?),
      quantity: m[MovementCols.quantity] as int,
      reason: MovementReason.fromDb(m[MovementCols.reason] as String?),
      saleId: m[MovementCols.saleId] as int?,
      note: m[MovementCols.note] as String?,
      movedAt: parseUtc(m[MovementCols.movedAt] as String),
      createdAt: parseUtc(m[MovementCols.createdAt] as String),
    );

extension NewMovementMapper on NewMovement {
  Map<String, Object?> toInsertMap() {
    final now = nowUtcIso();
    return {
      MovementCols.productId: productId,
      MovementCols.movementType: type.dbValue,
      MovementCols.quantity: delta,
      MovementCols.reason: reason.dbValue,
      MovementCols.saleId: saleId,
      MovementCols.note: note,
      MovementCols.movedAt: movedAt == null ? now : toUtcIso(movedAt!),
      MovementCols.createdAt: now,
    };
  }
}
