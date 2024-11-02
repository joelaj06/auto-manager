import 'package:automanager/core/core.dart';
import 'package:dartz/dartz.dart';

import '../../../data/model/model.dart';
import '../../repository/automanager_repository.dart';

class FetchMonthlySales implements UseCase<MonthlySales, PageParams>{

  FetchMonthlySales({required this.autoManagerRepository});

  final AutoManagerRepository autoManagerRepository;

  @override
  Future<Either<Failure, MonthlySales>> call(PageParams params) {
    return autoManagerRepository.fetchMonthlySales(
      companyId: params.companyId!,
      year: params.year!,
      month: params.month!,
    );
  }

}