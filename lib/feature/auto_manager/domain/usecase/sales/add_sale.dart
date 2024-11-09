import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../data/model/model.dart';
import '../../repository/automanager_repository.dart';

class AddSale implements UseCase<Sale, AddSaleRequest> {
  AddSale({required this.autoManagerRepository});
  final AutoManagerRepository autoManagerRepository;

  @override
  Future<Either<Failure, Sale>> call(AddSaleRequest request) async {
    return  autoManagerRepository.addSale(addSaleRequest: request);
  }
}