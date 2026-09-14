import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/category_icons.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/app_snackbar.dart';
import '../../../../core/widgets/loading_button.dart';
import '../../domain/entities/category.dart';
import '../controllers/category_form_controller.dart';
import '../providers/category_providers.dart';
import '../widgets/color_picker_row.dart';
import '../widgets/icon_picker_grid.dart';

/// Crear (`categoryId == null`) o editar una categoría. Al guardar hace
/// `context.pop(id)` para que el llamador pueda seleccionarla.
class CategoryFormScreen extends ConsumerStatefulWidget {
  const CategoryFormScreen({super.key, this.categoryId, this.initialScope});

  final int? categoryId;

  /// Alcance sugerido cuando se crea desde el formulario de producto/servicio.
  final CategoryScope? initialScope;

  @override
  ConsumerState<CategoryFormScreen> createState() => _CategoryFormScreenState();
}

class _CategoryFormScreenState extends ConsumerState<CategoryFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  late CategoryScope _scope = widget.initialScope ?? CategoryScope.both;
  String? _colorHex = kCategoryColors[5];
  int? _iconCode = kCategoryIcons.first.codePoint;

  Category? _original;
  bool _loaded = false;

  bool get _isEdit => widget.categoryId != null;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  void _hydrate(Category c) {
    if (_loaded) return;
    _loaded = true;
    _original = c;
    _name.text = c.name;
    _scope = c.scope;
    _colorHex = c.colorHex ?? _colorHex;
    _iconCode = c.iconCode ?? _iconCode;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();

    final draft = (_original ?? Category.draft(name: _name.text)).copyWith(
      name: _name.text,
      scope: _scope,
      colorHex: _colorHex,
      iconCode: _iconCode,
    );
    final result = await ref.read(categoryMutationsProvider.notifier).save(draft);
    if (!mounted) return;
    if (result.failure != null) {
      AppSnackBar.failure(context, result.failure!);
      return;
    }
    context.pop(result.id);
  }

  @override
  Widget build(BuildContext context) {
    final saving = ref.watch(categoryMutationsProvider).isLoading;
    final tint = colorFromHex(_colorHex);
    final text = Theme.of(context).textTheme;

    if (_isEdit && !_loaded) {
      final async = ref.watch(categoryByIdProvider(widget.categoryId!));
      return async.when(
        loading: () => Scaffold(
          appBar: AppBar(title: const Text('Editar categoría')),
          body: const Center(child: CircularProgressIndicator()),
        ),
        error: (e, _) => Scaffold(
          appBar: AppBar(title: const Text('Editar categoría')),
          body: Center(child: Text('No se pudo cargar: $e')),
        ),
        data: (c) {
          if (c == null) {
            return Scaffold(
              appBar: AppBar(title: const Text('Editar categoría')),
              body: const Center(child: Text('La categoría no existe.')),
            );
          }
          _hydrate(c);
          return _buildForm(context, saving, tint, text);
        },
      );
    }
    return _buildForm(context, saving, tint, text);
  }

  Widget _buildForm(BuildContext context, bool saving, Color? tint, TextTheme text) {
    return Scaffold(
      appBar: AppBar(title: Text(_isEdit ? 'Editar categoría' : 'Nueva categoría')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: (tint ?? Theme.of(context).colorScheme.primary).withValues(alpha: 0.18),
                  foregroundColor: tint,
                  child: Icon(categoryIconFor(_iconCode), size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _name,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.done,
                    maxLength: 40,
                    validator: (v) => Validators.required(v, 'El nombre'),
                    decoration: const InputDecoration(labelText: 'Nombre', counterText: ''),
                    onFieldSubmitted: (_) => _save(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text('Alcance', style: text.titleSmall),
            const SizedBox(height: 8),
            SegmentedButton<CategoryScope>(
              segments: const [
                ButtonSegment(value: CategoryScope.product, label: Text('Productos')),
                ButtonSegment(value: CategoryScope.service, label: Text('Servicios')),
                ButtonSegment(value: CategoryScope.both, label: Text('Ambos')),
              ],
              selected: {_scope},
              onSelectionChanged: (s) => setState(() => _scope = s.first),
            ),
            const SizedBox(height: 24),
            Text('Color', style: text.titleSmall),
            const SizedBox(height: 8),
            ColorPickerRow(
              selected: _colorHex,
              onSelected: (hex) => setState(() => _colorHex = hex),
            ),
            const SizedBox(height: 24),
            Text('Ícono', style: text.titleSmall),
            const SizedBox(height: 8),
            IconPickerGrid(
              selectedCodePoint: _iconCode,
              tint: tint,
              onSelected: (code) => setState(() => _iconCode = code),
            ),
            const SizedBox(height: 32),
            LoadingButton(
              label: _isEdit ? 'Guardar cambios' : 'Crear categoría',
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
