import 'package:automanager/core/core.dart';
import 'package:automanager/feature/auto_manager/data/data.dart';
import 'package:dartz/dartz.dart';

import '../../repository/automanager_repository.dart';

class FetchSales implements UseCase<ListPage<Sale>, PageParams>{

  FetchSales({required this.autoManagerRepository});
  final AutoManagerRepository autoManagerRepository;
  @override
  Future<Either<Failure, ListPage<Sale>>> call(PageParams params) {
    return autoManagerRepository.fetchSales(
      pageIndex: params.pageIndex!,
      pageSize: params.pageSize!,
      startDate: params.startDate,
      endDate: params.endDate,
      driverId: params.driverId,
      vehicleId: params.vehicleId,
      status: params.status,
      query: params.query
    );
  }

}