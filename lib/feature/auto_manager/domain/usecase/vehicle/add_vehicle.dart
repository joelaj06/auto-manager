import 'package:automanager/core/core.dart';
import 'package:automanager/feature/auto_manager/data/data.dart';
import 'package:automanager/feature/auto_manager/domain/domain.dart';
import 'package:dartz/dartz.dart';

class AddVehicle implements UseCase<Vehicle, VehicleRequest>{
  AddVehicle({required this.autoManagerRepository});

  final AutoManagerRepository autoManagerRepository;

  @override
  Future<Either<Failure, Vehicle>> call(VehicleRequest request) {
    return autoManagerRepository.addVehicle(vehicleRequest: request);
  }


}