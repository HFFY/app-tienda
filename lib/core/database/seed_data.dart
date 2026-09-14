import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../utils/clock.dart';
import 'tables.dart';

/// Datos iniciales: la fila única de `store` y categorías genéricas que el
/// usuario puede renombrar o borrar. El usuario administrador se crea en el
/// onboarding, nunca aquí.
Future<void> seedDatabase(DatabaseExecutor db) async {
  final now = nowUtcIso();

  await db.insert(Tables.store, {
    StoreCols.id: 1,
    StoreCols.name: 'Mi tienda',
    StoreCols.themeColor: 'red',
    StoreCols.themeMode: 'system',
    StoreCols.currencySymbol: 'Bs',
    StoreCols.currencyCode: 'BOB',
    StoreCols.numberLocale: 'es_BO',
    StoreCols.decimalPlaces: 2,
    StoreCols.whatsappCountryCode: '591',
    StoreCols.createdAt: now,
    StoreCols.updatedAt: now,
  });

  // (nombre, scope, color, ícono de kCategoryIcons)
  final categories = <(String, String, String, IconData)>[
    ('Bebidas', 'product', '#1E88E5', Icons.local_cafe),
    ('Snacks', 'product', '#FB8C00', Icons.fastfood),
    ('Cuidado personal', 'both', '#8E24AA', Icons.spa),
    ('Tratamientos', 'service', '#00897B', Icons.healing),
    ('Cortes', 'service', '#E53935', Icons.content_cut),
    ('Otros', 'both', '#757575', Icons.category),
  ];

  var order = 0;
  for (final (name, scope, color, icon) in categories) {
    await db.insert(Tables.category, {
      CategoryCols.name: name,
      CategoryCols.scope: scope,
      CategoryCols.colorHex: color,
      CategoryCols.iconCode: icon.codePoint,
      CategoryCols.sortOrder: order++,
      CategoryCols.isActive: 1,
      CategoryCols.createdAt: now,
      CategoryCols.updatedAt: now,
    });
  }
}
