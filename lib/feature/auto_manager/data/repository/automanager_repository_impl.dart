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

  @override
  Future<Either<Failure, Company>> fetchCompany(String companyId) {
    return makeRequest(autoManagerRemoteDataSource.fetchCompany(companyId));
  }

  @override
  Future<Either<Failure, ListPage<Sale>>> fetchSales(
      {required int pageIndex,
      required int pageSize,
      required String? startDate,
      required String? endDate,
      required String? driverId,
      required String? status,
      required String? query}) {
    return makeRequest(
      autoManagerRemoteDataSource.fetchSales(
        pageIndex: pageIndex,
        pageSize: pageSize,
        startDate: startDate,
        endDate: endDate,
        driverId: driverId,
        status: status,
        query: query,
      ),
    );
  }

  @override
  Future<Either<Failure, Sale>> addSale(
      {required AddSaleRequest addSaleRequest}) {
    return makeRequest(
        autoManagerRemoteDataSource.addSale(addSaleRequest: addSaleRequest));
  }

  @override
  Future<Either<Failure, ListPage<Driver>>> fetchDrivers({
    required int pageIndex,
    required int pageSize,
    required String? query,
  }) {
    return makeRequest(autoManagerRemoteDataSource.fetchDrivers(
      pageIndex: pageIndex,
      pageSize: pageSize,
      query: query,
    ));
  }

  @override
  Future<Either<Failure, ListPage<Vehicle>>> fetchVehicles({
    required int pageIndex,
    required int pageSize,
    required String? query,
  }) {
    return makeRequest(autoManagerRemoteDataSource.fetchVehicles(
      pageIndex: pageIndex,
      pageSize: pageSize,
      query: query,
    ));
  }

  @override
  Future<Either<Failure, ListPage<Expense>>> fetchExpenses(
      {required int pageIndex,
      required int pageSize,
      required String? startDate,
      required String? endDate,
      required String? categoryId}) {
    return makeRequest(autoManagerRemoteDataSource.fetchExpenses(
      pageIndex: pageIndex,
      pageSize: pageSize,
      startDate: startDate,
      endDate: endDate,
      categoryId: categoryId,
    ));
  }
}
