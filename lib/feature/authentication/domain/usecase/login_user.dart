import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../data/data.dart';
import '../repository/auth_repository.dart';
import '/core/usecase/usecase.dart';




class LoginUser implements UseCase<User, LoginRequest> {
  LoginUser({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Future<Either<Failure, User>> call(LoginRequest params) {
    return authRepository.login(params);
  }
}
