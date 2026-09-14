import 'package:shared_preferences/shared_preferences.dart';

final class SessionLocalDataSource {
  const SessionLocalDataSource(this._prefs);

  static const _key = 'session_user_id';

  final SharedPreferences _prefs;

  int? readUserId() => _prefs.getInt(_key);

  Future<void> save(int userId) => _prefs.setInt(_key, userId);

  Future<void> clear() => _prefs.remove(_key);
}
