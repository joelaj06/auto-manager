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
}