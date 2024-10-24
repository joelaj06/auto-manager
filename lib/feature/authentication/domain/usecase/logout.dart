

import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../data/models/models.dart';
import '../repository/auth_repository.dart';

class Logout implements UseCase<MessageResponse,NoParams>{
  Logout({required this.authRepository});

  final AuthRepository authRepository;

  @override
  Future<Either<Failure, MessageResponse>> call(NoParams params) {
    return authRepository.logout();
  }
}