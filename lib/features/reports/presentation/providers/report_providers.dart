import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_providers.dart';
import '../../../../core/utils/clock.dart';
import '../../data/datasources/report_local_data_source.dart';
import '../../data/repositories/report_repository_impl.dart';
import '../../domain/entities/monthly_report.dart';
import '../../domain/repositories/report_repository.dart';

final reportLocalDataSourceProvider = Provider<ReportLocalDataSource>(
  (ref) => ReportLocalDataSource(ref.watch(appDatabaseProvider)),
);

final reportRepositoryProvider = Provider<ReportRepository>(
  (ref) => ReportRepositoryImpl(ref.watch(reportLocalDataSourceProvider)),
);

/// Mes seleccionado y dirección del último cambio (para animar el slide).
typedef SelectedMonth = ({int year, int month, int direction});

final selectedMonthProvider =
    NotifierProvider<SelectedMonthController, SelectedMonth>(SelectedMonthController.new);

class SelectedMonthController extends Notifier<SelectedMonth> {
  @override
  SelectedMonth build() {
    final now = DateTime.now();
    return (year: now.year, month: now.month, direction: 0);
  }

  void previous() {
    final (y, m) = previousMonth(state.year, state.month);
    state = (year: y, month: m, direction: -1);
  }

  void next() {
    if (isCurrent) return;
    final (y, m) = nextMonth(state.year, state.month);
    state = (year: y, month: m, direction: 1);
  }

  bool get isCurrent {
    final now = DateTime.now();
    return state.year == now.year && state.month == now.month;
  }
}

final monthlyReportProvider = FutureProvider.family<MonthlyReport, (int, int)>((ref, ym) async {
  final result = await ref.watch(reportRepositoryProvider).monthly(ym.$1, ym.$2);
  return result.getOrThrow();
});

final firstSaleMonthProvider = FutureProvider<(int, int)?>((ref) async {
  final result = await ref.watch(reportRepositoryProvider).firstSaleMonth();
  return result.getOrThrow();
});

/// Filtro por categoría de la lista "qué se vendió" (`null` = todas).
final reportCategoryFilterProvider = NotifierProvider<ReportCategoryFilter, String?>(ReportCategoryFilter.new);

class ReportCategoryFilter extends Notifier<String?> {
  @override
  String? build() => null;

  void set(String? category) => state = category;
}

void invalidateReports(Ref ref) {
  ref.invalidate(monthlyReportProvider);
  ref.invalidate(firstSaleMonthProvider);
}
