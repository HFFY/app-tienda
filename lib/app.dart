import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/store/presentation/providers/store_providers.dart';

class AppTienda extends ConsumerWidget {
  const AppTienda({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeColor = ref.watch(themeColorProvider);
    final themeMode = ref.watch(themeModeOptionProvider);
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'App Tienda',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(themeColor, Brightness.light),
      darkTheme: buildTheme(themeColor, Brightness.dark),
      themeMode: themeMode.themeMode,
      // MaterialApp ya interpola entre temas; no hace falta AnimatedTheme.
      themeAnimationDuration: const Duration(milliseconds: 400),
      themeAnimationCurve: Curves.easeInOut,
      routerConfig: router,
    );
  }
}
