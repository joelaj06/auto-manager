import 'package:automanager/core/errors/failure.dart';
import 'package:automanager/feature/authentication/data/data.dart';
import 'package:automanager/feature/authentication/domain/domain.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecase/usecase.dart';

class ChangePassword implements UseCase<User, ChangePasswordRequest>{
  ChangePassword({required this.authRepository});

  final AuthRepository authRepository;
  @override
  Future<Either<Failure, User>> call(ChangePasswordRequest request) {
    return authRepository.changePassword(changePasswordRequest:request);
  }

}