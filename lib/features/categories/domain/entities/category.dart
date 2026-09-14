import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';

/// Alcance de la categoría: solo productos, solo servicios o ambos.
enum CategoryScope {
  product('product', 'Productos'),
  service('service', 'Servicios'),
  both('both', 'Ambos');

  const CategoryScope(this.dbValue, this.label);

  final String dbValue;
  final String label;

  static CategoryScope fromDb(String? v) =>
      values.firstWhere((e) => e.dbValue == v, orElse: () => CategoryScope.both);

  bool get appliesToProducts => this != CategoryScope.service;
  bool get appliesToServices => this != CategoryScope.product;
}

@freezed
abstract class Category with _$Category {
  const Category._();

  const factory Category({
    required int id,
    required String name,
    required CategoryScope scope,
    String? colorHex,
    int? iconCode,
    @Default(0) int sortOrder,
    @Default(true) bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Category;

  /// Borrador para crear: `id = 0`, fechas se asignan en la base.
  factory Category.draft({
    required String name,
    CategoryScope scope = CategoryScope.both,
    String? colorHex,
    int? iconCode,
  }) {
    final now = DateTime.now().toUtc();
    return Category(
      id: 0,
      name: name,
      scope: scope,
      colorHex: colorHex,
      iconCode: iconCode,
      createdAt: now,
      updatedAt: now,
    );
  }

  bool get isNew => id == 0;
}

/// Categoría con el conteo de productos y servicios que la usan.
@freezed
abstract class CategoryUsage with _$CategoryUsage {
  const CategoryUsage._();

  const factory CategoryUsage({
    required Category category,
    required int productCount,
    required int serviceCount,
  }) = _CategoryUsage;

  int get total => productCount + serviceCount;
}
