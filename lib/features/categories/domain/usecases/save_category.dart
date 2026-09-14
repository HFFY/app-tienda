import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../entities/category.dart';
import '../repositories/category_repository.dart';

class SaveCategory {
  const SaveCategory(this._repo);

  final CategoryRepository _repo;

  Future<Result<Category>> call(Category category) {
    final name = category.name.trim();
    if (name.isEmpty) {
      return Future.value(const Err(ValidationFailure('El nombre es obligatorio.', field: 'name')));
    }
    if (name.length > 40) {
      return Future.value(const Err(ValidationFailure('Máximo 40 caracteres.', field: 'name')));
    }
    final clean = category.copyWith(name: name);
    return clean.isNew ? _repo.insert(clean) : _repo.update(clean);
  }
}
