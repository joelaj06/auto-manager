// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'role_model.freezed.dart';
part 'role_model.g.dart';

@freezed
class Role with _$Role {
  const factory Role({
    @JsonKey(name:'_id') required String id,
   required String name,
    required List<String> permissions,

  }) = _Role;

  const Role._();

  factory Role.fromJson(Map<String, dynamic> json) =>
      _$RoleFromJson(json);

  factory Role.empty() => const Role(
    id: '', name: '', permissions: <String>[],

  );
}
