// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_request.freezed.dart';
part 'user_request.g.dart';

@freezed
class UserRequest with _$UserRequest {
  const factory UserRequest({
    String? id,
      String? firstName,
      String? lastName,
     String? email,
    String? address,
    String? phone,
    String? password,
    String? confirmPassword,
   @JsonKey(name: 'imageUrl') String? image,
    String? company,
   bool? isActive,
    bool? isVerified,
    String? status,
    String? createdBy,
  }) = _UserRequest;

  const UserRequest._();

  factory UserRequest.fromJson(Map<String, dynamic> json) =>
      _$UserRequestFromJson(json);


}
