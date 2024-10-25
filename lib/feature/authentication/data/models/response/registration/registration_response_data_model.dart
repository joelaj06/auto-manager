// ignore_for_file: invalid_annotation_target

import 'package:automanager/feature/authentication/data/data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'registration_response_data_model.freezed.dart';

part 'registration_response_data_model.g.dart';

@freezed
class UserRegistrationData with _$UserRegistrationData {
  const factory UserRegistrationData({
    required String email,
    required String? userId,

    User? data,
  }) = _UserRegistrationData;

  const UserRegistrationData._();

  factory UserRegistrationData.fromJson(Map<String, dynamic> json) =>
      _$UserRegistrationDataFromJson(json);

  factory UserRegistrationData.empty() => const UserRegistrationData(
        email: '',
        userId: '',
      );
}
