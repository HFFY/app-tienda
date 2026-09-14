import 'package:flutter/material.dart';

/// Campo de contraseña con botón para mostrar/ocultar.
class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    this.controller,
    this.label = 'Contraseña',
    this.validator,
    this.textInputAction = TextInputAction.done,
    this.onFieldSubmitted,
    this.autofillHints,
  });

  final TextEditingController? controller;
  final String label;
  final FormFieldValidator<String>? validator;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final Iterable<String>? autofillHints;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscure = true;

  // El botón del ojo no debe recibir el foco al pulsar "siguiente".
  final _toggleFocus = FocusNode(skipTraversal: true, canRequestFocus: false);

  @override
  void dispose() {
    _toggleFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscure,
      validator: widget.validator,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
      autofillHints: widget.autofillHints,
      decoration: InputDecoration(
        labelText: widget.label,
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          focusNode: _toggleFocus,
          tooltip: _obscure ? 'Mostrar contraseña' : 'Ocultar contraseña',
          icon: Icon(_obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined),
          onPressed: () => setState(() => _obscure = !_obscure),
        ),
      ),
    );
  }
}
