import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../../../core/utils/image_storage.dart';
import '../entities/service.dart';
import '../repositories/service_repository.dart';

class DeleteOrDeactivateService {
  const DeleteOrDeactivateService(this._repo, this._images);

  final ServiceRepository _repo;
  final ImageStorage _images;

  Future<Result<int>> references(int id) => _repo.countSaleReferences(id);

  Future<Result<void>> delete(Service service) async {
    final refs = await _repo.countSaleReferences(service.id);
    switch (refs) {
      case Err(:final failure):
        return Err(failure);
      case Ok(:final value) when value > 0:
        return Err(ReferencedEntityFailure(count: value));
      case Ok():
        break;
    }
    final result = await _repo.delete(service.id);
    if (result.isOk) await _images.delete(service.imagePath);
    return result;
  }

  Future<Result<void>> deactivate(int id) => _repo.setActive(id, false);

  Future<Result<void>> reactivate(int id) => _repo.setActive(id, true);
}
