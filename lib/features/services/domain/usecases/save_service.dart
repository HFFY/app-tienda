import 'package:image_picker/image_picker.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../../../core/utils/image_storage.dart';
import '../../../../core/utils/money_math.dart';
import '../entities/service.dart';
import '../repositories/service_repository.dart';

/// Misma estrategia de imagen que `SaveProduct`.
class SaveService {
  const SaveService(this._repo, this._images);

  final ServiceRepository _repo;
  final ImageStorage _images;

  Future<Result<Service>> call(Service service, {XFile? newImage, bool removeImage = false}) async {
    final name = service.name.trim();
    if (name.isEmpty) {
      return const Err(ValidationFailure('El nombre es obligatorio.', field: 'name'));
    }
    if (service.price < 0) {
      return const Err(ValidationFailure('El precio no puede ser negativo.', field: 'price'));
    }
    if (service.durationMinutes <= 0) {
      return const Err(ValidationFailure('La duración debe ser mayor que 0.', field: 'duration'));
    }

    String? newPath;
    if (newImage != null) {
      try {
        newPath = await _images.persist(newImage, folder: 'services');
      } catch (_) {
        return const Err(StorageFailure('No se pudo guardar la imagen.'));
      }
    }

    final previousPath = service.imagePath;
    final description = service.description?.trim();
    final clean = service.copyWith(
      name: name,
      description: (description == null || description.isEmpty) ? null : description,
      price: roundMoney(service.price),
      imagePath: newPath ?? (removeImage ? null : previousPath),
    );

    final result = clean.isNew ? await _repo.insert(clean) : await _repo.update(clean);

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
