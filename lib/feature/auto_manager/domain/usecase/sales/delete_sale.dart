import 'package:automanager/core/core.dart';
import 'package:automanager/feature/auto_manager/data/data.dart';
import 'package:automanager/feature/auto_manager/domain/domain.dart';
import 'package:dartz/dartz.dart';

class DeleteSale implements UseCase<Sale, String>{
  DeleteSale({required this.autoManagerRepository});
  final AutoManagerRepository autoManagerRepository;
  @override
  Future<Either<Failure, Sale>> call(String id) {
    return autoManagerRepository.deleteSale(saleId: id);
  }

}