import 'package:automanager/core/core.dart';
import 'package:automanager/feature/auto_manager/domain/domain.dart';
import 'package:dartz/dartz.dart';

import '../../../../authentication/data/models/response/user/role_model.dart';
import '../../../data/model/request/role/role_request.dart';

class UpdateRole implements UseCase<Role, RoleRequest>{
  UpdateRole({required this.autoManagerRepository});

  final AutoManagerRepository autoManagerRepository;
  @override
  Future<Either<Failure, Role>> call(RoleRequest request) {
    return autoManagerRepository.updateRole(roleRequest: request);
  }

}