import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'bootstrap.dart';
import 'core/database/database_providers.dart';
import 'features/auth/presentation/providers/auth_providers.dart';
import 'features/store/presentation/providers/store_providers.dart';

Future<void> main() async {
  final data = await bootstrap();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(data.prefs),
        appDatabaseProvider.overrideWithValue(data.appDb),
        documentsDirProvider.overrideWithValue(data.documentsDir),
        initialStoreProvider.overrideWithValue(data.store),
        initialHasAnyUserProvider.overrideWithValue(data.hasAnyUser),
        initialSessionUserIdProvider.overrideWithValue(data.sessionUserId),
      ],
      // Riverpod 3 reintenta providers fallidos con backoff; un error de BD
      // no debe reintentarse en bucle.
      retry: (retryCount, error) => null,
      child: const AppTienda(),
    ),
  );
}
