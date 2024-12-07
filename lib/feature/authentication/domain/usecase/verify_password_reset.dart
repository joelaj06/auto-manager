import 'package:automanager/core/errors/failure.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/usecase/usecase.dart';
import '../../data/models/request/password/password_reset_request.dart';
import '../../data/models/response/generic/message_response.dart';
import '../repository/auth_repository.dart';

class VerifyPasswordReset implements UseCase<MessageResponse, PasswordResetRequest> {

  VerifyPasswordReset({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, MessageResponse>> call(PasswordResetRequest request) {
    return authRepository.verifyPasswordReset(resetRequest: request);
  }
}