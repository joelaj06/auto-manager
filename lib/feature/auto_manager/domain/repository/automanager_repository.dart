import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../data/model/model.dart';

abstract class AutoManagerRepository {
  Future<Either<Failure, Company>> addCompany(
      {required Company companyRequest});

  Future<Either<Failure, DashboardSummary>> fetchDashboardSummary(
      {required String startDate,
      required String endDate,
      required String companyId});

  Future<Either<Failure, MonthlySales>> fetchMonthlySales(
      {required String companyId, required int year, required int month});

  Future<Either<Failure, Company>> fetchCompany(String companyId);

  Future<Either<Failure, ListPage<Sale>>> fetchSales({
    required int pageIndex,
    required int pageSize,
    required String? startDate,
    required String? endDate,
    required String? driverId,
    required String? status,
    required String? query,
  });

  Future<Either<Failure, Sale>> addSale(
      {required AddSaleRequest addSaleRequest});

  Future<Either<Failure, ListPage<Driver>>> fetchDrivers({
    required int pageIndex,
    required int pageSize,
    required String? query,
  });

  Future<Either<Failure, ListPage<Vehicle>>> fetchVehicles({
    required int pageIndex,
    required int pageSize,
    required String? query,
  });

  Future<Either<Failure, ListPage<Expense>>> fetchExpenses({
    required int pageIndex,
    required int pageSize,
    required String? startDate,
    required String? endDate,
    required String? categoryId,
  });

  Future<Either<Failure, List<ExpenseCategory>>> fetchExpenseCategories();

  Future<Either<Failure, Expense>> addExpense(
      {required AddExpenseRequest addExpenseRequest});
}
