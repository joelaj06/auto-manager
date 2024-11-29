import 'package:automanager/core/core.dart';
import 'package:automanager/feature/authentication/data/data.dart';
import 'package:dartz/dartz.dart';

import '../../repository/automanager_repository.dart';

class AddUser implements UseCase<User, UserRequest> {
  AddUser({required this.autoManagerRepository});

  final AutoManagerRepository autoManagerRepository;

  @override
  Future<Either<Failure, User>> call(UserRequest request) {
    return autoManagerRepository.addUser(userRequest: request);
  }
}
