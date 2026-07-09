import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../data/model/model.dart';
import '../../repository/automanager_repository.dart';

class FetchDriver implements UseCase<Driver, String> {
  FetchDriver({required this.autoManagerRepository});
  final AutoManagerRepository autoManagerRepository;

  @override
  Future<Either<Failure, Driver>> call(String driverId) async {
    return autoManagerRepository.fetchDriver(
      driverId: driverId,
    );
  }
}
