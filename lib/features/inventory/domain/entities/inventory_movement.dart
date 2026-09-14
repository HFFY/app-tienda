import 'package:freezed_annotation/freezed_annotation.dart';

part 'inventory_movement.freezed.dart';

/// `in` es palabra reservada en Dart, por eso `in_`.
enum MovementType {
  in_('in', 'Entrada'),
  out('out', 'Salida'),
  adjustment('adjustment', 'Ajuste');

  const MovementType(this.dbValue, this.label);

  final String dbValue;
  final String label;

  static MovementType fromDb(String? v) =>
      values.firstWhere((e) => e.dbValue == v, orElse: () => MovementType.adjustment);
}

enum MovementReason {
  initial('initial', 'Carga inicial'),
  purchase('purchase', 'Compra'),
  sale('sale', 'Venta'),
  loss('loss', 'Pérdida / merma'),
  manual('manual', 'Manual');

  const MovementReason(this.dbValue, this.label);

  final String dbValue;
  final String label;

  static MovementReason fromDb(String? v) =>
      values.firstWhere((e) => e.dbValue == v, orElse: () => MovementReason.manual);
}

/// Movimiento registrado. [quantity] es **firmada**: positiva suma stock,
/// negativa lo resta. `stock` del producto = Σ quantity.
@freezed
abstract class InventoryMovement with _$InventoryMovement {
  const InventoryMovement._();

  const factory InventoryMovement({
    required int id,
    required int productId,
    required MovementType type,
    required int quantity,
    required MovementReason reason,
    int? saleId,
    String? note,
    required DateTime movedAt,
    required DateTime createdAt,
  }) = _InventoryMovement;

  bool get isIncrease => quantity > 0;
}

/// Movimiento a registrar. [delta] firmado según el tipo:
/// entrada → +n, salida → −n, ajuste → ±n.
@freezed
abstract class NewMovement with _$NewMovement {
  const factory NewMovement({
    required int productId,
    required MovementType type,
    required int delta,
    required MovementReason reason,
    int? saleId,
    String? note,
    DateTime? movedAt,
  }) = _NewMovement;
}
