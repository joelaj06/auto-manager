// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'role_request.freezed.dart';

part 'role_request.g.dart';

@freezed
class RoleRequest with _$RoleRequest {
  const factory RoleRequest({
    String? id,
    required String? name,
    required List<String>? permissions,
    String? date,
  }) = _RoleRequest;

  const RoleRequest._();

  factory RoleRequest.fromJson(Map<String, dynamic> json) =>
      _$RoleRequestFromJson(json);


}
