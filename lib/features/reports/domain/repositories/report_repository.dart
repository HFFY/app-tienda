import '../../../../core/error/result.dart';
import '../entities/monthly_report.dart';

abstract interface class ReportRepository {
  Future<Result<MonthlyReport>> monthly(int year, int month);

  /// `(year, month)` de la primera venta registrada, o `null` si no hay.
  Future<Result<(int, int)?>> firstSaleMonth();
}
