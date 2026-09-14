import '../../../../core/database/local_data_source.dart';
import '../../../../core/database/tables.dart';
import '../../../../core/utils/clock.dart';
import '../../domain/entities/product.dart';

/// Columnas extra del `LEFT JOIN category` en las consultas de lista.
const kProductCategoryNameCol = 'category_name';
const kProductCategoryColorCol = 'category_color';
const kProductCategoryIconCol = 'category_icon';

Product productFromMap(Map<String, Object?> m) => Product(
      id: m[ProductCols.id] as int,
      categoryId: m[ProductCols.categoryId] as int?,
      name: m[ProductCols.name] as String,
      description: m[ProductCols.description] as String?,
      price: ((m[ProductCols.price] as num?) ?? 0).toDouble(),
      imagePath: m[ProductCols.imagePath] as String?,
      stock: (m[ProductCols.stock] as int?) ?? 0,
      minStock: (m[ProductCols.minStock] as int?) ?? 0,
      isActive: dbBool(m[ProductCols.isActive]),
      createdAt: parseUtc(m[ProductCols.createdAt] as String),
      updatedAt: parseUtc(m[ProductCols.updatedAt] as String),
      categoryName: m[kProductCategoryNameCol] as String?,
      categoryColorHex: m[kProductCategoryColorCol] as String?,
      categoryIconCode: m[kProductCategoryIconCol] as int?,
    );

extension ProductMapper on Product {
  Map<String, Object?> toInsertMap({required int initialStock}) {
    final now = nowUtcIso();
    return {
      ProductCols.categoryId: categoryId,
      ProductCols.name: name,
      ProductCols.description: description,
      ProductCols.price: price,
      ProductCols.imagePath: imagePath,
      ProductCols.stock: initialStock,
      ProductCols.minStock: minStock,
      ProductCols.isActive: dbInt(isActive),
      ProductCols.createdAt: now,
      ProductCols.updatedAt: now,
    };
  }

  /// Sin `stock`: solo cambia a través de movimientos.
  Map<String, Object?> toUpdateMap() => {
        ProductCols.categoryId: categoryId,
        ProductCols.name: name,
        ProductCols.description: description,
        ProductCols.price: price,
        ProductCols.imagePath: imagePath,
        ProductCols.minStock: minStock,
        ProductCols.updatedAt: nowUtcIso(),
      };
}
