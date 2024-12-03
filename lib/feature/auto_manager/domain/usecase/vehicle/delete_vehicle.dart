import 'package:automanager/core/core.dart';
import 'package:automanager/feature/auto_manager/data/data.dart';
import 'package:dartz/dartz.dart';

import '../../repository/automanager_repository.dart';

class DeleteVehicle implements UseCase<Vehicle, String>{
  DeleteVehicle({required this.autoManagerRepository});

  final AutoManagerRepository autoManagerRepository;

  @override
  Future<Either<Failure, Vehicle>> call(String vehicleId) {
    return autoManagerRepository.deleteVehicle(vehicleId: vehicleId);
  }
}