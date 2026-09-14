import '../../../../core/database/tables.dart';
import '../../../../core/theme/theme_options.dart';
import '../../../../core/utils/clock.dart';
import '../../domain/entities/store.dart';

Store storeFromMap(Map<String, Object?> m) => Store(
      id: m[StoreCols.id] as int,
      name: m[StoreCols.name] as String,
      logoPath: m[StoreCols.logoPath] as String?,
      address: m[StoreCols.address] as String?,
      phone: m[StoreCols.phone] as String?,
      themeColor: ThemeColorOption.fromDb(m[StoreCols.themeColor] as String?),
      themeMode: ThemeModeOption.fromDb(m[StoreCols.themeMode] as String?),
      currencySymbol: m[StoreCols.currencySymbol] as String,
      currencyCode: m[StoreCols.currencyCode] as String,
      numberLocale: m[StoreCols.numberLocale] as String,
      decimalPlaces: m[StoreCols.decimalPlaces] as int,
      whatsappCountryCode: m[StoreCols.whatsappCountryCode] as String,
      lastBackupAt: (m[StoreCols.lastBackupAt] as String?).let(parseUtc),
      createdAt: parseUtc(m[StoreCols.createdAt] as String),
      updatedAt: parseUtc(m[StoreCols.updatedAt] as String),
    );

extension StoreMapper on Store {
  /// Solo columnas editables; `id`, `created_at` y `last_backup_at` se
  /// manejan aparte.
  Map<String, Object?> toUpdateMap() => {
        StoreCols.name: name,
        StoreCols.logoPath: logoPath,
        StoreCols.address: address,
        StoreCols.phone: phone,
        StoreCols.themeColor: themeColor.dbValue,
        StoreCols.themeMode: themeMode.dbValue,
        StoreCols.currencySymbol: currencySymbol,
        StoreCols.currencyCode: currencyCode,
        StoreCols.numberLocale: numberLocale,
        StoreCols.decimalPlaces: decimalPlaces,
        StoreCols.whatsappCountryCode: whatsappCountryCode,
        StoreCols.updatedAt: nowUtcIso(),
      };
}

extension NullableLet<T> on T? {
  R? let<R>(R Function(T) f) {
    final v = this;
    return v == null ? null : f(v);
  }
}
