// ignore_for_file: invalid_annotation_target

import 'package:automanager/feature/authentication/data/models/response/registration/registration_response_data_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_registration_model.freezed.dart';
part 'user_registration_model.g.dart';

@freezed
class UserRegistration with _$UserRegistration {
  const factory UserRegistration({
    required String status,
    required String message,
    UserRegistrationData? data,
  }) = _UserRegistration;

  const UserRegistration._();

  factory UserRegistration.fromJson(Map<String, dynamic> json) =>
      _$UserRegistrationFromJson(json);

  factory UserRegistration.empty() => const UserRegistration(
    status: '',
    message: '',

  );
}

