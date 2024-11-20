import 'package:automanager/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../data/model/model.dart';
import '../../repository/repository.dart';

class UpdateRental implements UseCase<Rental,RentalRequest>{

  UpdateRental({required this.autoManagerRepository});
  final AutoManagerRepository autoManagerRepository;
  @override
  Future<Either<Failure, Rental>> call(RentalRequest request) {
    return autoManagerRepository.updateRental(updateRentalRequest: request);
  }
}