// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'otp_verification_request.freezed.dart';
part 'otp_verification_request.g.dart';

@freezed
class OtpVerificationRequest with _$OtpVerificationRequest {
  const factory OtpVerificationRequest({
    required String userId,
    required String otp,
  }) = _OtpVerificationRequest;

  const OtpVerificationRequest._();

  factory OtpVerificationRequest.fromJson(Map<String, dynamic> json) =>
      _$OtpVerificationRequestFromJson(json);

}

