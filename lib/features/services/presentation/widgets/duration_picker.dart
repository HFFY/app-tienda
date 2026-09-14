import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/utils/duration_formatter.dart';
import '../../../../core/utils/validators.dart';

/// Chips con duraciones frecuentes + campo libre en minutos.
class DurationPicker extends StatelessWidget {
  const DurationPicker({super.key, required this.controller, required this.onChanged});

  final TextEditingController controller;
  final VoidCallback onChanged;

  static const _presets = [15, 30, 45, 60, 90, 120];

  @override
  Widget build(BuildContext context) {
    final current = int.tryParse(controller.text);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final m in _presets)
              ChoiceChip(
                label: Text(formatMinutes(m)),
                selected: current == m,
                onSelected: (_) {
                  controller.text = '$m';
                  onChanged();
                },
              ),
          ],
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (v) => Validators.positiveInt(v, 'La duración'),
          onChanged: (_) => onChanged(),
          decoration: InputDecoration(
            labelText: 'Duración en minutos',
            suffixText: current == null ? null : formatMinutes(current),
          ),
        ),
      ],
    );
  }
}
