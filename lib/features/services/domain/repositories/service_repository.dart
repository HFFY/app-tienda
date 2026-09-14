import '../../../../core/error/result.dart';
import '../entities/service.dart';

abstract interface class ServiceRepository {
  Future<Result<List<Service>>> findAll({
    int? categoryId,
    String query = '',
    bool includeInactive = false,
  });

  Future<Result<Service?>> findById(int id);

  Future<Result<Service>> insert(Service draft);

  Future<Result<Service>> update(Service service);

  Future<Result<void>> delete(int id);

  Future<Result<void>> setActive(int id, bool active);

  Future<Result<int>> countSaleReferences(int id);
}
