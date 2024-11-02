// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_summary_model.freezed.dart';

part 'dashboard_summary_model.g.dart';

@freezed
class DashboardSummary with _$DashboardSummary {
  const factory DashboardSummary({
    required int? revenue,
    required int? sales,
    required int? drivers,
    required int? customers,
    required int? vehicles,
    required int? rentalSales,
    required int? expenses,
  }) = _DashboardSummary;

  const DashboardSummary._();

  factory DashboardSummary.fromJson(Map<String, dynamic> json) =>
      _$DashboardSummaryFromJson(json);

  factory DashboardSummary.empty() => const DashboardSummary(
    revenue: 0,
    sales: 0,
    drivers: 0,
    customers: 0,
    vehicles: 0,
    rentalSales: 0,
    expenses: 0,
  );
}
