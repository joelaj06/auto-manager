// ignore_for_file: invalid_annotation_target
import 'package:automanager/feature/auto_manager/data/model/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer_model.freezed.dart';

part 'customer_model.g.dart';

@freezed
class Customer with _$Customer {
  const factory Customer({
    @JsonKey(name: '_id') String? id,
    required String name,
    String? email,
    String? phone,
    String? address,
    String? identificationNumber,
    String? occupation,
    String? business,
    String? company,
    String? dateOfBirth,
    List<Rental>? rentalHistory,
    String? createdAt,
    String? updatedAt,
    required String? customerCode,

  }) = _Customer;

  const Customer._();

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  factory Customer.empty() => const Customer(
    id: '',
    name: '',
    customerCode: '',
  );
}
