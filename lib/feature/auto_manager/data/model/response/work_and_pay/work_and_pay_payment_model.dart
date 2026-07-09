// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'work_and_pay_payment_model.freezed.dart';

part 'work_and_pay_payment_model.g.dart';

@freezed
sealed class WorkAndPayPayment with _$WorkAndPayPayment {
  const factory WorkAndPayPayment({
    @JsonKey(name: '_id') required String id,
    String? paymentId,
    required String workAndPayAgreementId,
    required double amount,
    required String paymentDate,
    required String method,
  }) = _WorkAndPayPayment;

  const WorkAndPayPayment._();

  factory WorkAndPayPayment.fromJson(Map<String, dynamic> json) =>
      _$WorkAndPayPaymentFromJson(json);

  factory WorkAndPayPayment.empty() => const WorkAndPayPayment(
    id: '',
    workAndPayAgreementId: '',
    amount: 0.0,
    paymentDate: '',
    method: '',
  );
}

