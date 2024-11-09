import 'package:automanager/core/core.dart';
import 'package:automanager/feature/auto_manager/data/data.dart';
import 'package:dartz/dartz.dart';

import '../../repository/automanager_repository.dart';

class FetchVehicles implements UseCase<ListPage<Vehicle>, PageParams> {
  FetchVehicles({required this.autoManagerRepository});

  final AutoManagerRepository autoManagerRepository;

  @override
  Future<Either<Failure, ListPage<Vehicle>>> call(PageParams params) async {
    return autoManagerRepository.fetchVehicles(
      pageIndex: params.pageIndex!,
      pageSize: params.pageSize!,
      query: params.query,
    );
  }
}
