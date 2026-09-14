import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/theme/theme_options.dart';

part 'store.freezed.dart';

/// Configuración de la tienda (registro único, `id = 1`).
@freezed
abstract class Store with _$Store {
  const Store._();

  const factory Store({
    required int id,
    required String name,
    String? logoPath,
    String? address,
    String? phone,
    required ThemeColorOption themeColor,
    required ThemeModeOption themeMode,
    required String currencySymbol,
    required String currencyCode,
    required String numberLocale,
    required int decimalPlaces,
    required String whatsappCountryCode,
    DateTime? lastBackupAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Store;

  bool get hasLogo => logoPath != null && logoPath!.isNotEmpty;

  /// Iniciales para el avatar cuando no hay logo.
  String get initials {
    final words = name.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();
    if (words.isEmpty) return 'T';
    if (words.length == 1) return words.first[0].toUpperCase();
    return (words[0][0] + words[1][0]).toUpperCase();
  }

  /// Días desde el último respaldo, o `null` si nunca se hizo.
  int? get daysSinceBackup =>
      lastBackupAt == null ? null : DateTime.now().toUtc().difference(lastBackupAt!).inDays;
}
