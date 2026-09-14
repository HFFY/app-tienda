import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../entities/customer.dart';
import '../repositories/customer_repository.dart';

class SaveCustomer {
  const SaveCustomer(this._repo);

  final CustomerRepository _repo;

  Future<Result<Customer>> call(Customer customer) {
    final first = customer.firstName.trim();
    final last = customer.lastName.trim();
    if (first.isEmpty) {
      return Future.value(const Err(ValidationFailure('El nombre es obligatorio.', field: 'firstName')));
    }
    if (last.isEmpty) {
      return Future.value(const Err(ValidationFailure('El apellido es obligatorio.', field: 'lastName')));
    }
    final phone = customer.phone?.trim();
    final notes = customer.notes?.trim();
    final clean = customer.copyWith(
      firstName: first,
      lastName: last,
      phone: (phone == null || phone.isEmpty) ? null : phone,
      notes: (notes == null || notes.isEmpty) ? null : notes,
    );
    return clean.isNew ? _repo.insert(clean) : _repo.update(clean);
  }
}
