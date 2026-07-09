import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../data/model/model.dart';
import '../../repository/automanager_repository.dart';

class InitiateWorkAndPayAgreement
    implements UseCase<WorkAndPayAgreement, InitiateWorkAndPayRequest> {
  InitiateWorkAndPayAgreement({required this.autoManagerRepository});
  final AutoManagerRepository autoManagerRepository;

  @override
  Future<Either<Failure, WorkAndPayAgreement>> call(
      InitiateWorkAndPayRequest request) async {
    return autoManagerRepository.initiateWorkAndPayAgreement(request: request);
  }
}


