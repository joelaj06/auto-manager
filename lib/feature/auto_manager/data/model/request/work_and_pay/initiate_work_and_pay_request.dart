// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'initiate_work_and_pay_request.freezed.dart';

part 'initiate_work_and_pay_request.g.dart';

@freezed
sealed class InitiateWorkAndPayRequest with _$InitiateWorkAndPayRequest {
  const factory InitiateWorkAndPayRequest({
    required String driverId,
    required String vehicleId,
    required double originalPrice,
    required double multiplier,
    required double finalPrice,
    required int durationYears,
    required String frequency,
  }) = _InitiateWorkAndPayRequest;

  const InitiateWorkAndPayRequest._();

  factory InitiateWorkAndPayRequest.fromJson(Map<String, dynamic> json) =>
      _$InitiateWorkAndPayRequestFromJson(json);
}

