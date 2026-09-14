import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/app_snackbar.dart';
import '../../../../core/widgets/loading_button.dart';
import '../../../products/domain/entities/product.dart';
import '../../../products/presentation/controllers/product_mutations.dart';
import '../../domain/entities/inventory_movement.dart';

/// Hoja inferior para registrar entrada / salida / ajuste de un producto.
Future<bool?> showMovementSheet(
  BuildContext context, {
  required Product product,
  MovementType initialType = MovementType.in_,
}) {
  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: _MovementSheet(product: product, initialType: initialType),
    ),
  );
}

class _MovementSheet extends ConsumerStatefulWidget {
  const _MovementSheet({required this.product, required this.initialType});

  final Product product;
  final MovementType initialType;

  @override
  ConsumerState<_MovementSheet> createState() => _MovementSheetState();
}

class _MovementSheetState extends ConsumerState<_MovementSheet> {
  final _formKey = GlobalKey<FormState>();
  final _quantity = TextEditingController();
  final _note = TextEditingController();
  late MovementType _type = widget.initialType;
  late MovementReason _reason = _defaultReason(_type);
  String? _error;

  static MovementReason _defaultReason(MovementType t) => switch (t) {
        MovementType.in_ => MovementReason.purchase,
        MovementType.out => MovementReason.loss,
        MovementType.adjustment => MovementReason.manual,
      };

  List<MovementReason> get _reasons => switch (_type) {
        MovementType.in_ => const [MovementReason.purchase, MovementReason.manual],
        MovementType.out => const [MovementReason.loss, MovementReason.manual],
        MovementType.adjustment => const [MovementReason.manual],
      };

  @override
  void dispose() {
    _quantity.dispose();
    _note.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final qty = int.parse(_quantity.text.trim());
    final failure = await ref.read(productMutationsProvider.notifier).registerMovement(
          productId: widget.product.id,
          type: _type,
          quantity: qty,
          reason: _reason,
          note: _note.text,
        );
    if (!mounted) return;
    if (failure != null) {
      // El SnackBar quedaría detrás de la hoja: el error va en línea.
      setState(() => _error = failure.message);
      return;
    }
    Navigator.of(context).pop(true);
    AppSnackBar.show(context, 'Movimiento registrado.');
  }

  @override
  Widget build(BuildContext context) {
    final saving = ref.watch(productMutationsProvider).isLoading;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final isAdjustment = _type == MovementType.adjustment;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Movimiento de inventario', style: text.titleLarge),
              const SizedBox(height: 4),
              Text(
                '${widget.product.name} · stock actual: ${widget.product.stock}',
                style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
              ),
              const SizedBox(height: 16),
              SegmentedButton<MovementType>(
                segments: const [
                  ButtonSegment(value: MovementType.in_, label: Text('Entrada'), icon: Icon(Icons.add)),
                  ButtonSegment(value: MovementType.out, label: Text('Salida'), icon: Icon(Icons.remove)),
                  ButtonSegment(value: MovementType.adjustment, label: Text('Ajuste'), icon: Icon(Icons.tune)),
                ],
                selected: {_type},
                showSelectedIcon: false,
                onSelectionChanged: (s) => setState(() {
                  _type = s.first;
                  _reason = _defaultReason(_type);
                  _error = null;
                }),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _quantity,
                autofocus: true,
                keyboardType: TextInputType.numberWithOptions(signed: isAdjustment),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(isAdjustment ? r'[-\d]' : r'\d'))],
                validator: (v) => isAdjustment ? Validators.nonZeroInt(v) : Validators.positiveInt(v),
                decoration: InputDecoration(
                  labelText: isAdjustment ? 'Diferencia (+/−)' : 'Cantidad',
                  helperText: isAdjustment
                      ? 'Ej.: −3 si el conteo físico tiene 3 unidades menos.'
                      : null,
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<MovementReason>(
                initialValue: _reason,
                decoration: const InputDecoration(labelText: 'Motivo'),
                items: [for (final r in _reasons) DropdownMenuItem(value: r, child: Text(r.label))],
                onChanged: (r) => setState(() => _reason = r ?? _reason),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _note,
                maxLines: 2,
                textCapitalization: TextCapitalization.sentences,
                validator: (v) => isAdjustment ? Validators.required(v, 'La nota') : null,
                decoration: InputDecoration(
                  labelText: isAdjustment ? 'Nota (obligatoria)' : 'Nota',
                  alignLabelWithHint: true,
                ),
              ),
              if (_error != null) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.error_outline, size: 18, color: scheme.error),
                    const SizedBox(width: 8),
                    Expanded(child: Text(_error!, style: TextStyle(color: scheme.error))),
                  ],
                ),
              ],
              const SizedBox(height: 20),
              LoadingButton(
                label: 'Registrar movimiento',
                icon: Icons.check,
                loading: saving,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
