import 'package:automanager/core/core.dart';
import 'package:automanager/feature/auto_manager/data/data.dart';
import 'package:dartz/dartz.dart';

import '../../repository/automanager_repository.dart';

class FetchRentals implements UseCase<ListPage<Rental>, PageParams>{

  FetchRentals({required this.autoManagerRepository});

  final AutoManagerRepository autoManagerRepository;
  @override
  Future<Either<Failure, ListPage<Rental>>> call(PageParams params) {
    return autoManagerRepository.fetchRentals(
      pageIndex: params.pageIndex!,
      pageSize: params.pageSize!,
      startDate: params.startDate,
      endDate: params.endDate,
      customerId: params.customerId,
      vehicleId: params.vehicleId,
      query: params.query,
    );
  }

}