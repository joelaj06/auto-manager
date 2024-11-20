// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'rental_request.freezed.dart';

part 'rental_request.g.dart';

@freezed
class RentalRequest with _$RentalRequest {
  const factory RentalRequest({
    String? id,
    String? renter,
    String? vehicle,
    String? startDate,
    String? endDate,
    double? cost,
    String? status,
    double? amountPaid,
    double? balance,
    double? totalAmount,
    String? receiptNumber,
    String? purpose,
    String? note,
  }) = _RentalRequest;

  const RentalRequest._();

  factory RentalRequest.fromJson(Map<String, dynamic> json) =>
      _$RentalRequestFromJson(json);


}
