import 'package:automanager/core/core.dart';
import 'package:automanager/feature/authentication/data/data.dart';
import 'package:dartz/dartz.dart';

import '../../../data/model/response/driver/driver_model.dart';
import '../../repository/automanager_repository.dart';

class AddDriver implements UseCase<Driver, UserRequest> {
  AddDriver({required this.autoManagerRepository});

  final AutoManagerRepository autoManagerRepository;

  @override
  Future<Either<Failure, Driver>> call(UserRequest request) {
    return autoManagerRepository.addDriver(userRequest: request);
  }
}