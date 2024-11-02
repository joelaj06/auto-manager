import 'package:automanager/core/core.dart';
import 'package:automanager/feature/auto_manager/data/model/model.dart';
import 'package:dartz/dartz.dart';

import '../../repository/automanager_repository.dart';

class FetchDashboardSummaryData
    implements UseCase<DashboardSummary, PageParams> {

  FetchDashboardSummaryData({required this.autoManagerRepository});

  final AutoManagerRepository autoManagerRepository;

  @override
  Future<Either<Failure, DashboardSummary>> call(PageParams params) {
    return autoManagerRepository.fetchDashboardSummary(
      startDate: params.startDate!,
      endDate: params.endDate!,
      companyId: params.companyId!,
    );
  }
}