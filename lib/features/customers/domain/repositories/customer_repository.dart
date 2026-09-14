import '../../../../core/error/result.dart';
import '../entities/customer.dart';

abstract interface class CustomerRepository {
  /// Búsqueda por nombre completo o teléfono, ordenada por apellido/nombre.
  Future<Result<List<Customer>>> findAll({String query = '', bool includeInactive = false});

  Future<Result<Customer?>> findById(int id);

  Future<Result<Customer>> insert(Customer draft);

  Future<Result<Customer>> update(Customer customer);

  Future<Result<void>> delete(int id);

  Future<Result<void>> setActive(int id, bool active);

  Future<Result<int>> countSales(int id);

  Future<Result<CustomerStats>> stats(int id);
}
