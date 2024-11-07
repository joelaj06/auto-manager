// ignore_for_file: invalid_annotation_target
import 'package:automanager/feature/auto_manager/data/data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'insurance_details_model.dart';

part 'vehicle_model.freezed.dart';

part 'vehicle_model.g.dart';

@freezed
class Vehicle with _$Vehicle {
  const factory Vehicle({
    InsuranceDetail? insuranceDetails,
    @JsonKey(name: '_id')String? id,
    String? vehicleId,
    String? licensePlate,
    String? make,
    String? model,
    int? year,
    String? color,
    String? vin,
    String? ownerId,
    String? status,
    String? currentDriverId,
    bool? rentalStatus,
    List<Sale>? salesHistory,
    List<Rental>? rentalHistory,
    String? createdAt,
    String? updatedAt,
    String? createdBy,
    String? image,
    String? company,
  }) = _Vehicle;

  const Vehicle._();

  factory Vehicle.fromJson(Map<String, dynamic> json) =>
      _$VehicleFromJson(json);

  factory Vehicle.empty() => const Vehicle(
    id: '',
    licensePlate: '',
    make: '',
  );
}
