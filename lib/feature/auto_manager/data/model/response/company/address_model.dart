// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_model.freezed.dart';

part 'address_model.g.dart';

@freezed
class Address with _$Address {
  const factory Address({
    String? street,
    String? city,
    String? state,
    String? postalCode,
    String? country,
  }) = _Address;

  const Address._();

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  factory Address.empty() => const Address(
    street: '',
    city: '',
    state: '',
    postalCode: '',
    country: '',
  );
}
