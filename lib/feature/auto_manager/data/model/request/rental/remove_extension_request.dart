// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'remove_extension_request.freezed.dart';

part 'remove_extension_request.g.dart';

@freezed
class RemoveExtensionRequest with _$RemoveExtensionRequest {
  const factory RemoveExtensionRequest({
    required String rentalId,
    required List<int> indexes,
  }) = _RemoveExtensionRequest;

  const RemoveExtensionRequest._();

  factory RemoveExtensionRequest.fromJson(Map<String, dynamic> json) =>
      _$RemoveExtensionRequestFromJson(json);


}
