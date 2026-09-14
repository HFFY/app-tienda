import '../../../../core/error/result.dart';
import '../entities/store.dart';

abstract interface class StoreRepository {
  Future<Result<Store>> getStore();

  /// Persiste todos los campos editables y devuelve la tienda actualizada.
  Future<Result<Store>> update(Store store);

  Future<Result<Store>> markBackup(DateTime at);
}
