import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../data/data.dart';
import '../domain.dart';

class LoadUser implements UseCase<User, void> {
  LoadUser({required this.authRepository});

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, User>> call(void a) {
    return authRepository.loadUser();
  }
}

class LoadUserSignupData implements UseCase<UserRegistration, void> {
  LoadUserSignupData({required this.authRepository});

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, UserRegistration>> call(void a) {
    return authRepository.loadUserSignUpData();
  }
}
