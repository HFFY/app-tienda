import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/validators.dart';
import '../../../store/presentation/providers/store_providers.dart';
import '../../domain/entities/sale.dart';
import '../providers/sale_providers.dart';

class DiscountSection extends ConsumerStatefulWidget {
  const DiscountSection({super.key});

  @override
  ConsumerState<DiscountSection> createState() => _DiscountSectionState();
}

class _DiscountSectionState extends ConsumerState<DiscountSection> {
  late final TextEditingController _value;

  @override
  void initState() {
    super.initState();
    final cart = ref.read(cartControllerProvider);
    _value = TextEditingController(text: cart.discountValue == 0 ? '' : '${cart.discountValue}');
  }

  @override
  void dispose() {
    _value.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final type = ref.watch(cartControllerProvider.select((c) => c.discountType));
    final symbol = ref.watch(storeControllerProvider.select((s) => s.currencySymbol));
    final ctl = ref.read(cartControllerProvider.notifier);

    // Si el carrito se vació (venta registrada), limpiar el campo.
    ref.listen(cartControllerProvider.select((c) => c.discountValue), (prev, next) {
      if (next == 0 && _value.text.isNotEmpty) _value.clear();
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SegmentedButton<DiscountType>(
          segments: const [
            ButtonSegment(value: DiscountType.none, label: Text('Sin desc.')),
            ButtonSegment(value: DiscountType.percent, label: Text('%')),
            ButtonSegment(value: DiscountType.amount, label: Text('Monto')),
          ],
          selected: {type},
          showSelectedIcon: false,
          onSelectionChanged: (s) {
            final t = s.first;
            ctl.setDiscount(t, Validators.parseNumber(_value.text) ?? 0);
          },
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.topCenter,
          child: type == DiscountType.none
              ? const SizedBox(width: double.infinity)
              : Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: TextFormField(
                    controller: _value,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d.,]'))],
                    decoration: InputDecoration(
                      labelText: type == DiscountType.percent ? 'Porcentaje de descuento' : 'Monto de descuento',
                      prefixText: type == DiscountType.amount ? '$symbol ' : null,
                      suffixText: type == DiscountType.percent ? '%' : null,
                      helperText: type == DiscountType.percent ? 'Entre 0 y 100' : 'No puede superar el subtotal',
                    ),
                    onChanged: (v) => ctl.setDiscount(type, Validators.parseNumber(v) ?? 0),
                  ),
                ),
        ),
      ],
    );
  }
}
