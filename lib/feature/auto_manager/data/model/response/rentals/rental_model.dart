// ignore_for_file: invalid_annotation_target
import 'package:automanager/feature/authentication/data/data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model.dart';

part 'rental_model.freezed.dart';

part 'rental_model.g.dart';

@freezed
class Rental with _$Rental {
  const factory Rental({
    @JsonKey(name: '_id') required String id,
    required String rentalCode,
    Customer? renter,
    Vehicle? vehicle,
    String? startDate,
    String? endDate,
    required double cost,
    String? status,
    User? createdBy,
    User? updatedBy,
    String? note,
    String? company,
    String? createdAt,
    String? updatedAt,
    String? purpose,
    required double? amountPaid,
    required double? balance,
    required double? totalAmount,
    String? receiptNumber,
    List<RentalExtension>? extensions,
  }) = _Rental;

  const Rental._();

  factory Rental.fromJson(Map<String, dynamic> json) => _$RentalFromJson(json);

  factory Rental.empty() => const Rental(
      id: '',
      rentalCode: '',
      cost: 0,
      amountPaid: 0,
      balance: 0,
      totalAmount: 0);
}
