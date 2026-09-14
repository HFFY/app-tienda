import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../../../core/utils/image_storage.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

/// Un producto con ventas o con movimientos posteriores a la carga inicial
/// no se borra: se desactiva para conservar el historial.
class DeleteOrDeactivateProduct {
  const DeleteOrDeactivateProduct(this._repo, this._images);

  final ProductRepository _repo;
  final ImageStorage _images;

  /// Transacciones que impiden el borrado (ventas + movimientos no iniciales).
  Future<Result<int>> references(int id) async {
    final sales = await _repo.countSaleReferences(id);
    final moves = await _repo.countNonInitialMovements(id);
    if (sales case Err(:final failure)) return Err(failure);
    if (moves case Err(:final failure)) return Err(failure);
    return Ok(sales.valueOrNull! + moves.valueOrNull!);
  }

  Future<Result<void>> delete(Product product) async {
    final refs = await references(product.id);
    switch (refs) {
      case Err(:final failure):
        return Err(failure);
      case Ok(:final value) when value > 0:
        return Err(ReferencedEntityFailure(count: value));
      case Ok():
        break;
    }
    final result = await _repo.delete(product.id);
    if (result.isOk) await _images.delete(product.imagePath);
    return result;
  }

  Future<Result<void>> deactivate(int id) => _repo.setActive(id, false);

  Future<Result<void>> reactivate(int id) => _repo.setActive(id, true);
}
