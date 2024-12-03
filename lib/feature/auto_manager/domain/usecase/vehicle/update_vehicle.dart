import 'package:automanager/core/core.dart';
import 'package:automanager/feature/auto_manager/data/data.dart';
import 'package:automanager/feature/auto_manager/domain/domain.dart';
import 'package:dartz/dartz.dart';

class UpdateVehicle implements UseCase<Vehicle,VehicleRequest>{
  UpdateVehicle({required this.autoManagerRepository});

  final AutoManagerRepository autoManagerRepository;
  @override
  Future<Either<Failure, Vehicle>> call(VehicleRequest request) {
    return autoManagerRepository.updateVehicle(vehicleRequest: request);
  }

}