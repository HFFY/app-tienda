import '../../../../core/error/result.dart';
import '../entities/category.dart';

abstract interface class CategoryRepository {
  /// Categorías ordenadas por `sort_order`. Con [forScope] devuelve las que
  /// aplican a ese tipo (`scope IN (x, 'both')`).
  Future<Result<List<Category>>> findAll({CategoryScope? forScope, bool includeInactive = false});

  Future<Result<List<CategoryUsage>>> findAllWithUsage();

  Future<Result<Category?>> findById(int id);

  Future<Result<Category>> insert(Category draft);

  Future<Result<Category>> update(Category category);

  /// Borrado físico. Productos y servicios quedan "Sin categoría"
  /// (`ON DELETE SET NULL`).
  Future<Result<void>> delete(int id);

  Future<Result<void>> setActive(int id, bool active);

  Future<Result<void>> reorder(List<int> orderedIds);

  Future<Result<({int products, int services})>> countReferences(int id);
}
