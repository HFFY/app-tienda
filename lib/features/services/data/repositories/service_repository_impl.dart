import '../../../../core/error/db_guard.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/error/failure_exception.dart';
import '../../../../core/error/result.dart';
import '../../domain/entities/service.dart';
import '../../domain/repositories/service_repository.dart';
import '../datasources/service_local_data_source.dart';
import '../models/service_mapper.dart';

final class ServiceRepositoryImpl implements ServiceRepository {
  const ServiceRepositoryImpl(this._ds);

  final ServiceLocalDataSource _ds;

  @override
  Future<Result<List<Service>>> findAll({
    int? categoryId,
    String query = '',
    bool includeInactive = false,
  }) =>
      guardDb(() async {
        final rows = await _ds.findAll(categoryId: categoryId, query: query, includeInactive: includeInactive);
        return rows.map(serviceFromMap).toList();
      });

  @override
  Future<Result<Service?>> findById(int id) => guardDb(() async {
        final row = await _ds.findById(id);
        return row == null ? null : serviceFromMap(row);
      });

  @override
  Future<Result<Service>> insert(Service draft) => guardDb(() async {
        final id = await _ds.insert(draft.toInsertMap());
        return serviceFromMap(await _ds.getById(id));
      });

  @override
  Future<Result<Service>> update(Service service) => guardDb(() async {
        final changed = await _ds.update(service.id, service.toUpdateMap());
        if (changed == 0) throw const FailureException(NotFoundFailure('El servicio no existe.'));
        return serviceFromMap(await _ds.getById(service.id));
      });

  @override
  Future<Result<void>> delete(int id) => guardDb(() => _ds.delete(id));

  @override
  Future<Result<void>> setActive(int id, bool active) => guardDb(() => _ds.setActive(id, active));

  @override
  Future<Result<int>> countSaleReferences(int id) => guardDb(() => _ds.countSaleReferences(id));
}
