import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/app_snackbar.dart';
import '../../../../core/widgets/loading_button.dart';
import '../../domain/entities/customer.dart';
import '../controllers/customer_mutations.dart';
import '../providers/customer_providers.dart';
import '../widgets/gender_selector.dart';

/// Crear (`customerId == null`) o editar un cliente. Al guardar hace
/// `context.pop(id)` para que la venta pueda seleccionarlo.
class CustomerFormScreen extends ConsumerStatefulWidget {
  const CustomerFormScreen({super.key, this.customerId});

  final int? customerId;

  @override
  ConsumerState<CustomerFormScreen> createState() => _CustomerFormScreenState();
}

class _CustomerFormScreenState extends ConsumerState<CustomerFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _phone = TextEditingController();
  final _notes = TextEditingController();
  Gender _gender = Gender.unspecified;

  Customer? _original;
  bool _loaded = false;

  bool get _isEdit => widget.customerId != null;

  @override
  void dispose() {
    for (final c in [_firstName, _lastName, _phone, _notes]) {
      c.dispose();
    }
    super.dispose();
  }

  void _hydrate(Customer c) {
    if (_loaded) return;
    _loaded = true;
    _original = c;
    _firstName.text = c.firstName;
    _lastName.text = c.lastName;
    _phone.text = c.phone ?? '';
    _notes.text = c.notes ?? '';
    _gender = c.gender;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    final draft = (_original ?? Customer.draft()).copyWith(
      firstName: _firstName.text,
      lastName: _lastName.text,
      phone: _phone.text,
      notes: _notes.text,
      gender: _gender,
    );
    final result = await ref.read(customerMutationsProvider.notifier).save(draft);
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
      final async = ref.watch(customerByIdProvider(widget.customerId!));
      return async.when(
        loading: () => Scaffold(
          appBar: AppBar(title: const Text('Editar cliente')),
          body: const Center(child: CircularProgressIndicator()),
        ),
        error: (e, _) => Scaffold(
          appBar: AppBar(title: const Text('Editar cliente')),
          body: Center(child: Text('No se pudo cargar: $e')),
        ),
        data: (c) {
          if (c == null) {
            return Scaffold(
              appBar: AppBar(title: const Text('Editar cliente')),
              body: const Center(child: Text('El cliente no existe.')),
            );
          }
          _hydrate(c);
          return _buildForm(context);
        },
      );
    }
    return _buildForm(context);
  }

  Widget _buildForm(BuildContext context) {
    final saving = ref.watch(customerMutationsProvider).isLoading;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(_isEdit ? 'Editar cliente' : 'Nuevo cliente')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _firstName,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    validator: (v) => Validators.required(v, 'El nombre'),
                    decoration: const InputDecoration(labelText: 'Nombre'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _lastName,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    validator: (v) => Validators.required(v, 'El apellido'),
                    decoration: const InputDecoration(labelText: 'Apellido'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _phone,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              validator: Validators.optionalPhone,
              decoration: const InputDecoration(
                labelText: 'Celular / WhatsApp',
                prefixIcon: Icon(Icons.phone_outlined),
                helperText: 'Opcional. Sin código de país si es un número local.',
              ),
            ),
            const SizedBox(height: 20),
            Text('Sexo', style: text.titleSmall),
            const SizedBox(height: 8),
            GenderSelector(value: _gender, onChanged: (g) => setState(() => _gender = g)),
            const SizedBox(height: 20),
            TextFormField(
              controller: _notes,
              maxLines: 3,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Notas',
                alignLabelWithHint: true,
                helperText: 'Preferencias, alergias, recordatorios…',
              ),
            ),
            const SizedBox(height: 32),
            LoadingButton(
              label: _isEdit ? 'Guardar cambios' : 'Crear cliente',
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
