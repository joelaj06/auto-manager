import 'package:automanager/core/core.dart';
import 'package:automanager/feature/authentication/data/data.dart';
import 'package:dartz/dartz.dart';

import '../repository/auth_repository.dart';

class VerifyRegistrationOtp implements UseCase<UserRegistration, OtpVerificationRequest> {
  VerifyRegistrationOtp({required this.authRepository});


  final AuthRepository authRepository;

  @override
  Future<Either<Failure, UserRegistration>> call(OtpVerificationRequest otpVerificationRequest) {
    return authRepository.verifyOtp(request: otpVerificationRequest);
  }

}
