import 'package:automanager/core/core.dart';
import 'package:automanager/feature/auto_manager/data/data.dart';
import 'package:dartz/dartz.dart';

import '../../repository/automanager_repository.dart';

class FetchCustomers implements UseCase<ListPage<Customer>, PageParams> {
  FetchCustomers({required this.autoManagerRepository});

  final AutoManagerRepository autoManagerRepository;

  @override
  Future<Either<Failure, ListPage<Customer>>> call(PageParams params) {

    return autoManagerRepository.fetchCustomers(
        pageIndex: params.pageIndex!,
        pageSize: params.pageSize!,
        query: params.query,
    );
  }
}
