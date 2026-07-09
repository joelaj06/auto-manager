// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'record_work_and_pay_payment_request.freezed.dart';

part 'record_work_and_pay_payment_request.g.dart';

@freezed
sealed class RecordWorkAndPayPaymentRequest with _$RecordWorkAndPayPaymentRequest {
  const factory RecordWorkAndPayPaymentRequest({
    required String agreementId,
    required double amount,
    required String method,
  }) = _RecordWorkAndPayPaymentRequest;

  const RecordWorkAndPayPaymentRequest._();

  factory RecordWorkAndPayPaymentRequest.fromJson(Map<String, dynamic> json) =>
      _$RecordWorkAndPayPaymentRequestFromJson(json);
}

