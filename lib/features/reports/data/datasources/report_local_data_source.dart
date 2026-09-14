import 'package:sqflite/sqflite.dart';

import '../../../../core/database/local_data_source.dart';
import '../../../../core/database/tables.dart';

/// Consultas agregadas del mes. Reciben los límites `[start, end)` ya en
/// ISO UTC (ver `monthBoundsUtc`).
final class ReportLocalDataSource extends LocalDataSource {
  const ReportLocalDataSource(super.appDb);

  /// Ingreso bruto por tipo de ítem.
  Future<({double products, double services})> grossByType(String start, String end, {DatabaseExecutor? txn}) async {
    final rows = await exec(txn).rawQuery('''
      SELECT
        COALESCE(SUM(CASE WHEN si.${SaleItemCols.itemType} = 'product' THEN si.${SaleItemCols.lineTotal} ELSE 0 END), 0) AS p,
        COALESCE(SUM(CASE WHEN si.${SaleItemCols.itemType} = 'service' THEN si.${SaleItemCols.lineTotal} ELSE 0 END), 0) AS s
      FROM ${Tables.saleItem} si
      JOIN ${Tables.sale} sa ON sa.${SaleCols.id} = si.${SaleItemCols.saleId}
      WHERE sa.${SaleCols.saleDate} >= ? AND sa.${SaleCols.saleDate} < ?
    ''', [start, end]);
    final r = rows.first;
    return (products: _d(r['p']), services: _d(r['s']));
  }

  /// Cantidad de ventas, neto y descuentos.
  Future<({int count, double net, double discounts, int units})> totals(String start, String end,
      {DatabaseExecutor? txn}) async {
    final rows = await exec(txn).rawQuery('''
      SELECT COUNT(*) AS c,
             COALESCE(SUM(${SaleCols.total}), 0) AS net,
             COALESCE(SUM(${SaleCols.discountAmount}), 0) AS disc,
             COALESCE((SELECT SUM(si.${SaleItemCols.quantity}) FROM ${Tables.saleItem} si
                       JOIN ${Tables.sale} s2 ON s2.${SaleCols.id} = si.${SaleItemCols.saleId}
                       WHERE s2.${SaleCols.saleDate} >= ? AND s2.${SaleCols.saleDate} < ?), 0) AS units
      FROM ${Tables.sale}
      WHERE ${SaleCols.saleDate} >= ? AND ${SaleCols.saleDate} < ?
    ''', [start, end, start, end]);
    final r = rows.first;
    return (
      count: (r['c'] as int?) ?? 0,
      net: _d(r['net']),
      discounts: _d(r['disc']),
      units: (r['units'] as int?) ?? 0,
    );
  }

  /// Qué se vendió y cuántas veces. Agrupa por **id** (no por nombre actual):
  /// renombrar un producto no parte la fila y dos homónimos no se fusionan.
  Future<List<Map<String, Object?>>> soldItems(String start, String end, {DatabaseExecutor? txn}) {
    return exec(txn).rawQuery('''
      SELECT si.${SaleItemCols.itemType} AS item_type,
             COALESCE(si.${SaleItemCols.productId}, si.${SaleItemCols.serviceId}) AS ref_id,
             MAX(COALESCE(p.${ProductCols.name}, sv.${ServiceCols.name}, si.${SaleItemCols.nameSnapshot})) AS item_name,
             MAX(si.${SaleItemCols.categorySnapshot}) AS category,
             SUM(si.${SaleItemCols.quantity}) AS units_sold,
             COUNT(DISTINCT sa.${SaleCols.id}) AS times_sold,
             SUM(si.${SaleItemCols.lineTotal}) AS revenue
      FROM ${Tables.saleItem} si
      JOIN ${Tables.sale} sa ON sa.${SaleCols.id} = si.${SaleItemCols.saleId}
      LEFT JOIN ${Tables.product} p ON p.${ProductCols.id} = si.${SaleItemCols.productId}
      LEFT JOIN ${Tables.service} sv ON sv.${ServiceCols.id} = si.${SaleItemCols.serviceId}
      WHERE sa.${SaleCols.saleDate} >= ? AND sa.${SaleCols.saleDate} < ?
      GROUP BY si.${SaleItemCols.itemType}, si.${SaleItemCols.productId}, si.${SaleItemCols.serviceId}
      ORDER BY units_sold DESC, revenue DESC
    ''', [start, end]);
  }

  /// Ingreso por categoría (snapshot), con el color/ícono de la categoría
  /// actual del mismo nombre si todavía existe.
  Future<List<Map<String, Object?>>> revenueByCategory(String start, String end, {DatabaseExecutor? txn}) {
    return exec(txn).rawQuery('''
      SELECT COALESCE(si.${SaleItemCols.categorySnapshot}, 'Sin categoría') AS category,
             SUM(si.${SaleItemCols.lineTotal}) AS revenue,
             MAX(c.${CategoryCols.colorHex}) AS color_hex,
             MAX(c.${CategoryCols.iconCode}) AS icon_code
      FROM ${Tables.saleItem} si
      JOIN ${Tables.sale} sa ON sa.${SaleCols.id} = si.${SaleItemCols.saleId}
      LEFT JOIN ${Tables.category} c ON c.${CategoryCols.name} = si.${SaleItemCols.categorySnapshot} COLLATE NOCASE
      WHERE sa.${SaleCols.saleDate} >= ? AND sa.${SaleCols.saleDate} < ?
      GROUP BY category
      ORDER BY revenue DESC
    ''', [start, end]);
  }

  Future<Map<String, Object?>?> topCustomer(String start, String end, {DatabaseExecutor? txn}) async {
    final rows = await exec(txn).rawQuery('''
      SELECT c.${CustomerCols.id} AS id,
             c.${CustomerCols.firstName} || ' ' || c.${CustomerCols.lastName} AS name,
             COUNT(s.${SaleCols.id}) AS purchases,
             SUM(s.${SaleCols.total}) AS spent
      FROM ${Tables.sale} s
      JOIN ${Tables.customer} c ON c.${CustomerCols.id} = s.${SaleCols.customerId}
      WHERE s.${SaleCols.saleDate} >= ? AND s.${SaleCols.saleDate} < ?
      GROUP BY c.${CustomerCols.id}
      ORDER BY purchases DESC, spent DESC
      LIMIT 1
    ''', [start, end]);
    return rows.isEmpty ? null : rows.first;
  }

  /// Fecha y total de cada venta del mes; la agrupación por **día local** se
  /// hace en Dart (`DATE()` de SQLite agruparía en UTC).
  Future<List<Map<String, Object?>>> salesDates(String start, String end, {DatabaseExecutor? txn}) {
    return exec(txn).query(
      Tables.sale,
      columns: [SaleCols.saleDate, SaleCols.total],
      where: '${SaleCols.saleDate} >= ? AND ${SaleCols.saleDate} < ?',
      whereArgs: [start, end],
    );
  }

  Future<String?> firstSaleDate({DatabaseExecutor? txn}) async {
    final rows = await exec(txn).rawQuery('SELECT MIN(${SaleCols.saleDate}) AS d FROM ${Tables.sale}');
    return rows.first['d'] as String?;
  }

  static double _d(Object? v) => ((v as num?) ?? 0).toDouble();
}
