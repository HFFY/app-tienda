import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_providers.dart';
import '../../data/datasources/customer_local_data_source.dart';
import '../../data/repositories/customer_repository_impl.dart';
import '../../domain/entities/customer.dart';
import '../../domain/repositories/customer_repository.dart';
import '../../domain/usecases/delete_or_deactivate_customer.dart';
import '../../domain/usecases/save_customer.dart';

final customerLocalDataSourceProvider = Provider<CustomerLocalDataSource>(
  (ref) => CustomerLocalDataSource(ref.watch(appDatabaseProvider)),
);

final customerRepositoryProvider = Provider<CustomerRepository>(
  (ref) => CustomerRepositoryImpl(ref.watch(customerLocalDataSourceProvider)),
);

final saveCustomerProvider = Provider<SaveCustomer>(
  (ref) => SaveCustomer(ref.watch(customerRepositoryProvider)),
);

final deleteOrDeactivateCustomerProvider = Provider<DeleteOrDeactivateCustomer>(
  (ref) => DeleteOrDeactivateCustomer(ref.watch(customerRepositoryProvider)),
);

// ─── Filtro de la lista ─────────────────────────────────────────────────────

typedef CustomerFilter = ({String query, bool showInactive});

final customerFilterProvider =
    NotifierProvider<CustomerFilterController, CustomerFilter>(CustomerFilterController.new);

class CustomerFilterController extends Notifier<CustomerFilter> {
  @override
  CustomerFilter build() => (query: '', showInactive: false);

  void setQuery(String q) => state = (query: q, showInactive: state.showInactive);

  void setShowInactive(bool v) => state = (query: state.query, showInactive: v);
}

final customersProvider = FutureProvider<List<Customer>>((ref) async {
  final filter = ref.watch(customerFilterProvider);
  final result = await ref
      .watch(customerRepositoryProvider)
      .findAll(query: filter.query, includeInactive: filter.showInactive);
  return result.getOrThrow();
});

/// Clientes activos sin filtro (selector de la venta).
final activeCustomersProvider = FutureProvider<List<Customer>>((ref) async {
  final result = await ref.watch(customerRepositoryProvider).findAll();
  return result.getOrThrow();
});

final customerByIdProvider = FutureProvider.family<Customer?, int>((ref, id) async {
  final result = await ref.watch(customerRepositoryProvider).findById(id);
  return result.getOrThrow();
});

final customerStatsProvider = FutureProvider.family<CustomerStats, int>((ref, id) async {
  final result = await ref.watch(customerRepositoryProvider).stats(id);
  return result.getOrThrow();
});

void invalidateCustomers(Ref ref) {
  ref.invalidate(customersProvider);
  ref.invalidate(activeCustomersProvider);
  ref.invalidate(customerByIdProvider);
  ref.invalidate(customerStatsProvider);
}
