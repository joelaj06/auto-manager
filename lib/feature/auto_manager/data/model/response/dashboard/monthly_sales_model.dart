// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'monthly_sales_model.freezed.dart';

part 'monthly_sales_model.g.dart';

@freezed
class MonthlySales with _$MonthlySales {
  const factory MonthlySales({
    required List<int> weeks,
    required List<int> sales,
  }) = _MonthlySales;

  const MonthlySales._();

  factory MonthlySales.fromJson(Map<String, dynamic> json) =>
      _$MonthlySalesFromJson(json);

  factory MonthlySales.empty() => const MonthlySales(
    weeks: <int>[],
    sales: <int>[],
  );
}
