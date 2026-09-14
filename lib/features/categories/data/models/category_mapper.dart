import '../../../../core/database/local_data_source.dart';
import '../../../../core/database/tables.dart';
import '../../../../core/utils/clock.dart';
import '../../domain/entities/category.dart';

Category categoryFromMap(Map<String, Object?> m) => Category(
      id: m[CategoryCols.id] as int,
      name: m[CategoryCols.name] as String,
      scope: CategoryScope.fromDb(m[CategoryCols.scope] as String?),
      colorHex: m[CategoryCols.colorHex] as String?,
      iconCode: m[CategoryCols.iconCode] as int?,
      sortOrder: (m[CategoryCols.sortOrder] as int?) ?? 0,
      isActive: dbBool(m[CategoryCols.isActive]),
      createdAt: parseUtc(m[CategoryCols.createdAt] as String),
      updatedAt: parseUtc(m[CategoryCols.updatedAt] as String),
    );

extension CategoryMapper on Category {
  Map<String, Object?> toInsertMap({required int sortOrder}) {
    final now = nowUtcIso();
    return {
      CategoryCols.name: name,
      CategoryCols.scope: scope.dbValue,
      CategoryCols.colorHex: colorHex,
      CategoryCols.iconCode: iconCode,
      CategoryCols.sortOrder: sortOrder,
      CategoryCols.isActive: dbInt(isActive),
      CategoryCols.createdAt: now,
      CategoryCols.updatedAt: now,
    };
  }

  Map<String, Object?> toUpdateMap() => {
        CategoryCols.name: name,
        CategoryCols.scope: scope.dbValue,
        CategoryCols.colorHex: colorHex,
        CategoryCols.iconCode: iconCode,
        CategoryCols.updatedAt: nowUtcIso(),
      };
}
