import 'package:automanager/core/core.dart';
import 'package:automanager/feature/auto_manager/domain/domain.dart';
import 'package:dartz/dartz.dart';

import '../../../../authentication/data/models/response/user/user_model.dart';

class DeleteUser implements UseCase<User, String>{
  DeleteUser({required this.autoManagerRepository});
  final AutoManagerRepository autoManagerRepository;
  @override
  Future<Either<Failure, User>> call(String userId) {
    return autoManagerRepository.deleteUser(userId: userId);
  }

}