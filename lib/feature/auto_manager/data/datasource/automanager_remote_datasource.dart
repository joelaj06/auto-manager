import '../model/model.dart';

abstract class AutoManagerRemoteDatasource {
  Future<Company> addCompany(Company company);

  Future<DashboardSummary> dashboardSummary(
      {required String startDate,
      required String endDate,
      required String companyId});

  Future<MonthlySales> monthlySales(
      {required String companyId, required int year, required int month});
}
