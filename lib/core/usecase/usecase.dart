import 'package:dartz/dartz.dart';
import '../errors/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}

class PageParams {
  const PageParams({
    required this.page,
    required this.size,
    this.query,
    this.startDate,
    this.endDate,
    this.userId,
    this.search,
    this.company,
  });

  final int page;
  final int size;
  final String? query;
  final String? startDate;
  final String? endDate;
  final String? userId;
  final String? search;
  final String? company;

}
