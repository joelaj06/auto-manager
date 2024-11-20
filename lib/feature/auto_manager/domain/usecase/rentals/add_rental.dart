import 'package:automanager/core/core.dart';
import 'package:automanager/feature/auto_manager/data/data.dart';
import 'package:dartz/dartz.dart';

import '../../repository/automanager_repository.dart';

class AddRental implements UseCase<Rental,RentalRequest>{

  AddRental({required this.autoManagerRepository});
  final AutoManagerRepository autoManagerRepository;
  @override
  Future<Either<Failure, Rental>> call(RentalRequest request) {
   return autoManagerRepository.addRental(addRentalRequest: request);
  }
  
}