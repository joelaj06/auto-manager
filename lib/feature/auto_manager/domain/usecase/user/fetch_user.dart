import 'package:automanager/core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../../authentication/data/models/response/user/user_model.dart';
import '../../repository/automanager_repository.dart';

class FetchUser implements UseCase<User, String>{

  FetchUser({required this.autoManagerRepository});
  final AutoManagerRepository autoManagerRepository;
  @override
  Future<Either<Failure, User>> call(String userId) {
    return autoManagerRepository.fetchUser(userId: userId);
  }

}