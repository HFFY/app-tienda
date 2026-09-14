import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../../categories/presentation/providers/category_providers.dart';
import '../../domain/entities/service.dart';
import '../providers/service_providers.dart';

/// Mutaciones de servicios. No es `autoDispose` (ver CLAUDE.md).
final serviceMutationsProvider =
    AsyncNotifierProvider<ServiceMutations, void>(ServiceMutations.new);

class ServiceMutations extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<({int? id, Failure? failure})> save(
    Service service, {
    XFile? newImage,
    bool removeImage = false,
  }) async {
    state = const AsyncLoading();
    final result = await ref.read(saveServiceProvider)(
      service,
      newImage: newImage,
      removeImage: removeImage,
    );
    return _finish(result.map((s) => s.id));
  }

  Future<Failure?> delete(Service service) async {
    state = const AsyncLoading();
    final result = await ref.read(deleteOrDeactivateServiceProvider).delete(service);
    return _finish(result).failure;
  }

  Future<Failure?> setActive(int id, bool active) async {
    state = const AsyncLoading();
    final uc = ref.read(deleteOrDeactivateServiceProvider);
    final result = active ? await uc.reactivate(id) : await uc.deactivate(id);
    return _finish(result).failure;
  }

  ({T? id, Failure? failure}) _finish<T>(Result<T> result) {
    switch (result) {
      case Ok(:final value):
        state = const AsyncData(null);
        invalidateServices(ref);
        ref.invalidate(categoriesWithUsageProvider);
        return (id: value, failure: null);
      case Err(:final failure):
        state = AsyncError(failure, StackTrace.current);
        return (id: null, failure: failure);
    }
  }
}
