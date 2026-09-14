import '../../../../core/error/db_guard.dart';
import '../../../../core/error/result.dart';
import '../../../../core/utils/clock.dart';
import '../../../../core/utils/money_math.dart';
import '../../../sales/domain/entities/sale.dart';
import '../../domain/entities/monthly_report.dart';
import '../../domain/repositories/report_repository.dart';
import '../datasources/report_local_data_source.dart';

final class ReportRepositoryImpl implements ReportRepository {
  const ReportRepositoryImpl(this._ds);

  final ReportLocalDataSource _ds;

  @override
  Future<Result<MonthlyReport>> monthly(int year, int month) => guardDb(() async {
        final bounds = monthBoundsUtc(year, month);
        final start = bounds.start;
        final end = bounds.end;

        final gross = await _ds.grossByType(start, end);
        final totals = await _ds.totals(start, end);
        final items = await _ds.soldItems(start, end);
        final byCat = await _ds.revenueByCategory(start, end);
        final top = await _ds.topCustomer(start, end);
        final dates = await _ds.salesDates(start, end);

        // Agrupar por día del mes en hora local.
        final dayTotals = <int, double>{};
        final dayCounts = <int, int>{};
        for (final r in dates) {
          final local = parseUtc(r['sale_date'] as String).toLocal();
          final d = local.day;
          dayTotals[d] = (dayTotals[d] ?? 0) + ((r['total'] as num?) ?? 0).toDouble();
          dayCounts[d] = (dayCounts[d] ?? 0) + 1;
        }
        final days = daysInMonth(year, month);
        final daily = [
          for (var d = 1; d <= days; d++)
            DailyTotal(day: d, total: roundMoney(dayTotals[d] ?? 0), salesCount: dayCounts[d] ?? 0),
        ];

        return MonthlyReport(
          year: year,
          month: month,
          productsGross: roundMoney(gross.products),
          servicesGross: roundMoney(gross.services),
          netTotal: roundMoney(totals.net),
          salesCount: totals.count,
          unitsSold: totals.units,
          discountsGiven: roundMoney(totals.discounts),
          topCustomer: top == null
              ? null
              : TopCustomer(
                  id: top['id'] as int,
                  name: top['name'] as String,
                  purchases: (top['purchases'] as int?) ?? 0,
                  spent: roundMoney(((top['spent'] as num?) ?? 0).toDouble()),
                ),
          daily: daily,
          byCategory: [
            for (final r in byCat)
              CategoryRevenue(
                name: r['category'] as String,
                revenue: roundMoney(((r['revenue'] as num?) ?? 0).toDouble()),
                colorHex: r['color_hex'] as String?,
                iconCode: r['icon_code'] as int?,
              ),
          ],
          soldItems: [
            for (final r in items)
              SoldItem(
                type: SaleItemType.fromDb(r['item_type'] as String?),
                refId: (r['ref_id'] as int?) ?? 0,
                name: r['item_name'] as String,
                category: r['category'] as String?,
                unitsSold: (r['units_sold'] as int?) ?? 0,
                timesSold: (r['times_sold'] as int?) ?? 0,
                revenue: roundMoney(((r['revenue'] as num?) ?? 0).toDouble()),
              ),
          ],
        );
      });

  @override
  Future<Result<(int, int)?>> firstSaleMonth() => guardDb(() async {
        final d = await _ds.firstSaleDate();
        if (d == null) return null;
        final local = parseUtc(d).toLocal();
        return (local.year, local.month);
      });
}
