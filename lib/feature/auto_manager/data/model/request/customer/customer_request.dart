// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer_request.freezed.dart';

part 'customer_request.g.dart';

@freezed
class CustomerRequest with _$CustomerRequest {
  const factory CustomerRequest({
     String? id,
     String? name,
     String? email,
     String? phone,
     String? address,
     String? identificationNumber,
     String? occupation,
     String? business,
     String? company,
     String? dateOfBirth,
  }) = _CustomerRequest;

  const CustomerRequest._();

  factory CustomerRequest.fromJson(Map<String, dynamic> json) =>
      _$CustomerRequestFromJson(json);


}
