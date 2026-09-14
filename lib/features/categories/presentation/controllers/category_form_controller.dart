import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../domain/entities/category.dart';
import '../providers/category_providers.dart';

/// Mutaciones de categorías. Devuelve el [Failure] (o `null` si fue bien)
/// para que la pantalla lo muestre en un SnackBar.
///
/// No es `autoDispose`: se invoca con `ref.read` tras `await`s (diálogos),
/// y un provider sin oyentes se destruiría a mitad de la operación.
final categoryMutationsProvider =
    AsyncNotifierProvider<CategoryMutations, void>(CategoryMutations.new);

class CategoryMutations extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<({int? id, Failure? failure})> save(Category category) async {
    state = const AsyncLoading();
    final result = await ref.read(saveCategoryProvider)(category);
    return _finish(result.map((c) => c.id));
  }

  Future<Failure?> delete(int id) async {
    state = const AsyncLoading();
    final result = await ref.read(deleteOrDeactivateCategoryProvider).delete(id);
    return _finish(result).failure;
  }

  Future<Failure?> setActive(int id, bool active) async {
    state = const AsyncLoading();
    final uc = ref.read(deleteOrDeactivateCategoryProvider);
    final result = active ? await uc.reactivate(id) : await uc.deactivate(id);
    return _finish(result).failure;
  }

  Future<Failure?> reorder(List<int> orderedIds) async {
    final result = await ref.read(categoryRepositoryProvider).reorder(orderedIds);
    return _finish(result).failure;
  }

  ({T? id, Failure? failure}) _finish<T>(Result<T> result) {
    switch (result) {
      case Ok(:final value):
        state = const AsyncData(null);
        invalidateCategories(ref);
        return (id: value, failure: null);
      case Err(:final failure):
        state = AsyncError(failure, StackTrace.current);
        return (id: null, failure: failure);
    }
  }
}
