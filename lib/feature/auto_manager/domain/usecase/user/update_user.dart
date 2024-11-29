import 'package:automanager/feature/authentication/data/data.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../repository/automanager_repository.dart';

class UpdateUser implements UseCase<User, UserRequest> {
  UpdateUser({required this.autoManagerRepository});
  final AutoManagerRepository autoManagerRepository;
  @override
  Future<Either<Failure, User>> call(UserRequest updateUserRequest) {
    return autoManagerRepository.updateUser(
        userRequest: updateUserRequest,
    );
  }
}