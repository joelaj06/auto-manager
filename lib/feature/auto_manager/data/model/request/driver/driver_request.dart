// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'driver_request.freezed.dart';

part 'driver_request.g.dart';

@freezed
class DriverRequest with _$DriverRequest {
  const factory DriverRequest({
    String? vehicleId,
    String? licenseNumber,
    int? experienceYears,
    @JsonKey(name: 'lisenceExpiryDate')String? licenceExpiryDate,
  }) = _DriverRequest;

  const DriverRequest._();

  factory DriverRequest.fromJson(Map<String, dynamic> json) =>
      _$DriverRequestFromJson(json);


}
