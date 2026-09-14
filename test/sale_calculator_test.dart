import 'package:app_tienda/features/sales/domain/entities/cart.dart';
import 'package:app_tienda/features/sales/domain/entities/sale.dart';
import 'package:app_tienda/features/sales/domain/services/sale_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const gaseosa = CartItem(type: SaleItemType.product, refId: 1, name: 'Gaseosa', unitPrice: 8.5, quantity: 2);
  const corte = CartItem(type: SaleItemType.service, refId: 1, name: 'Corte', unitPrice: 35, quantity: 1);

  group('computeTotals', () {
    test('suma subtotales por tipo y total sin descuento', () {
      final t = computeTotals(const Cart(items: [gaseosa, corte]));
      expect(t.subtotalProducts, 17.0);
      expect(t.subtotalServices, 35.0);
      expect(t.subtotal, 52.0);
      expect(t.discountAmount, 0);
      expect(t.total, 52.0);
    });

    test('descuento porcentual redondeado a 2 decimales', () {
      final t = computeTotals(const Cart(
        items: [CartItem(type: SaleItemType.product, refId: 1, name: 'x', unitPrice: 123.45)],
        discountType: DiscountType.percent,
        discountValue: 10,
      ));
      expect(t.discountAmount, 12.35); // 12.345 → 12.35 (half-up)
      expect(t.total, 111.10);
    });

    test('porcentaje se acota a 0..100', () {
      final t = computeTotals(const Cart(items: [corte], discountType: DiscountType.percent, discountValue: 150));
      expect(t.discountAmount, 35.0);
      expect(t.total, 0);
    });

    test('monto se acota al subtotal', () {
      final t = computeTotals(const Cart(items: [gaseosa], discountType: DiscountType.amount, discountValue: 999));
      expect(t.discountAmount, 17.0);
      expect(t.total, 0);
    });

    test('carrito vacío da ceros', () {
      final t = computeTotals(const Cart());
      expect(t.subtotal, 0);
      expect(t.total, 0);
    });
  });
}
