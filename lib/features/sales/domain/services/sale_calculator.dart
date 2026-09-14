import '../../../../core/utils/money_math.dart';
import '../entities/cart.dart';
import '../entities/sale.dart';

/// Único lugar donde se calcula el dinero de una venta.
///
/// - percent: acotado a 0..100, `round(subtotal × v / 100, 2)`
/// - amount:  acotado a 0..subtotal
/// - none:    0
SaleTotals computeTotals(Cart cart) {
  var products = 0.0;
  var services = 0.0;
  for (final item in cart.items) {
    if (item.isProduct) {
      products += item.lineTotal;
    } else {
      services += item.lineTotal;
    }
  }
  products = roundMoney(products);
  services = roundMoney(services);
  final subtotal = roundMoney(products + services);

  final discount = switch (cart.discountType) {
    DiscountType.none => 0.0,
    DiscountType.percent => roundMoney(subtotal * cart.discountValue.clamp(0, 100) / 100),
    DiscountType.amount => roundMoney(cart.discountValue.clamp(0, subtotal)),
  };

  return SaleTotals(
    subtotalProducts: products,
    subtotalServices: services,
    subtotal: subtotal,
    discountAmount: discount,
    total: roundMoney(subtotal - discount),
  );
}
