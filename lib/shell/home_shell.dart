import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/router/routes.dart';
import '../core/widgets/store_logo.dart';
import '../features/store/presentation/providers/store_providers.dart';

/// Scaffold principal con `NavigationBar` de cinco destinos. El
/// `StatefulShellRoute.indexedStack` conserva el estado de cada pestaña.
class HomeShell extends ConsumerWidget {
  const HomeShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storeName = ref.watch(storeControllerProvider.select((s) => s.name));

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 56,
        leading: const Padding(
          padding: EdgeInsets.only(left: 16),
          child: Center(child: StoreLogo(size: 36)),
        ),
        titleSpacing: 4,
        title: Text(storeName, overflow: TextOverflow.ellipsis),
        actions: [
          IconButton(
            tooltip: 'Configuración',
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push(Routes.store),
          ),
        ],
      ),
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => navigationShell.goBranch(
          index,
          // Volver a tocar la pestaña activa la lleva a su raíz.
          initialLocation: index == navigationShell.currentIndex,
        ),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: 'Reportes',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Clientes',
          ),
          NavigationDestination(
            icon: Icon(Icons.inventory_2_outlined),
            selectedIcon: Icon(Icons.inventory_2),
            label: 'Inventario',
          ),
          NavigationDestination(
            icon: Icon(Icons.design_services_outlined),
            selectedIcon: Icon(Icons.design_services),
            label: 'Servicios',
          ),
          NavigationDestination(
            icon: Icon(Icons.point_of_sale_outlined),
            selectedIcon: Icon(Icons.point_of_sale),
            label: 'Vender',
          ),
        ],
      ),
    );
  }
}
