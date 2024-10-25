import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../data/models/models.dart';
import '../repository/auth_repository.dart';

class ResetPassword implements UseCase<MessageResponse, PasswordResetRequest>{
  ResetPassword({required this.authRepository});
  final AuthRepository authRepository;
  @override
  Future<Either<Failure, MessageResponse>> call(PasswordResetRequest request) {
    return authRepository.passwordReset(resetRequest: request);
  }

}