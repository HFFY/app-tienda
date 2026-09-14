import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../domain/entities/customer.dart';
import '../providers/customer_providers.dart';

/// Mutaciones de clientes. No es `autoDispose` (ver CLAUDE.md).
final customerMutationsProvider =
    AsyncNotifierProvider<CustomerMutations, void>(CustomerMutations.new);

class CustomerMutations extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<({int? id, Failure? failure})> save(Customer customer) async {
    state = const AsyncLoading();
    final result = await ref.read(saveCustomerProvider)(customer);
    return _finish(result.map((c) => c.id));
  }

  Future<Failure?> delete(int id) async {
    state = const AsyncLoading();
    final result = await ref.read(deleteOrDeactivateCustomerProvider).delete(id);
    return _finish(result).failure;
  }

  Future<Failure?> setActive(int id, bool active) async {
    state = const AsyncLoading();
    final uc = ref.read(deleteOrDeactivateCustomerProvider);
    final result = active ? await uc.reactivate(id) : await uc.deactivate(id);
    return _finish(result).failure;
  }

  ({T? id, Failure? failure}) _finish<T>(Result<T> result) {
    switch (result) {
      case Ok(:final value):
        state = const AsyncData(null);
        invalidateCustomers(ref);
        return (id: value, failure: null);
      case Err(:final failure):
        state = AsyncError(failure, StackTrace.current);
        return (id: null, failure: failure);
    }
  }
}
