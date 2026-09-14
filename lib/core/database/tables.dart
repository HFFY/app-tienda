/// Nombres de tablas y columnas del esquema SQLite.
abstract final class Tables {
  static const store = 'store';
  static const appUser = 'app_user';
  static const category = 'category';
  static const customer = 'customer';
  static const product = 'product';
  static const service = 'service';
  static const sale = 'sale';
  static const saleItem = 'sale_item';
  static const inventoryMovement = 'inventory_movement';
}

/// Columnas comunes a la mayoría de las tablas.
abstract final class CommonCols {
  static const id = 'id';
  static const isActive = 'is_active';
  static const createdAt = 'created_at';
  static const updatedAt = 'updated_at';
}

abstract final class StoreCols {
  static const id = 'id';
  static const name = 'name';
  static const logoPath = 'logo_path';
  static const address = 'address';
  static const phone = 'phone';
  static const themeColor = 'theme_color';
  static const themeMode = 'theme_mode';
  static const currencySymbol = 'currency_symbol';
  static const currencyCode = 'currency_code';
  static const numberLocale = 'number_locale';
  static const decimalPlaces = 'decimal_places';
  static const whatsappCountryCode = 'whatsapp_country_code';
  static const lastBackupAt = 'last_backup_at';
  static const createdAt = 'created_at';
  static const updatedAt = 'updated_at';
}

abstract final class UserCols {
  static const id = 'id';
  static const firstName = 'first_name';
  static const lastName = 'last_name';
  static const email = 'email';
  static const passwordHash = 'password_hash';
  static const passwordSalt = 'password_salt';
  static const createdAt = 'created_at';
  static const updatedAt = 'updated_at';
}

abstract final class CategoryCols {
  static const id = 'id';
  static const name = 'name';
  static const scope = 'scope';
  static const colorHex = 'color_hex';
  static const iconCode = 'icon_code';
  static const sortOrder = 'sort_order';
  static const isActive = 'is_active';
  static const createdAt = 'created_at';
  static const updatedAt = 'updated_at';
}

abstract final class CustomerCols {
  static const id = 'id';
  static const firstName = 'first_name';
  static const lastName = 'last_name';
  static const phone = 'phone';
  static const notes = 'notes';
  static const gender = 'gender';
  static const isActive = 'is_active';
  static const createdAt = 'created_at';
  static const updatedAt = 'updated_at';
}

abstract final class ProductCols {
  static const id = 'id';
  static const categoryId = 'category_id';
  static const name = 'name';
  static const description = 'description';
  static const price = 'price';
  static const imagePath = 'image_path';
  static const stock = 'stock';
  static const minStock = 'min_stock';
  static const isActive = 'is_active';
  static const createdAt = 'created_at';
  static const updatedAt = 'updated_at';
}

abstract final class ServiceCols {
  static const id = 'id';
  static const categoryId = 'category_id';
  static const name = 'name';
  static const description = 'description';
  static const price = 'price';
  static const imagePath = 'image_path';
  static const durationMinutes = 'duration_minutes';
  static const isActive = 'is_active';
  static const createdAt = 'created_at';
  static const updatedAt = 'updated_at';
}

abstract final class SaleCols {
  static const id = 'id';
  static const customerId = 'customer_id';
  static const saleDate = 'sale_date';
  static const subtotal = 'subtotal';
  static const discountType = 'discount_type';
  static const discountValue = 'discount_value';
  static const discountAmount = 'discount_amount';
  static const total = 'total';
  static const note = 'note';
  static const createdAt = 'created_at';
}

abstract final class SaleItemCols {
  static const id = 'id';
  static const saleId = 'sale_id';
  static const itemType = 'item_type';
  static const productId = 'product_id';
  static const serviceId = 'service_id';
  static const nameSnapshot = 'name_snapshot';
  static const categorySnapshot = 'category_snapshot';
  static const unitPrice = 'unit_price';
  static const quantity = 'quantity';
  static const lineTotal = 'line_total';
}

abstract final class MovementCols {
  static const id = 'id';
  static const productId = 'product_id';
  static const movementType = 'movement_type';
  static const quantity = 'quantity';
  static const reason = 'reason';
  static const saleId = 'sale_id';
  static const note = 'note';
  static const movedAt = 'moved_at';
  static const createdAt = 'created_at';
}
