// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'role_model.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class User with _$User {
  const factory User({
    @JsonKey(name:'_id') required String id,
     required String firstName,
   required String lastName,
    required String? email,
    String? address,
    String? token,
    String? phone,
    Role? role,
    @JsonKey(name: 'imageUrl') String? imgUrl,
    String? company,
    bool? isActive,
    String? status,
    bool? isVerified,
    String? userId,
    String? createdAt,

  }) = _User;

  const User._();

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  factory User.empty() => const User(
    id: '',
    firstName: '',
    lastName: '',
    email: '',

  );
}
