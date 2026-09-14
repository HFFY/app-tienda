import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../../categories/presentation/providers/category_providers.dart';
import '../../../inventory/domain/entities/inventory_movement.dart';
import '../../domain/entities/product.dart';
import '../providers/product_providers.dart';

/// Mutaciones de productos e inventario. No es `autoDispose` (ver CLAUDE.md).
final productMutationsProvider =
    AsyncNotifierProvider<ProductMutations, void>(ProductMutations.new);

class ProductMutations extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<({int? id, Failure? failure})> save(
    Product product, {
    XFile? newImage,
    bool removeImage = false,
    int initialStock = 0,
  }) async {
    state = const AsyncLoading();
    final result = await ref.read(saveProductProvider)(
      product,
      newImage: newImage,
      removeImage: removeImage,
      initialStock: initialStock,
    );
    return _finish(result.map((p) => p.id));
  }

  Future<Failure?> delete(Product product) async {
    state = const AsyncLoading();
    final result = await ref.read(deleteOrDeactivateProductProvider).delete(product);
    return _finish(result).failure;
  }

  Future<Failure?> setActive(int id, bool active) async {
    state = const AsyncLoading();
    final uc = ref.read(deleteOrDeactivateProductProvider);
    final result = active ? await uc.reactivate(id) : await uc.deactivate(id);
    return _finish(result).failure;
  }

  Future<Failure?> registerMovement({
    required int productId,
    required MovementType type,
    required int quantity,
    required MovementReason reason,
    String? note,
  }) async {
    state = const AsyncLoading();
    final result = await ref.read(registerInventoryMovementProvider)(
      productId: productId,
      type: type,
      quantity: quantity,
      reason: reason,
      note: note,
    );
    return _finish(result).failure;
  }

  ({T? id, Failure? failure}) _finish<T>(Result<T> result) {
    switch (result) {
      case Ok(:final value):
        state = const AsyncData(null);
        invalidateProducts(ref);
        // El conteo de uso de categorías cambia al crear/borrar productos.
        ref.invalidate(categoriesWithUsageProvider);
        return (id: value, failure: null);
      case Err(:final failure):
        state = AsyncError(failure, StackTrace.current);
        return (id: null, failure: failure);
    }
  }
}
