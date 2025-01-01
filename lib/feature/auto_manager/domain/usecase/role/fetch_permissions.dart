
import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../../authentication/data/models/response/user/permission_model.dart';
import '../../repository/automanager_repository.dart';

class FetchPermissions implements UseCase<List<UserPermission>, NoParams>{
  FetchPermissions({required this.autoManagerRepository});

  final AutoManagerRepository autoManagerRepository;

  @override
  Future<Either<Failure, List<UserPermission>>> call(NoParams params) {
    return autoManagerRepository.fetchPermissions();
  }
}