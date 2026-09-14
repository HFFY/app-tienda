import '../../../../core/error/db_guard.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/error/failure_exception.dart';
import '../../../../core/error/result.dart';
import '../../../../core/utils/clock.dart';
import '../../domain/entities/customer.dart';
import '../../domain/repositories/customer_repository.dart';
import '../datasources/customer_local_data_source.dart';
import '../models/customer_mapper.dart';

final class CustomerRepositoryImpl implements CustomerRepository {
  const CustomerRepositoryImpl(this._ds);

  final CustomerLocalDataSource _ds;

  @override
  Future<Result<List<Customer>>> findAll({String query = '', bool includeInactive = false}) =>
      guardDb(() async {
        final rows = await _ds.findAll(query: query, includeInactive: includeInactive);
        return rows.map(customerFromMap).toList();
      });

  @override
  Future<Result<Customer?>> findById(int id) => guardDb(() async {
        final row = await _ds.findById(id);
        return row == null ? null : customerFromMap(row);
      });

  @override
  Future<Result<Customer>> insert(Customer draft) => guardDb(() async {
        final id = await _ds.insert(draft.toInsertMap());
        return customerFromMap(await _ds.getById(id));
      });

  @override
  Future<Result<Customer>> update(Customer customer) => guardDb(() async {
        final changed = await _ds.update(customer.id, customer.toUpdateMap());
        if (changed == 0) throw const FailureException(NotFoundFailure('El cliente no existe.'));
        return customerFromMap(await _ds.getById(customer.id));
      });

  @override
  Future<Result<void>> delete(int id) => guardDb(() => _ds.delete(id));

  @override
  Future<Result<void>> setActive(int id, bool active) => guardDb(() => _ds.setActive(id, active));

  @override
  Future<Result<int>> countSales(int id) => guardDb(() => _ds.countSales(id));

  @override
  Future<Result<CustomerStats>> stats(int id) => guardDb(() async {
        final s = await _ds.stats(id);
        return CustomerStats(
          salesCount: s.count,
          totalSpent: s.spent,
          lastPurchaseAt: s.lastAt == null ? null : parseUtc(s.lastAt!),
        );
      });
}
