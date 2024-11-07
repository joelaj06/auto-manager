// ignore_for_file: invalid_annotation_target
import 'package:automanager/feature/auto_manager/data/data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../authentication/data/models/models.dart';

part 'driver_model.freezed.dart';

part 'driver_model.g.dart';

@freezed
class Driver with _$Driver {
  const factory Driver({
   @JsonKey(name: '_id') required String? id,
    String? licenseNumber,
    @JsonKey(name: 'lisenceExpiryDate')String? licenceExpiryDate,
    String? status,
    String? userId,
    required User user,
    List<Sale>? salesHistory,
    String? createdAt,
    String? updatedAt,
    String? driverCode,
    String? company,
  }) = _Driver;

  const Driver._();

  factory Driver.fromJson(Map<String, dynamic> json) =>
      _$DriverFromJson(json);

  factory Driver.empty() =>  Driver(
    id: '',
    user: User.empty(),
  );
}
