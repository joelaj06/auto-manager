// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model.dart';

part 'work_and_pay_agreement_model.freezed.dart';

part 'work_and_pay_agreement_model.g.dart';

@freezed
sealed class WorkAndPayAgreement with _$WorkAndPayAgreement {
  const factory WorkAndPayAgreement({
    @JsonKey(name: '_id') required String id,
    required String agreementId,
    required String ownerId,
    required String driverId,
    required String vehicleId,
    required double originalVehiclePrice,
    required double totalSalePrice,
    required double installmentAmount,
    required String paymentFrequency,
    required int durationYears,
    required double amountPaid,
    required double balanceDue,
    required int installmentsPaid,
    required int installmentsRemaining,
    required String status,
    required String startDate,
    String? completionDate,
    required String createdBy,
    Driver? driver,
    Vehicle? vehicle,
  }) = _WorkAndPayAgreement;

  const WorkAndPayAgreement._();

  factory WorkAndPayAgreement.fromJson(Map<String, dynamic> json) =>
      _$WorkAndPayAgreementFromJson(json);

  factory WorkAndPayAgreement.empty() => const WorkAndPayAgreement(
    id: '',
    agreementId: '',
    ownerId: '',
    driverId: '',
    vehicleId: '',
    originalVehiclePrice: 0.0,
    totalSalePrice: 0.0,
    installmentAmount: 0.0,
    paymentFrequency: '',
    durationYears: 0,
    amountPaid: 0.0,
    balanceDue: 0.0,
    installmentsPaid: 0,
    installmentsRemaining: 0,
    status: '',
    startDate: '',
    createdBy: '',
  );

  double get progressPercent =>
      totalSalePrice > 0 ? (amountPaid / totalSalePrice).clamp(0.0, 1.0) : 0;

  bool get isActive => status == 'Active';
  bool get isCompleted => status == 'Completed';
  bool get isDefaulted => status == 'Defaulted';
}

