import '../../../../core/database/local_data_source.dart';
import '../../../../core/database/tables.dart';
import '../../../../core/utils/clock.dart';
import '../../domain/entities/service.dart';

const kServiceCategoryNameCol = 'category_name';
const kServiceCategoryColorCol = 'category_color';
const kServiceCategoryIconCol = 'category_icon';

Service serviceFromMap(Map<String, Object?> m) => Service(
      id: m[ServiceCols.id] as int,
      categoryId: m[ServiceCols.categoryId] as int?,
      name: m[ServiceCols.name] as String,
      description: m[ServiceCols.description] as String?,
      price: ((m[ServiceCols.price] as num?) ?? 0).toDouble(),
      imagePath: m[ServiceCols.imagePath] as String?,
      durationMinutes: (m[ServiceCols.durationMinutes] as int?) ?? 30,
      isActive: dbBool(m[ServiceCols.isActive]),
      createdAt: parseUtc(m[ServiceCols.createdAt] as String),
      updatedAt: parseUtc(m[ServiceCols.updatedAt] as String),
      categoryName: m[kServiceCategoryNameCol] as String?,
      categoryColorHex: m[kServiceCategoryColorCol] as String?,
      categoryIconCode: m[kServiceCategoryIconCol] as int?,
    );

extension ServiceMapper on Service {
  Map<String, Object?> toInsertMap() {
    final now = nowUtcIso();
    return {
      ServiceCols.categoryId: categoryId,
      ServiceCols.name: name,
      ServiceCols.description: description,
      ServiceCols.price: price,
      ServiceCols.imagePath: imagePath,
      ServiceCols.durationMinutes: durationMinutes,
      ServiceCols.isActive: dbInt(isActive),
      ServiceCols.createdAt: now,
      ServiceCols.updatedAt: now,
    };
  }

  Map<String, Object?> toUpdateMap() => {
        ServiceCols.categoryId: categoryId,
        ServiceCols.name: name,
        ServiceCols.description: description,
        ServiceCols.price: price,
        ServiceCols.imagePath: imagePath,
        ServiceCols.durationMinutes: durationMinutes,
        ServiceCols.updatedAt: nowUtcIso(),
      };
}
