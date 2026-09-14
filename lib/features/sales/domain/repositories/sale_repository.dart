import '../../../../core/error/result.dart';
import '../entities/sale.dart';

abstract interface class SaleRepository {
  /// Inserta venta + detalle, descuenta stock y registra los movimientos en
  /// **una** transacción. Falla con `InsufficientStockFailure` sin dejar
  /// rastro si algún producto no alcanza.
  Future<Result<Sale>> register(SaleDraft draft);

  Future<Result<Sale?>> findById(int id);
}
