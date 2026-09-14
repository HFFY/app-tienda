import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/database/app_database.dart';
import 'features/auth/data/datasources/session_local_data_source.dart';
import 'features/auth/data/datasources/user_local_data_source.dart';
import 'features/store/data/datasources/store_local_data_source.dart';
import 'features/store/data/models/store_mapper.dart';
import 'features/store/domain/entities/store.dart';

/// Todo lo que la app necesita tener resuelto **antes** del primer frame.
/// El splash nativo cubre esta espera, así los `Notifier` de tienda y sesión
/// pueden construirse de forma síncrona y el router redirige sin estados
/// intermedios de "cargando".
class BootstrapData {
  const BootstrapData({
    required this.prefs,
    required this.appDb,
    required this.documentsDir,
    required this.store,
    required this.hasAnyUser,
    required this.sessionUserId,
  });

  final SharedPreferences prefs;
  final AppDatabase appDb;
  final Directory documentsDir;
  final Store store;
  final bool hasAnyUser;
  final int? sessionUserId;
}

Future<BootstrapData> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Sin esto, DateFormat('es') lanza. La UI es solo en español.
  await initializeDateFormatting('es');
  Intl.defaultLocale = 'es';

  final prefs = await SharedPreferences.getInstance();
  final appDb = await AppDatabase.open();
  final documentsDir = await getApplicationDocumentsDirectory();

  final store = storeFromMap(await StoreLocalDataSource(appDb).getStore());

  final users = UserLocalDataSource(appDb);
  final hasAnyUser = await users.count() > 0;

  // La sesión guardada puede apuntar a un usuario que ya no existe
  // (borrado parcial de datos, futura restauración de respaldo).
  final session = SessionLocalDataSource(prefs);
  var sessionUserId = session.readUserId();
  if (sessionUserId != null && await users.findById(sessionUserId) == null) {
    await session.clear();
    sessionUserId = null;
  }

  if (kDebugMode) {
    final version = await appDb.sqliteVersion();
    debugPrint('[app_tienda] SQLite $version en ${appDb.path}');
  }

  return BootstrapData(
    prefs: prefs,
    appDb: appDb,
    documentsDir: documentsDir,
    store: store,
    hasAnyUser: hasAnyUser,
    sessionUserId: sessionUserId,
  );
}
