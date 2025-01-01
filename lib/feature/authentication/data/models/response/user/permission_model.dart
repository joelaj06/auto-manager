// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'permission_model.freezed.dart';
part 'permission_model.g.dart';

@freezed
class UserPermission with _$UserPermission {
  const factory UserPermission({
    @JsonKey(name:'_id') required String id,
    required String name,

  }) = _UserPermission;

  const UserPermission._();

  factory UserPermission.fromJson(Map<String, dynamic> json) =>
      _$UserPermissionFromJson(json);

  factory UserPermission.empty() => const UserPermission(
    id: '', name: '',

  );
}
