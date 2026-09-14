import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_database.dart';

/// Estos providers se sobreescriben en `ProviderScope(overrides:)` desde
/// `bootstrap()`, que ya los tiene inicializados antes del primer frame.
final appDatabaseProvider = Provider<AppDatabase>(
  (_) => throw UnimplementedError('appDatabaseProvider debe sobreescribirse en bootstrap()'),
);

final sharedPreferencesProvider = Provider<SharedPreferences>(
  (_) => throw UnimplementedError('sharedPreferencesProvider debe sobreescribirse en bootstrap()'),
);

/// Directorio de documentos de la app; base para rutas relativas de imágenes.
final documentsDirProvider = Provider<Directory>(
  (_) => throw UnimplementedError('documentsDirProvider debe sobreescribirse en bootstrap()'),
);
