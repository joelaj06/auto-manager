import 'package:automanager/core/core.dart';
import 'package:automanager/feature/auto_manager/data/data.dart';
import 'package:dartz/dartz.dart';

import '../../repository/automanager_repository.dart';

class FetchExpenses implements UseCase<ListPage<Expense>, PageParams> {
  FetchExpenses({required this.autoManagerRepository});
  final AutoManagerRepository autoManagerRepository;
  @override
  Future<Either<Failure, ListPage<Expense>>> call(PageParams params) {
    return autoManagerRepository.fetchExpenses(
      pageIndex: params.pageIndex!,
      pageSize: params.pageSize!,
      startDate: params.startDate,
      endDate: params.endDate,
      categoryId: params.categoryId,
      vehicleId: params.vehicleId,
    );
  }

}