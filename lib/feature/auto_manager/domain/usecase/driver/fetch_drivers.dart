import 'package:automanager/core/core.dart';
import 'package:automanager/feature/auto_manager/data/data.dart';
import 'package:dartz/dartz.dart';

import '../../repository/automanager_repository.dart';

class FetchDrivers implements UseCase<ListPage<Driver>,PageParams>{

  FetchDrivers({required this.autoManagerRepository});
  final AutoManagerRepository autoManagerRepository;
  @override
  Future<Either<Failure, ListPage<Driver>>> call(PageParams params) async {
    return autoManagerRepository.fetchDrivers(
      pageIndex: params.pageIndex!,
      pageSize: params.pageSize!,
      query: params.query,
    );
  }
}