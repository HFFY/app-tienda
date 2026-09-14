import 'package:flutter/material.dart';

import '../../domain/entities/customer.dart';

class GenderSelector extends StatelessWidget {
  const GenderSelector({super.key, required this.value, required this.onChanged});

  final Gender value;
  final ValueChanged<Gender> onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Gender>(
      segments: const [
        ButtonSegment(value: Gender.female, label: Text('Femenino'), icon: Icon(Icons.female)),
        ButtonSegment(value: Gender.male, label: Text('Masculino'), icon: Icon(Icons.male)),
        ButtonSegment(value: Gender.unspecified, label: Text('Sin determinar')),
      ],
      selected: {value},
      onSelectionChanged: (s) => onChanged(s.first),
      showSelectedIcon: false,
    );
  }
}
