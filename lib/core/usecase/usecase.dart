import 'package:dartz/dartz.dart';
import '../errors/failure.dart';

abstract interface class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}

class PageParams {
  const PageParams({
     this.pageIndex,
     this.pageSize,
    this.query,
    this.startDate,
    this.endDate,
    this.userId,
    this.search,
    this.companyId,
    this.year,
    this.month,
    this.driverId,
    this.status,
    this.categoryId,
    this.customerId,
    this.vehicleId,
  });

  final int? pageIndex;
  final int? pageSize;
  final String? query;
  final String? startDate;
  final String? endDate;
  final String? userId;
  final String? search;
  final String? companyId;
  final String? driverId;
  final int? year;
  final int? month;
  final String? status;
  final String? categoryId;
  final String? customerId;
  final String? vehicleId;

}
