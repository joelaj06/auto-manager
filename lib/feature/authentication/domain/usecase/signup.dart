

import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../data/models/models.dart';
import '../repository/auth_repository.dart';


class UserSignUp implements UseCase<UserRegistration,UserRequest>{
  UserSignUp({required this.authRepository});

  final AuthRepository authRepository;
  @override
  Future<Either<Failure, UserRegistration>> call(UserRequest request) {
   return authRepository.addUser(userRequest: request);
  }

}