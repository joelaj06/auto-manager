import 'package:automanager/core/errors/failure.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/utils/repository.dart';
import '../../domain/domain.dart';
import '../data.dart';

class AutoManagerRepositoryImpl extends Repository
    implements AutoManagerRepository {
  AutoManagerRepositoryImpl({required this.autoManagerRemoteDataSource});

  final AutoManagerRemoteDatasource autoManagerRemoteDataSource;

  @override
  Future<Either<Failure, Company>> addCompany(
      {required Company companyRequest}) {
    return makeRequest(autoManagerRemoteDataSource.addCompany(companyRequest));
  }

  @override
  Future<Either<Failure, DashboardSummary>> fetchDashboardSummary(
      {required String startDate,
      required String endDate,
      required String companyId}) {
    return makeRequest(autoManagerRemoteDataSource.dashboardSummary(
        startDate: startDate, endDate: endDate, companyId: companyId));

  }

  @override
  Future<Either<Failure, MonthlySales>> fetchMonthlySales(
      {required String companyId, required int year, required int month}) {
    return makeRequest(autoManagerRemoteDataSource.monthlySales(
        companyId: companyId, year: year, month: month));
  }
}