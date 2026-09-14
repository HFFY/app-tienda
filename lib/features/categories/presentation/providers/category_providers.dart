import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_providers.dart';
import '../../data/datasources/category_local_data_source.dart';
import '../../data/repositories/category_repository_impl.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../../domain/usecases/delete_or_deactivate_category.dart';
import '../../domain/usecases/save_category.dart';

final categoryLocalDataSourceProvider = Provider<CategoryLocalDataSource>(
  (ref) => CategoryLocalDataSource(ref.watch(appDatabaseProvider)),
);

final categoryRepositoryProvider = Provider<CategoryRepository>(
  (ref) => CategoryRepositoryImpl(
    ref.watch(appDatabaseProvider),
    ref.watch(categoryLocalDataSourceProvider),
  ),
);

final saveCategoryProvider = Provider<SaveCategory>(
  (ref) => SaveCategory(ref.watch(categoryRepositoryProvider)),
);

final deleteOrDeactivateCategoryProvider = Provider<DeleteOrDeactivateCategory>(
  (ref) => DeleteOrDeactivateCategory(ref.watch(categoryRepositoryProvider)),
);

/// Todas las categorías (activas e inactivas) con conteo de uso, para la
/// pantalla de gestión.
final categoriesWithUsageProvider = FutureProvider<List<CategoryUsage>>((ref) async {
  final result = await ref.watch(categoryRepositoryProvider).findAllWithUsage();
  return result.getOrThrow();
});

/// Categorías activas aplicables a un alcance (`null` = todas). La consumen
/// los formularios de producto/servicio, los filtros y la venta.
final categoriesForScopeProvider =
    FutureProvider.family<List<Category>, CategoryScope?>((ref, scope) async {
  final result = await ref.watch(categoryRepositoryProvider).findAll(forScope: scope);
  return result.getOrThrow();
});

final categoryByIdProvider = FutureProvider.family<Category?, int>((ref, id) async {
  final result = await ref.watch(categoryRepositoryProvider).findById(id);
  return result.getOrThrow();
});

/// Invalida todas las vistas derivadas de categorías tras una mutación.
void invalidateCategories(Ref ref) {
  ref.invalidate(categoriesWithUsageProvider);
  ref.invalidate(categoriesForScopeProvider);
  ref.invalidate(categoryByIdProvider);
}
