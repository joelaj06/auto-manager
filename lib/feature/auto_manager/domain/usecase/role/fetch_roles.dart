import 'package:automanager/core/core.dart';
import 'package:automanager/feature/auto_manager/domain/domain.dart';
import 'package:dartz/dartz.dart';

import '../../../../authentication/data/models/response/user/role_model.dart';

class FetchRoles implements UseCase<List<Role>, NoParams>{
  FetchRoles({required this.autoManagerRepository});

  final AutoManagerRepository autoManagerRepository;
  @override
  Future<Either<Failure, List<Role>>> call(NoParams params) {
    return autoManagerRepository.fetchRoles();
  }
  
}