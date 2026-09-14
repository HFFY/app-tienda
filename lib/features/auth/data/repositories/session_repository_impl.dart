import '../../domain/repositories/session_repository.dart';
import '../datasources/session_local_data_source.dart';

final class SessionRepositoryImpl implements SessionRepository {
  const SessionRepositoryImpl(this._ds);

  final SessionLocalDataSource _ds;

  @override
  int? readUserId() => _ds.readUserId();

  @override
  Future<void> save(int userId) => _ds.save(userId);

  @override
  Future<void> clear() => _ds.clear();
}
