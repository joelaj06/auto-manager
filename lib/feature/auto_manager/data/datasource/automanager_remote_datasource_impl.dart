import 'package:automanager/core/core.dart';
import 'package:automanager/feature/auto_manager/data/data.dart';

class AutoMangerRemoteDatasourceImpl implements AutoManagerRemoteDatasource {
  AutoMangerRemoteDatasourceImpl({required AppHTTPClient client})
      : _client = client;

  final AppHTTPClient _client;

  @override
  Future<Company> addCompany(Company company) async {
    final Map<String, dynamic> json = await _client
        .post(AutoManagerEndpoints.companies, body: company.toJson());
    return Company.fromJson(json);
  }

  @override
  Future<DashboardSummary> dashboardSummary(
      {required String startDate,
      required String endDate,
      required String companyId}) async {
    final Map<String, dynamic> json = await _client.get(
        AutoManagerEndpoints.dashboardSummary(
            startDate: startDate, endDate: endDate, companyId: companyId));
    return DashboardSummary.fromJson(json);
  }

  @override
  Future<MonthlySales> monthlySales(
      {required String companyId,
      required int year,
      required int month}) async {
    final Map<String, dynamic> json = await _client.get(
        AutoManagerEndpoints.monthlySales(
            companyId: companyId, year: year, month: month));
    return MonthlySales.fromJson(json);
  }

  @override
  Future<Company> fetchCompany(String companyId) async {
    final Map<String, dynamic> json =
        await _client.get(AutoManagerEndpoints.company(companyId));
    return Company.fromJson(json);
  }

  @override
  Future<ListPage<Sale>> fetchSales(
      {required int pageIndex,
      required int pageSize,
      required String? startDate,
      required String? endDate,
      required String? driverId,
      required String? status,
      required String? query}) async {
    final Map<String, dynamic> json = await _client.get(
      FilterParams.salesParams(
          AutoManagerEndpoints.salesList(
              pageIndex: pageIndex,
              pageSize: pageSize,
              startDate: startDate,
              endDate: endDate),
          driverId,
          query,
          status),
    );
    final List<dynamic> items = json['items'] as List<dynamic>;
    final List<Sale> sales =
        items.map((dynamic sale) => Sale.fromJson(sale)).toList();
    final int total = json['totalCount'] as int;
    final Map<String, dynamic> metaData =
        json['meta'] as Map<String, dynamic>;
    return ListPage<Sale>(
        itemList: sales, grandTotalCount: total, metaData: metaData,
    );
  }
}
