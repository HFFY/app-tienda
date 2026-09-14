import '../../../../core/database/app_database.dart';
import '../../../../core/error/db_guard.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/error/failure_exception.dart';
import '../../../../core/error/result.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/category_local_data_source.dart';
import '../models/category_mapper.dart';

final class CategoryRepositoryImpl implements CategoryRepository {
  const CategoryRepositoryImpl(this._appDb, this._ds);

  final AppDatabase _appDb;
  final CategoryLocalDataSource _ds;

  @override
  Future<Result<List<Category>>> findAll({CategoryScope? forScope, bool includeInactive = false}) =>
      guardDb(() async {
        final rows = await _ds.findAll(scopeDb: forScope?.dbValue, includeInactive: includeInactive);
        return rows.map(categoryFromMap).toList();
      });

  @override
  Future<Result<List<CategoryUsage>>> findAllWithUsage() => guardDb(() async {
        final rows = await _ds.findAllWithUsage();
        return rows
            .map(
              (r) => CategoryUsage(
                category: categoryFromMap(r),
                productCount: (r['product_count'] as int?) ?? 0,
                serviceCount: (r['service_count'] as int?) ?? 0,
              ),
            )
            .toList();
      });

  @override
  Future<Result<Category?>> findById(int id) => guardDb(() async {
        final row = await _ds.findById(id);
        return row == null ? null : categoryFromMap(row);
      });

  @override
  Future<Result<Category>> insert(Category draft) => guardDb(() async {
        final order = await _ds.nextSortOrder();
        final id = await _ds.insert(draft.toInsertMap(sortOrder: order));
        return categoryFromMap(await _ds.getById(id));
      });

  @override
  Future<Result<Category>> update(Category category) => guardDb(() async {
        final changed = await _ds.update(category.id, category.toUpdateMap());
        if (changed == 0) throw const FailureException(NotFoundFailure('La categoría no existe.'));
        return categoryFromMap(await _ds.getById(category.id));
      });

  @override
  Future<Result<void>> delete(int id) => guardDb(() => _ds.delete(id));

  @override
  Future<Result<void>> setActive(int id, bool active) => guardDb(() => _ds.setActive(id, active));

  @override
  Future<Result<void>> reorder(List<int> orderedIds) =>
      guardDb(() => _appDb.db.transaction((txn) => _ds.reorder(orderedIds, txn: txn)));

  @override
  Future<Result<({int products, int services})>> countReferences(int id) =>
      guardDb(() => _ds.countReferences(id));
}
