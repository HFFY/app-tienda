import 'dart:async';

import 'package:flutter/material.dart';

/// Campo de búsqueda con debounce y botón para limpiar.
class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
    required this.onChanged,
    this.hintText = 'Buscar',
    this.debounce = const Duration(milliseconds: 250),
    this.initialValue = '',
  });

  final ValueChanged<String> onChanged;
  final String hintText;
  final Duration debounce;
  final String initialValue;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late final TextEditingController _controller = TextEditingController(text: widget.initialValue);
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _timer?.cancel();
    _timer = Timer(widget.debounce, () => widget.onChanged(value));
    setState(() {});
  }

  void _clear() {
    _timer?.cancel();
    _controller.clear();
    widget.onChanged('');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: _onChanged,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: const Icon(Icons.search),
        isDense: true,
        suffixIcon: _controller.text.isEmpty
            ? null
            : IconButton(
                tooltip: 'Limpiar',
                icon: const Icon(Icons.close),
                onPressed: _clear,
              ),
      ),
    );
  }
}
