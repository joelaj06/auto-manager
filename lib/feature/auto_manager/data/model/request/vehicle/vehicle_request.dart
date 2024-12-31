// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../response/vehicle/insurance_details_model.dart';

part 'vehicle_request.freezed.dart';

part 'vehicle_request.g.dart';

@freezed
class VehicleRequest with _$VehicleRequest {
  const factory VehicleRequest({
    String? id,
    String? licensePlate,
    String? make,
    String? model,
    int? year,
    String? color,
    String? vin,
    String? ownerId,
    String? status,
    String? currentDriverId,
    @JsonKey(name: 'rentalStatus')bool? isRented,
    InsuranceDetail? insuranceDetails,
    String? image,
  }) = _VehicleRequest;

  const VehicleRequest._();

  factory VehicleRequest.fromJson(Map<String, dynamic> json) =>
      _$VehicleRequestFromJson(json);

}
