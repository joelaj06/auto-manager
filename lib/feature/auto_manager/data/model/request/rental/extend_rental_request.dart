// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'extend_rental_request.freezed.dart';

part 'extend_rental_request.g.dart';

@freezed
class ExtendRentalRequest with _$ExtendRentalRequest {
  const factory ExtendRentalRequest({
    String? id,
    String? extendedNote,
    double? extendedAmount,
    String? extendedDate,
  }) = _ExtendRentalRequest;

  const ExtendRentalRequest._();

  factory ExtendRentalRequest.fromJson(Map<String, dynamic> json) =>
      _$ExtendRentalRequestFromJson(json);


}
