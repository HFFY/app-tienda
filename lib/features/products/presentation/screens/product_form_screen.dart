import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/app_snackbar.dart';
import '../../../../core/widgets/image_picker_field.dart';
import '../../../../core/widgets/loading_button.dart';
import '../../../categories/domain/entities/category.dart';
import '../../../store/presentation/providers/store_providers.dart';
import '../../domain/entities/product.dart';
import '../controllers/product_mutations.dart';
import '../providers/product_providers.dart';
import '../widgets/category_dropdown.dart';

class ProductFormScreen extends ConsumerStatefulWidget {
  const ProductFormScreen({super.key, this.productId});

  final int? productId;

  @override
  ConsumerState<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends ConsumerState<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _description = TextEditingController();
  final _price = TextEditingController();
  final _initialStock = TextEditingController(text: '0');
  final _minStock = TextEditingController(text: '0');
  int? _categoryId;
  XFile? _newImage;
  bool _removeImage = false;

  Product? _original;
  bool _loaded = false;

  bool get _isEdit => widget.productId != null;

  @override
  void dispose() {
    for (final c in [_name, _description, _price, _initialStock, _minStock]) {
      c.dispose();
    }
    super.dispose();
  }

  void _hydrate(Product p) {
    if (_loaded) return;
    _loaded = true;
    _original = p;
    _name.text = p.name;
    _description.text = p.description ?? '';
    _price.text = ref.read(moneyFormatterProvider).formatPlain(p.price);
    _minStock.text = '${p.minStock}';
    _categoryId = p.categoryId;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();

    final draft = (_original ?? Product.draft()).copyWith(
      name: _name.text,
      description: _description.text,
      price: Validators.parseNumber(_price.text) ?? 0,
      minStock: int.tryParse(_minStock.text.trim()) ?? 0,
      categoryId: _categoryId,
    );
    final result = await ref.read(productMutationsProvider.notifier).save(
          draft,
          newImage: _newImage,
          removeImage: _removeImage,
          initialStock: int.tryParse(_initialStock.text.trim()) ?? 0,
        );
    if (!mounted) return;
    if (result.failure != null) {
      AppSnackBar.failure(context, result.failure!);
      return;
    }
    context.pop(result.id);
  }

  @override
  Widget build(BuildContext context) {
    if (_isEdit && !_loaded) {
      final async = ref.watch(productByIdProvider(widget.productId!));
      return async.when(
        loading: () => Scaffold(
          appBar: AppBar(title: const Text('Editar producto')),
          body: const Center(child: CircularProgressIndicator()),
        ),
        error: (e, _) => Scaffold(
          appBar: AppBar(title: const Text('Editar producto')),
          body: Center(child: Text('No se pudo cargar: $e')),
        ),
        data: (p) {
          if (p == null) {
            return Scaffold(
              appBar: AppBar(title: const Text('Editar producto')),
              body: const Center(child: Text('El producto no existe.')),
            );
          }
          _hydrate(p);
          return _buildForm(context);
        },
      );
    }
    return _buildForm(context);
  }

  Widget _buildForm(BuildContext context) {
    final saving = ref.watch(productMutationsProvider).isLoading;
    final symbol = ref.watch(storeControllerProvider.select((s) => s.currencySymbol));
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(_isEdit ? 'Editar producto' : 'Nuevo producto')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          children: [
            ImagePickerField(
              existingPath: _original?.imagePath,
              placeholderIcon: Icons.inventory_2_outlined,
              onChanged: ({newImage, required removed}) {
                _newImage = newImage;
                _removeImage = removed;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _name,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.next,
              validator: (v) => Validators.required(v, 'El nombre'),
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _description,
              maxLines: 2,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Descripción', alignLabelWithHint: true),
            ),
            const SizedBox(height: 16),
            CategoryDropdown(
              scope: CategoryScope.product,
              value: _categoryId,
              onChanged: (id) => setState(() => _categoryId = id),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _price,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d.,]'))],
              textInputAction: TextInputAction.next,
              validator: (v) => Validators.nonNegativeNumber(v, 'El precio'),
              decoration: InputDecoration(labelText: 'Precio de venta', prefixText: '$symbol '),
            ),
            const SizedBox(height: 20),
            Text('Inventario', style: text.titleSmall),
            const SizedBox(height: 8),
            Row(
              children: [
                if (!_isEdit) ...[
                  Expanded(
                    child: TextFormField(
                      controller: _initialStock,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      textInputAction: TextInputAction.next,
                      validator: (v) => Validators.nonNegativeInt(v, 'El stock inicial'),
                      decoration: const InputDecoration(labelText: 'Stock inicial'),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: TextFormField(
                    controller: _minStock,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textInputAction: TextInputAction.done,
                    validator: (v) => Validators.nonNegativeInt(v, 'El stock mínimo'),
                    decoration: const InputDecoration(
                      labelText: 'Stock mínimo',
                      helperText: 'Alerta de stock bajo',
                    ),
                    onFieldSubmitted: (_) => _save(),
                  ),
                ),
              ],
            ),
            if (_isEdit)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'El stock actual (${_original!.stock}) solo cambia registrando movimientos de inventario.',
                  style: text.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                ),
              ),
            const SizedBox(height: 32),
            LoadingButton(
              label: _isEdit ? 'Guardar cambios' : 'Crear producto',
              icon: Icons.check,
              loading: saving,
              onPressed: _save,
            ),
          ],
        ),
      ),
    );
  }
}
