import 'package:flutter/material.dart';

import '../error/failure.dart';

/// Mensajes flotantes uniformes en toda la app.
abstract final class AppSnackBar {
  static void show(BuildContext context, String message, {SnackBarAction? action}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message), action: action));
  }

  static void failure(BuildContext context, Failure failure) {
    final scheme = Theme.of(context).colorScheme;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(failure.message, style: TextStyle(color: scheme.onErrorContainer)),
          backgroundColor: scheme.errorContainer,
        ),
      );
  }
}
