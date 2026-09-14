import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_providers.dart';
import '../../../../core/error/result.dart';
import '../../../../core/theme/theme_options.dart';
import '../../../../core/utils/money_formatter.dart';
import '../../data/datasources/store_local_data_source.dart';
import '../../data/repositories/store_repository_impl.dart';
import '../../domain/entities/store.dart';
import '../../domain/repositories/store_repository.dart';

final storeLocalDataSourceProvider = Provider<StoreLocalDataSource>(
  (ref) => StoreLocalDataSource(ref.watch(appDatabaseProvider)),
);

final storeRepositoryProvider = Provider<StoreRepository>(
  (ref) => StoreRepositoryImpl(ref.watch(storeLocalDataSourceProvider)),
);

/// Tienda leída en `bootstrap()`; se sobreescribe en `ProviderScope`.
final initialStoreProvider = Provider<Store>(
  (_) => throw UnimplementedError('initialStoreProvider debe sobreescribirse en bootstrap()'),
);

/// Fuente única de la configuración de la tienda (tema, moneda, datos).
/// `build()` es síncrono gracias a [initialStoreProvider], así el primer
/// frame ya sale con el tema correcto.
final storeControllerProvider = NotifierProvider<StoreController, Store>(StoreController.new);

class StoreController extends Notifier<Store> {
  @override
  Store build() => ref.watch(initialStoreProvider);

  Future<Result<Store>> save(Store store) async {
    final result = await ref.read(storeRepositoryProvider).update(store);
    if (result case Ok(:final value)) state = value;
    return result;
  }

  Future<Result<Store>> setThemeColor(ThemeColorOption color) =>
      save(state.copyWith(themeColor: color));

  Future<Result<Store>> setThemeMode(ThemeModeOption mode) =>
      save(state.copyWith(themeMode: mode));

  Future<Result<Store>> markBackup(DateTime at) async {
    final result = await ref.read(storeRepositoryProvider).markBackup(at);
    if (result case Ok(:final value)) state = value;
    return result;
  }

  /// Recarga desde la base (p. ej. tras restaurar o cargar datos demo).
  Future<void> reload() async {
    final result = await ref.read(storeRepositoryProvider).getStore();
    if (result case Ok(:final value)) state = value;
  }
}

/// Formateador de dinero derivado de la tienda. Todo monto de la UI pasa por
/// aquí.
final moneyFormatterProvider = Provider<MoneyFormatter>((ref) {
  final store = ref.watch(storeControllerProvider);
  return MoneyFormatter(
    locale: store.numberLocale,
    symbol: store.currencySymbol,
    decimals: store.decimalPlaces,
  );
});

final themeColorProvider = Provider<ThemeColorOption>(
  (ref) => ref.watch(storeControllerProvider.select((s) => s.themeColor)),
);

final themeModeOptionProvider = Provider<ThemeModeOption>(
  (ref) => ref.watch(storeControllerProvider.select((s) => s.themeMode)),
);
