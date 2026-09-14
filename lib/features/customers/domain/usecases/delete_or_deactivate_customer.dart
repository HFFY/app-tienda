import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../repositories/customer_repository.dart';

/// Un cliente con ventas registradas nunca se borra: solo se desactiva.
class DeleteOrDeactivateCustomer {
  const DeleteOrDeactivateCustomer(this._repo);

  final CustomerRepository _repo;

  Future<Result<int>> references(int id) => _repo.countSales(id);

  Future<Result<void>> delete(int id) async {
    final count = await _repo.countSales(id);
    switch (count) {
      case Err(:final failure):
        return Err(failure);
      case Ok(:final value) when value > 0:
        return Err(ReferencedEntityFailure(count: value));
      case Ok():
        return _repo.delete(id);
    }
  }

  Future<Result<void>> deactivate(int id) => _repo.setActive(id, false);

  Future<Result<void>> reactivate(int id) => _repo.setActive(id, true);
}
