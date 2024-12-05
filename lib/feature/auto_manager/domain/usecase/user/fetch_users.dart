import 'package:automanager/core/core.dart';
import 'package:automanager/feature/authentication/data/data.dart';
import 'package:automanager/feature/auto_manager/data/data.dart';
import 'package:automanager/feature/auto_manager/domain/domain.dart';
import 'package:dartz/dartz.dart';

class FetchUsers implements UseCase<ListPage<User>, PageParams> {
  FetchUsers({required this.autoManagerRepository});

  final AutoManagerRepository autoManagerRepository;

  @override
  Future<Either<Failure, ListPage<User>>> call(PageParams params) {
    return autoManagerRepository.fetchUsers(
        pageIndex: params.pageIndex!,
        pageSize: params.pageSize!,
        query: params.query);
  }
}
