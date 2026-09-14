/// Mapa de rutas de la app.
abstract final class Routes {
  static const login = '/login';
  static const onboarding = '/onboarding';

  // Pestañas del shell
  static const reports = '/reports';
  static const customers = '/customers';
  static const inventory = '/inventory';
  static const services = '/services';
  static const newSale = '/sales/new';

  // Clientes
  static const customerNew = '/customers/new';
  static String customerEdit(int id) => '/customers/$id/edit';

  // Inventario
  static const productNew = '/inventory/new';
  static String productDetail(int id) => '/inventory/$id';
  static String productEdit(int id) => '/inventory/$id/edit';
  static String productMovements(int id) => '/inventory/$id/movements';

  // Servicios
  static const serviceNew = '/services/new';
  static String serviceEdit(int id) => '/services/$id/edit';

  // Configuración
  static const store = '/store';
  static const storeUser = '/store/user';
  static const categories = '/store/categories';
  static const categoryNew = '/store/categories/new';
  static String categoryEdit(int id) => '/store/categories/$id/edit';
}
