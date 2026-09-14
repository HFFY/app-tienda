import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/utils/money_math.dart';
import '../../../customers/domain/entities/customer.dart';
import 'sale.dart';

part 'cart.freezed.dart';

/// Ítem del carrito de la venta en curso.
@freezed
abstract class CartItem with _$CartItem {
  const CartItem._();

  const factory CartItem({
    required SaleItemType type,
    required int refId,
    required String name,
    String? categoryName,
    required double unitPrice,
    @Default(1) int quantity,

    /// Stock disponible al agregar (solo productos); la verdad la impone la
    /// transacción al registrar.
    int? availableStock,
  }) = _CartItem;

  String get key => '${type.dbValue}-$refId';

  double get lineTotal => roundMoney(unitPrice * quantity);

  bool get isProduct => type == SaleItemType.product;

  bool get canIncrement => availableStock == null || quantity < availableStock!;
}

@freezed
abstract class Cart with _$Cart {
  const Cart._();

  const factory Cart({
    Customer? customer,
    @Default(<CartItem>[]) List<CartItem> items,
    @Default(DiscountType.none) DiscountType discountType,
    @Default(0) double discountValue,
    String? note,
  }) = _Cart;

  bool get isEmpty => items.isEmpty;

  bool get canRegister => customer != null && items.isNotEmpty;

  int get unitCount => items.fold(0, (acc, i) => acc + i.quantity);
}

/// Totales calculados por `computeTotals`.
@freezed
abstract class SaleTotals with _$SaleTotals {
  const factory SaleTotals({
    required double subtotalProducts,
    required double subtotalServices,
    required double subtotal,
    required double discountAmount,
    required double total,
  }) = _SaleTotals;
}
