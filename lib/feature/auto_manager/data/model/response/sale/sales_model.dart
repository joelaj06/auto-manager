// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model.dart';

part 'sales_model.freezed.dart';

part 'sales_model.g.dart';

@freezed
class Sale with _$Sale {
  const factory Sale({
   @JsonKey(name: '_id') required String id,
   required String saleId,
    String? driverId,
    String? vehicleId,
    required double amount,
    String? date,
    String? company,
    String? status,
    String? createdBy,
    String? createdAt,
    String? updatedAt,
   required Driver driver,
   required Vehicle vehicle,
  }) = _Sale;

  const Sale._();

  factory Sale.fromJson(Map<String, dynamic> json) =>
      _$SaleFromJson(json);

  factory Sale.empty() =>  Sale(
    id:'',
    amount: 0,
    driver: Driver.empty(),
    vehicle: Vehicle.empty(),
    saleId: '',
  );
}
