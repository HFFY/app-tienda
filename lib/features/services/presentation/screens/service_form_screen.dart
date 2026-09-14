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
import '../../../products/presentation/widgets/category_dropdown.dart';
import '../../../store/presentation/providers/store_providers.dart';
import '../../domain/entities/service.dart';
import '../controllers/service_mutations.dart';
import '../providers/service_providers.dart';
import '../widgets/duration_picker.dart';

class ServiceFormScreen extends ConsumerStatefulWidget {
  const ServiceFormScreen({super.key, this.serviceId});

  final int? serviceId;

  @override
  ConsumerState<ServiceFormScreen> createState() => _ServiceFormScreenState();
}

class _ServiceFormScreenState extends ConsumerState<ServiceFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _description = TextEditingController();
  final _price = TextEditingController();
  final _duration = TextEditingController(text: '30');
  int? _categoryId;
  XFile? _newImage;
  bool _removeImage = false;

  Service? _original;
  bool _loaded = false;

  bool get _isEdit => widget.serviceId != null;

  @override
  void dispose() {
    for (final c in [_name, _description, _price, _duration]) {
      c.dispose();
    }
    super.dispose();
  }

  void _hydrate(Service s) {
    if (_loaded) return;
    _loaded = true;
    _original = s;
    _name.text = s.name;
    _description.text = s.description ?? '';
    _price.text = ref.read(moneyFormatterProvider).formatPlain(s.price);
    _duration.text = '${s.durationMinutes}';
    _categoryId = s.categoryId;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();

    final draft = (_original ?? Service.draft()).copyWith(
      name: _name.text,
      description: _description.text,
      price: Validators.parseNumber(_price.text) ?? 0,
      durationMinutes: int.tryParse(_duration.text.trim()) ?? 0,
      categoryId: _categoryId,
    );
    final result = await ref
        .read(serviceMutationsProvider.notifier)
        .save(draft, newImage: _newImage, removeImage: _removeImage);
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
      final async = ref.watch(serviceByIdProvider(widget.serviceId!));
      return async.when(
        loading: () => Scaffold(
          appBar: AppBar(title: const Text('Editar servicio')),
          body: const Center(child: CircularProgressIndicator()),
        ),
        error: (e, _) => Scaffold(
          appBar: AppBar(title: const Text('Editar servicio')),
          body: Center(child: Text('No se pudo cargar: $e')),
        ),
        data: (s) {
          if (s == null) {
            return Scaffold(
              appBar: AppBar(title: const Text('Editar servicio')),
              body: const Center(child: Text('El servicio no existe.')),
            );
          }
          _hydrate(s);
          return _buildForm(context);
        },
      );
    }
    return _buildForm(context);
  }

  Widget _buildForm(BuildContext context) {
    final saving = ref.watch(serviceMutationsProvider).isLoading;
    final symbol = ref.watch(storeControllerProvider.select((s) => s.currencySymbol));
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(_isEdit ? 'Editar servicio' : 'Nuevo servicio')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          children: [
            ImagePickerField(
              existingPath: _original?.imagePath,
              placeholderIcon: Icons.design_services_outlined,
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
              scope: CategoryScope.service,
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
              decoration: InputDecoration(labelText: 'Precio', prefixText: '$symbol '),
            ),
            const SizedBox(height: 20),
            Text('Duración', style: text.titleSmall),
            const SizedBox(height: 8),
            DurationPicker(controller: _duration, onChanged: () => setState(() {})),
            const SizedBox(height: 32),
            LoadingButton(
              label: _isEdit ? 'Guardar cambios' : 'Crear servicio',
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
