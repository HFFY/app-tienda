import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';

@freezed
abstract class Product with _$Product {
  const Product._();

  const factory Product({
    required int id,
    int? categoryId,
    required String name,
    String? description,
    required double price,
    String? imagePath,
    @Default(0) int stock,
    @Default(0) int minStock,
    @Default(true) bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,

    // Datos de la categoría (LEFT JOIN), solo lectura.
    String? categoryName,
    String? categoryColorHex,
    int? categoryIconCode,
  }) = _Product;

  factory Product.draft() {
    final now = DateTime.now().toUtc();
    return Product(id: 0, name: '', price: 0, createdAt: now, updatedAt: now);
  }

  bool get isNew => id == 0;
  bool get hasImage => imagePath != null && imagePath!.isNotEmpty;
  bool get isOutOfStock => stock <= 0;
  bool get isLowStock => !isOutOfStock && stock <= minStock;
}
