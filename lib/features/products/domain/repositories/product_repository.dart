import '../../../../core/error/result.dart';
import '../entities/product.dart';

abstract interface class ProductRepository {
  Future<Result<List<Product>>> findAll({
    int? categoryId,
    String query = '',
    bool includeInactive = false,
  });

  Future<Result<Product?>> findById(int id);

  /// Inserta el producto y, si `initialStock > 0`, el movimiento
  /// `in / initial` correspondiente, en una sola transacción.
  Future<Result<Product>> create(Product draft, {required int initialStock});

  /// Actualiza datos del producto. **Nunca** toca `stock`.
  Future<Result<Product>> update(Product product);

  /// Borrado físico junto con sus movimientos. Solo debe llamarse cuando no
  /// hay ventas ni movimientos distintos de la carga inicial.
  Future<Result<void>> delete(int id);

  Future<Result<void>> setActive(int id, bool active);

  Future<Result<int>> countSaleReferences(int id);

  Future<Result<int>> countNonInitialMovements(int id);
}
