import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../data/model/model.dart';
import '../../repository/automanager_repository.dart';

class FetchWorkAndPayPayments
    implements UseCase<List<WorkAndPayPayment>, String> {
  FetchWorkAndPayPayments({required this.autoManagerRepository});
  final AutoManagerRepository autoManagerRepository;

  @override
  Future<Either<Failure, List<WorkAndPayPayment>>> call(
      String agreementId) async {
    return autoManagerRepository.fetchWorkAndPayPayments(
      agreementId: agreementId,
    );
  }
}


