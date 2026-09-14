import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/database/database_providers.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../../../core/utils/image_storage.dart';
import '../../data/datasources/backup_local_data_source.dart';
import '../../data/services/share_service.dart';
import '../../domain/entities/store.dart';
import '../../domain/usecases/export_backup.dart';
import '../providers/store_providers.dart';

final exportBackupProvider = Provider<ExportBackup>(
  (ref) => ExportBackup(
    BackupLocalDataSource(ref.watch(appDatabaseProvider)),
    const ShareService(),
  ),
);

/// Mutaciones de la tienda (datos, logo, moneda, respaldo). No `autoDispose`.
final storeMutationsProvider = AsyncNotifierProvider<StoreMutations, void>(StoreMutations.new);

class StoreMutations extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  /// Guarda datos + logo. Misma estrategia de imagen que productos.
  Future<Failure?> save(Store store, {XFile? newLogo, bool removeLogo = false}) async {
    state = const AsyncLoading();
    final images = ref.read(imageStorageProvider);
    final previous = store.logoPath;

    String? newPath;
    if (newLogo != null) {
      try {
        newPath = await images.persist(newLogo, folder: 'store');
      } catch (_) {
        state = const AsyncData(null);
        return const StorageFailure('No se pudo guardar el logo.');
      }
    }

    final name = store.name.trim();
    if (name.isEmpty) {
      await images.delete(newPath);
      state = const AsyncData(null);
      return const ValidationFailure('El nombre de la tienda es obligatorio.', field: 'name');
    }

    final clean = store.copyWith(
      name: name,
      address: _nullIfEmpty(store.address),
      phone: _nullIfEmpty(store.phone),
      currencySymbol: store.currencySymbol.trim().isEmpty ? store.currencyCode : store.currencySymbol.trim(),
      currencyCode: store.currencyCode.trim().toUpperCase(),
      whatsappCountryCode: store.whatsappCountryCode.replaceAll(RegExp(r'\D'), ''),
      logoPath: newPath ?? (removeLogo ? null : previous),
    );

    final result = await ref.read(storeControllerProvider.notifier).save(clean);
    switch (result) {
      case Ok():
        if ((newPath != null || removeLogo) && previous != null && previous != newPath) {
          await images.delete(previous);
        }
        state = const AsyncData(null);
        return null;
      case Err(:final failure):
        await images.delete(newPath);
        state = AsyncError(failure, StackTrace.current);
        return failure;
    }
  }

  Future<Failure?> exportBackup() async {
    state = const AsyncLoading();
    final store = ref.read(storeControllerProvider);
    final result = await ref.read(exportBackupProvider)(storeName: store.name);
    switch (result) {
      case Ok(:final value):
        await ref.read(storeControllerProvider.notifier).markBackup(value);
        state = const AsyncData(null);
        return null;
      case Err(:final failure):
        state = AsyncError(failure, StackTrace.current);
        return failure;
    }
  }

  static String? _nullIfEmpty(String? v) {
    final t = v?.trim();
    return (t == null || t.isEmpty) ? null : t;
  }
}
