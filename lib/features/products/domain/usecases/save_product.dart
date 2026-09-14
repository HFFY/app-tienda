import 'package:image_picker/image_picker.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../../../core/utils/image_storage.dart';
import '../../../../core/utils/money_math.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

/// Guarda un producto gestionando también su imagen:
/// 1. Copia la imagen nueva (si la hay) al almacenamiento de la app.
/// 2. Escribe en la base.
/// 3. Si la base falla, borra la copia nueva; si tuvo éxito y la imagen
///    cambió, borra la anterior.
class SaveProduct {
  const SaveProduct(this._repo, this._images);

  final ProductRepository _repo;
  final ImageStorage _images;

  Future<Result<Product>> call(
    Product product, {
    XFile? newImage,
    bool removeImage = false,
    int initialStock = 0,
  }) async {
    final name = product.name.trim();
    if (name.isEmpty) {
      return const Err(ValidationFailure('El nombre es obligatorio.', field: 'name'));
    }
    if (product.price < 0) {
      return const Err(ValidationFailure('El precio no puede ser negativo.', field: 'price'));
    }
    if (product.minStock < 0) {
      return const Err(ValidationFailure('El stock mínimo no puede ser negativo.', field: 'minStock'));
    }
    if (product.isNew && initialStock < 0) {
      return const Err(ValidationFailure('El stock inicial no puede ser negativo.', field: 'stock'));
    }

    String? newPath;
    if (newImage != null) {
      try {
        newPath = await _images.persist(newImage, folder: 'products');
      } catch (_) {
        return const Err(StorageFailure('No se pudo guardar la imagen.'));
      }
    }

    final previousPath = product.imagePath;
    final description = product.description?.trim();
    final clean = product.copyWith(
      name: name,
      description: (description == null || description.isEmpty) ? null : description,
      price: roundMoney(product.price),
      imagePath: newPath ?? (removeImage ? null : previousPath),
    );

    final result = clean.isNew
        ? await _repo.create(clean, initialStock: initialStock)
        : await _repo.update(clean);

    switch (result) {
      case Err():
        await _images.delete(newPath);
      case Ok():
        if ((newPath != null || removeImage) && previousPath != null && previousPath != newPath) {
          await _images.delete(previousPath);
        }
    }
    return result;
  }
}
