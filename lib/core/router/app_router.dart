import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/providers/auth_providers.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/user_settings_screen.dart';
import '../../features/categories/domain/entities/category.dart';
import '../../features/categories/presentation/screens/categories_screen.dart';
import '../../features/categories/presentation/screens/category_form_screen.dart';
import '../../features/customers/presentation/screens/customer_form_screen.dart';
import '../../features/customers/presentation/screens/customers_screen.dart';
import '../../features/products/presentation/screens/inventory_screen.dart';
import '../../features/products/presentation/screens/product_detail_screen.dart';
import '../../features/products/presentation/screens/product_form_screen.dart';
import '../../features/products/presentation/screens/product_movements_screen.dart';
import '../../features/reports/presentation/screens/reports_screen.dart';
import '../../features/sales/presentation/screens/new_sale_screen.dart';
import '../../features/services/presentation/screens/service_form_screen.dart';
import '../../features/services/presentation/screens/services_screen.dart';
import '../../features/store/presentation/screens/store_settings_screen.dart';
import '../../shell/home_shell.dart';
import 'page_transitions.dart';
import 'routes.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

/// `Listenable` que el router observa; se notifica cuando cambia la sesión
/// o la existencia de usuario para re-evaluar el `redirect`.
class _RouterRefresh extends ChangeNotifier {
  void refresh() => notifyListeners();
}

final routerProvider = Provider<GoRouter>((ref) {
  final refresh = _RouterRefresh();
  ref.listen(sessionControllerProvider, (_, _) => refresh.refresh());
  ref.listen(hasAnyUserProvider, (_, _) => refresh.refresh());

  final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: Routes.reports,
    refreshListenable: refresh,
    debugLogDiagnostics: false,
    redirect: (context, state) {
      final hasUser = ref.read(hasAnyUserProvider);
      final loggedIn = ref.read(sessionControllerProvider) != null;
      final loc = state.matchedLocation;

      if (!hasUser) return loc == Routes.onboarding ? null : Routes.onboarding;
      if (!loggedIn) return loc == Routes.login ? null : Routes.login;
      if (loc == Routes.login || loc == Routes.onboarding) return Routes.reports;
      return null;
    },
    routes: [
      GoRoute(
        path: Routes.login,
        pageBuilder: (context, state) => fadePage(key: state.pageKey, child: const LoginScreen()),
      ),
      GoRoute(
        path: Routes.onboarding,
        pageBuilder: (context, state) =>
            fadePage(key: state.pageKey, child: const OnboardingScreen()),
      ),
      StatefulShellRoute.indexedStack(
        pageBuilder: (context, state, navigationShell) => fadePage(
          key: state.pageKey,
          child: HomeShell(navigationShell: navigationShell),
        ),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.reports,
                builder: (context, state) => const ReportsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.customers,
                builder: (context, state) => const CustomersScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.inventory,
                builder: (context, state) => const InventoryScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.services,
                builder: (context, state) => const ServicesScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.newSale,
                builder: (context, state) => const NewSaleScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: Routes.store,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) =>
            fadeSlidePage(key: state.pageKey, child: const StoreSettingsScreen()),
      ),
      GoRoute(
        path: Routes.customerNew,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) =>
            fadeSlidePage(key: state.pageKey, child: const CustomerFormScreen()),
      ),
      GoRoute(
        path: '/customers/:id/edit',
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) => fadeSlidePage(
          key: state.pageKey,
          child: CustomerFormScreen(customerId: int.parse(state.pathParameters['id']!)),
        ),
      ),
      // /inventory/new debe declararse antes de /inventory/:id.
      GoRoute(
        path: Routes.productNew,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) =>
            fadeSlidePage(key: state.pageKey, child: const ProductFormScreen()),
      ),
      GoRoute(
        path: '/inventory/:id',
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) => fadeSlidePage(
          key: state.pageKey,
          child: ProductDetailScreen(productId: int.parse(state.pathParameters['id']!)),
        ),
        routes: [
          GoRoute(
            path: 'edit',
            parentNavigatorKey: rootNavigatorKey,
            pageBuilder: (context, state) => fadeSlidePage(
              key: state.pageKey,
              child: ProductFormScreen(productId: int.parse(state.pathParameters['id']!)),
            ),
          ),
          GoRoute(
            path: 'movements',
            parentNavigatorKey: rootNavigatorKey,
            pageBuilder: (context, state) => fadeSlidePage(
              key: state.pageKey,
              child: ProductMovementsScreen(productId: int.parse(state.pathParameters['id']!)),
            ),
          ),
        ],
      ),
      GoRoute(
        path: Routes.serviceNew,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) =>
            fadeSlidePage(key: state.pageKey, child: const ServiceFormScreen()),
      ),
      GoRoute(
        path: '/services/:id/edit',
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) => fadeSlidePage(
          key: state.pageKey,
          child: ServiceFormScreen(serviceId: int.parse(state.pathParameters['id']!)),
        ),
      ),
      GoRoute(
        path: Routes.storeUser,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) =>
            fadeSlidePage(key: state.pageKey, child: const UserSettingsScreen()),
      ),
      GoRoute(
        path: Routes.categories,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) =>
            fadeSlidePage(key: state.pageKey, child: const CategoriesScreen()),
      ),
      GoRoute(
        path: Routes.categoryNew,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) => fadeSlidePage(
          key: state.pageKey,
          child: CategoryFormScreen(
            initialScope: CategoryScope.values
                .where((s) => s.dbValue == state.uri.queryParameters['scope'])
                .firstOrNull,
          ),
        ),
      ),
      GoRoute(
        path: '/store/categories/:id/edit',
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) => fadeSlidePage(
          key: state.pageKey,
          child: CategoryFormScreen(categoryId: int.parse(state.pathParameters['id']!)),
        ),
      ),
    ],
  );
  ref.onDispose(() {
    router.dispose();
    refresh.dispose();
  });
  return router;
});
