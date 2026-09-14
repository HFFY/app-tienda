import 'package:freezed_annotation/freezed_annotation.dart';

part 'sale.freezed.dart';

enum SaleItemType {
  product('product', 'Producto'),
  service('service', 'Servicio');

  const SaleItemType(this.dbValue, this.label);

  final String dbValue;
  final String label;

  static SaleItemType fromDb(String? v) =>
      values.firstWhere((e) => e.dbValue == v, orElse: () => SaleItemType.product);
}

enum DiscountType {
  none('none', 'Sin descuento'),
  percent('percent', 'Porcentaje'),
  amount('amount', 'Monto');

  const DiscountType(this.dbValue, this.label);

  final String dbValue;
  final String label;

  static DiscountType fromDb(String? v) =>
      values.firstWhere((e) => e.dbValue == v, orElse: () => DiscountType.none);
}

/// Venta registrada. **Inmutable**: no existe edición ni anulación.
@freezed
abstract class Sale with _$Sale {
  const Sale._();

  const factory Sale({
    required int id,
    required int customerId,
    required DateTime saleDate,
    required double subtotal,
    required DiscountType discountType,
    required double discountValue,
    required double discountAmount,
    required double total,
    String? note,
    required DateTime createdAt,
    @Default(<SaleItem>[]) List<SaleItem> items,
    String? customerName,
  }) = _Sale;

  int get unitsSold => items.fold(0, (acc, i) => acc + i.quantity);
}

/// Línea de venta con los datos **congelados** al momento de vender.
@freezed
abstract class SaleItem with _$SaleItem {
  const factory SaleItem({
    required int id,
    required int saleId,
    required SaleItemType type,
    int? productId,
    int? serviceId,
    required String nameSnapshot,
    String? categorySnapshot,
    required double unitPrice,
    required int quantity,
    required double lineTotal,
  }) = _SaleItem;
}

/// Venta lista para persistir (totales ya calculados por el dominio).
@freezed
abstract class SaleDraft with _$SaleDraft {
  const factory SaleDraft({
    required int customerId,
    required double subtotal,
    required DiscountType discountType,
    required double discountValue,
    required double discountAmount,
    required double total,
    String? note,
    required List<SaleDraftItem> items,
  }) = _SaleDraft;
}

@freezed
abstract class SaleDraftItem with _$SaleDraftItem {
  const factory SaleDraftItem({
    required SaleItemType type,
    required int refId,
    required String nameSnapshot,
    String? categorySnapshot,
    required double unitPrice,
    required int quantity,
    required double lineTotal,
  }) = _SaleDraftItem;
}
