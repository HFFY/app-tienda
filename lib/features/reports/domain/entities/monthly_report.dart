import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../sales/domain/entities/sale.dart';

part 'monthly_report.freezed.dart';

/// Reporte mensual. Todo se calcula sobre `sale` / `sale_item`; al no existir
/// anulaciones no hace falta filtrar por estado.
///
/// **Terminología:** "ingreso bruto" = lo facturado (Σ line_total). No se
/// registra costo de producto, así que no hay utilidad.
@freezed
abstract class MonthlyReport with _$MonthlyReport {
  const MonthlyReport._();

  const factory MonthlyReport({
    required int year,
    required int month,
    required double productsGross,
    required double servicesGross,
    required double netTotal,
    required int salesCount,
    required int unitsSold,
    required double discountsGiven,
    TopCustomer? topCustomer,
    @Default(<DailyTotal>[]) List<DailyTotal> daily,
    @Default(<CategoryRevenue>[]) List<CategoryRevenue> byCategory,
    @Default(<SoldItem>[]) List<SoldItem> soldItems,
  }) = _MonthlyReport;

  double get grossTotal => productsGross + servicesGross;
  bool get hasSales => salesCount > 0;
}

@freezed
abstract class DailyTotal with _$DailyTotal {
  const factory DailyTotal({required int day, required double total, required int salesCount}) = _DailyTotal;
}

@freezed
abstract class CategoryRevenue with _$CategoryRevenue {
  const factory CategoryRevenue({
    required String name,
    required double revenue,
    String? colorHex,
    int? iconCode,
  }) = _CategoryRevenue;
}

@freezed
abstract class SoldItem with _$SoldItem {
  const factory SoldItem({
    required SaleItemType type,
    required int refId,
    required String name,
    String? category,
    required int unitsSold,
    required int timesSold,
    required double revenue,
  }) = _SoldItem;
}

@freezed
abstract class TopCustomer with _$TopCustomer {
  const factory TopCustomer({
    required int id,
    required String name,
    required int purchases,
    required double spent,
  }) = _TopCustomer;
}
