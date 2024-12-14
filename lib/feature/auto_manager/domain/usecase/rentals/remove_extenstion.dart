import 'package:automanager/feature/auto_manager/data/data.dart';
import 'package:automanager/feature/auto_manager/domain/domain.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/usecase/usecase.dart';

class RemoveExtension implements UseCase<Rental,RemoveExtensionRequest> {
  RemoveExtension({required this.autoManagerRepository});

  final AutoManagerRepository autoManagerRepository;

  @override
  Future<Either<Failure, Rental>> call(
      RemoveExtensionRequest request) {
    return autoManagerRepository.removeExtension(
      rentalId: request.rentalId,
      removeExtensionRequest: request,
    );
  }
}
