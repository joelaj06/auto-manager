import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../data/model/model.dart';
import '../../repository/automanager_repository.dart';

class RecordWorkAndPayPayment
    implements UseCase<WorkAndPayPayment, RecordWorkAndPayPaymentRequest> {
  RecordWorkAndPayPayment({required this.autoManagerRepository});
  final AutoManagerRepository autoManagerRepository;

  @override
  Future<Either<Failure, WorkAndPayPayment>> call(
      RecordWorkAndPayPaymentRequest request) async {
    return autoManagerRepository.recordWorkAndPayPayment(request: request);
  }
}


