import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_providers.dart';
import '../../../../core/utils/image_storage.dart';
import '../../data/datasources/service_local_data_source.dart';
import '../../data/repositories/service_repository_impl.dart';
import '../../domain/entities/service.dart';
import '../../domain/repositories/service_repository.dart';
import '../../domain/usecases/delete_or_deactivate_service.dart';
import '../../domain/usecases/save_service.dart';

final serviceLocalDataSourceProvider = Provider<ServiceLocalDataSource>(
  (ref) => ServiceLocalDataSource(ref.watch(appDatabaseProvider)),
);

final serviceRepositoryProvider = Provider<ServiceRepository>(
  (ref) => ServiceRepositoryImpl(ref.watch(serviceLocalDataSourceProvider)),
);

final saveServiceProvider = Provider<SaveService>(
  (ref) => SaveService(ref.watch(serviceRepositoryProvider), ref.watch(imageStorageProvider)),
);

final deleteOrDeactivateServiceProvider = Provider<DeleteOrDeactivateService>(
  (ref) => DeleteOrDeactivateService(
    ref.watch(serviceRepositoryProvider),
    ref.watch(imageStorageProvider),
  ),
);

typedef ServiceFilter = ({int? categoryId, String query, bool showInactive});

final serviceFilterProvider =
    NotifierProvider<ServiceFilterController, ServiceFilter>(ServiceFilterController.new);

class ServiceFilterController extends Notifier<ServiceFilter> {
  @override
  ServiceFilter build() => (categoryId: null, query: '', showInactive: false);

  void setCategory(int? id) =>
      state = (categoryId: id, query: state.query, showInactive: state.showInactive);

  void setQuery(String q) =>
      state = (categoryId: state.categoryId, query: q, showInactive: state.showInactive);

  void setShowInactive(bool v) =>
      state = (categoryId: state.categoryId, query: state.query, showInactive: v);
}

final servicesProvider = FutureProvider<List<Service>>((ref) async {
  final f = ref.watch(serviceFilterProvider);
  final result = await ref.watch(serviceRepositoryProvider).findAll(
        categoryId: f.categoryId,
        query: f.query,
        includeInactive: f.showInactive,
      );
  return result.getOrThrow();
});

/// Servicios activos sin filtro (selector de la venta).
final activeServicesProvider = FutureProvider<List<Service>>((ref) async {
  final result = await ref.watch(serviceRepositoryProvider).findAll();
  return result.getOrThrow();
});

final serviceByIdProvider = FutureProvider.family<Service?, int>((ref, id) async {
  final result = await ref.watch(serviceRepositoryProvider).findById(id);
  return result.getOrThrow();
});

void invalidateServices(Ref ref) {
  ref.invalidate(servicesProvider);
  ref.invalidate(activeServicesProvider);
  ref.invalidate(serviceByIdProvider);
}
