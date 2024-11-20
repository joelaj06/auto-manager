import 'package:automanager/core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../data/model/response/rentals/rental_model.dart';
import '../../repository/automanager_repository.dart';

class DeleteRental implements UseCase<Rental, String>{
  DeleteRental({required this.autoManagerRepository});
  final AutoManagerRepository autoManagerRepository;
  @override
  Future<Either<Failure, Rental>> call(String id) {
   return autoManagerRepository.deleteRental(rentalId: id);
  }

}