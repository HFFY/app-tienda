import 'package:freezed_annotation/freezed_annotation.dart';

part 'service.freezed.dart';

@freezed
abstract class Service with _$Service {
  const Service._();

  const factory Service({
    required int id,
    int? categoryId,
    required String name,
    String? description,
    required double price,
    String? imagePath,
    @Default(30) int durationMinutes,
    @Default(true) bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,

    // Datos de la categoría (LEFT JOIN), solo lectura.
    String? categoryName,
    String? categoryColorHex,
    int? categoryIconCode,
  }) = _Service;

  factory Service.draft() {
    final now = DateTime.now().toUtc();
    return Service(id: 0, name: '', price: 0, createdAt: now, updatedAt: now);
  }

  bool get isNew => id == 0;
  bool get hasImage => imagePath != null && imagePath!.isNotEmpty;
}
