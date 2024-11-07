// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'insurance_details_model.freezed.dart';

part 'insurance_details_model.g.dart';

@freezed
class InsuranceDetail with _$InsuranceDetail {
  const factory InsuranceDetail({
    String? provider,
    String? policyNumber,
    String? expiryDate,

  }) = _InsuranceDetail;

  const InsuranceDetail._();

  factory InsuranceDetail.fromJson(Map<String, dynamic> json) =>
      _$InsuranceDetailFromJson(json);

  factory InsuranceDetail.empty() => const InsuranceDetail(

  );
}
