import 'package:automanager/core/core.dart';
import 'package:automanager/feature/auto_manager/domain/domain.dart';
import 'package:dartz/dartz.dart';

import '../../../data/model/response/driver/driver_model.dart';

class DeleteDriver implements UseCase<Driver, String>{
  DeleteDriver({required this.autoManagerRepository});
  final AutoManagerRepository autoManagerRepository;
  @override
  Future<Either<Failure, Driver>> call(String driverId) {
    return autoManagerRepository.deleteDriver(driverId: driverId);
  }

}