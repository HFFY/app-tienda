import '../../../../core/error/result.dart';
import '../repositories/category_repository.dart';

/// Una categoría **sí** puede eliminarse aunque tenga uso (los productos y
/// servicios quedan "Sin categoría"), pero el popup avisa cuántos son y
/// ofrece desactivar como alternativa no destructiva.
class DeleteOrDeactivateCategory {
  const DeleteOrDeactivateCategory(this._repo);

  final CategoryRepository _repo;

  Future<Result<({int products, int services})>> references(int id) => _repo.countReferences(id);

  Future<Result<void>> delete(int id) => _repo.delete(id);

  Future<Result<void>> deactivate(int id) => _repo.setActive(id, false);

  Future<Result<void>> reactivate(int id) => _repo.setActive(id, true);
}
