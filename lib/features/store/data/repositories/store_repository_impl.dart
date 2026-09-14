import '../../../../core/error/db_guard.dart';
import '../../../../core/error/result.dart';
import '../../domain/entities/store.dart';
import '../../domain/repositories/store_repository.dart';
import '../datasources/store_local_data_source.dart';
import '../models/store_mapper.dart';

final class StoreRepositoryImpl implements StoreRepository {
  const StoreRepositoryImpl(this._ds);

  final StoreLocalDataSource _ds;

  @override
  Future<Result<Store>> getStore() => guardDb(() async => storeFromMap(await _ds.getStore()));

  @override
  Future<Result<Store>> update(Store store) => guardDb(() async {
        await _ds.update(store.toUpdateMap());
        return storeFromMap(await _ds.getStore());
      });

  @override
  Future<Result<Store>> markBackup(DateTime at) => guardDb(() async {
        await _ds.markBackup(at);
        return storeFromMap(await _ds.getStore());
      });
}
