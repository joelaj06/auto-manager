import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../data/model/model.dart';
import '../../repository/automanager_repository.dart';

class FetchWorkAndPayAgreementByDriverId
    implements UseCase<WorkAndPayAgreement, String> {
  FetchWorkAndPayAgreementByDriverId({required this.autoManagerRepository});
  final AutoManagerRepository autoManagerRepository;

  @override
  Future<Either<Failure, WorkAndPayAgreement>> call(String driverId) async {
    return autoManagerRepository.fetchWorkAndPayAgreementByDriverId(
      driverId: driverId,
    );
  }
}
