// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

import '../registration/registration_response_data_model.dart';

part 'message_response.freezed.dart';
part 'message_response.g.dart';

@freezed
class MessageResponse with _$MessageResponse {
  const factory MessageResponse({
    String? message,
    String? status,
    UserRegistrationData? data,
  }) = _MessageResponse;
  const MessageResponse._();

  factory MessageResponse.fromJson(Map<String, dynamic> json) =>
      _$MessageResponseFromJson(json);
}
