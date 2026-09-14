import 'package:flutter/material.dart';

/// Tabla fija de íconos disponibles para categorías.
///
/// En la base se guarda el `codePoint`, pero **nunca** se reconstruye con
/// `IconData(codePoint)`: en release el tree-shaking de fuentes elimina los
/// glifos que no se referencian estáticamente. Referenciar `Icons.*` aquí
/// los mantiene en el binario y la búsqueda se hace por `codePoint`.
const List<IconData> kCategoryIcons = [
  Icons.category,
  Icons.local_cafe,
  Icons.fastfood,
  Icons.restaurant,
  Icons.local_bar,
  Icons.icecream,
  Icons.cake,
  Icons.spa,
  Icons.content_cut,
  Icons.healing,
  Icons.face,
  Icons.brush,
  Icons.checkroom,
  Icons.shopping_bag,
  Icons.devices,
  Icons.phone_android,
  Icons.headphones,
  Icons.build,
  Icons.home_repair_service,
  Icons.cleaning_services,
  Icons.pets,
  Icons.child_care,
  Icons.sports_soccer,
  Icons.book,
  Icons.school,
  Icons.local_pharmacy,
  Icons.local_florist,
  Icons.local_shipping,
  Icons.star,
  Icons.more_horiz,
];

/// Resuelve un `codePoint` guardado a su ícono; `Icons.category` si no existe.
IconData categoryIconFor(int? codePoint) {
  if (codePoint == null) return Icons.category;
  for (final icon in kCategoryIcons) {
    if (icon.codePoint == codePoint) return icon;
  }
  return Icons.category;
}

/// Paleta fija para el color de las categorías.
const List<String> kCategoryColors = [
  '#E53935',
  '#D81B60',
  '#8E24AA',
  '#5E35B1',
  '#3949AB',
  '#1E88E5',
  '#00897B',
  '#43A047',
  '#FB8C00',
  '#F4511E',
  '#6D4C41',
  '#757575',
];

Color? colorFromHex(String? hex) {
  if (hex == null || hex.isEmpty) return null;
  final clean = hex.replaceFirst('#', '');
  final value = int.tryParse(clean.length == 6 ? 'FF$clean' : clean, radix: 16);
  return value == null ? null : Color(value);
}
