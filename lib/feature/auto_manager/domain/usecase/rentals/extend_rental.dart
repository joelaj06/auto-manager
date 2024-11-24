import 'package:automanager/core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../data/model/request/rental/rental.dart';
import '../../../data/model/response/rentals/rental.dart';
import '../../repository/automanager_repository.dart';

class ExtendRental implements UseCase<Rental, ExtendRentalRequest> {
  ExtendRental({required this.autoManagerRepository});

  final AutoManagerRepository autoManagerRepository;

  @override
  Future<Either<Failure, Rental>> call(ExtendRentalRequest request) {
    return autoManagerRepository.extendRental(extendRentalRequest: request);
  }
}
