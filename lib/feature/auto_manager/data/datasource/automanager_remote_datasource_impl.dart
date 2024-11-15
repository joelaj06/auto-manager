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
    final Map<String, dynamic> metaData = json['meta'] as Map<String, dynamic>;
    return ListPage<Sale>(
      itemList: sales,
      grandTotalCount: total,
      metaData: metaData,
    );
  }

  @override
  Future<Sale> addSale({required AddSaleRequest addSaleRequest}) async {
    final Map<String, dynamic> json = await _client
        .post(AutoManagerEndpoints.sales, body: addSaleRequest.toJson());
    return Sale.fromJson(json);
  }

  @override
  Future<ListPage<Driver>> fetchDrivers({
    required int pageIndex,
    required int pageSize,
    required String? query,
  }) async {
    final Map<String, dynamic> json =
        await _client.get(AutoManagerEndpoints.driversList(
      pageIndex: pageIndex,
      pageSize: pageSize,
      query: query,
    ));
    final List<dynamic> items = json['items'] as List<dynamic>;
    final List<Driver> drivers =
        items.map((dynamic driver) => Driver.fromJson(driver)).toList();
    final int total = json['totalCount'] as int;
    final Map<String, dynamic> metaData = json['meta'] as Map<String, dynamic>;
    return ListPage<Driver>(
      itemList: drivers,
      grandTotalCount: total,
      metaData: metaData,
    );
  }

  @override
  Future<ListPage<Vehicle>> fetchVehicles({
    required int pageIndex,
    required int pageSize,
    required String? query,
  }) async {
    final Map<String, dynamic> json = await _client.get(
      AutoManagerEndpoints.vehiclesList(
        pageIndex: pageIndex,
        pageSize: pageSize,
        query: query,
      ),
    );
    final List<dynamic> items = json['items'] as List<dynamic>;
    final List<Vehicle> vehicles =
        items.map((dynamic vehicle) => Vehicle.fromJson(vehicle)).toList();
    final int total = json['totalCount'] as int;
    final Map<String, dynamic> metaData = json['meta'] as Map<String, dynamic>;
    return ListPage<Vehicle>(
      itemList: vehicles,
      grandTotalCount: total,
      metaData: metaData,
    );
  }

  @override
  Future<ListPage<Expense>> fetchExpenses({
    required int pageIndex,
    required int pageSize,
    required String? startDate,
    required String? endDate,
    required String? categoryId,
  }) async {
    final Map<String, dynamic> json = await _client.get(
      FilterParams.expenseParams(
          AutoManagerEndpoints.expenseList(
              pageIndex: pageIndex,
              pageSize: pageSize,
              startDate: startDate,
              endDate: endDate,
              categoryId: categoryId),
          categoryId),
    );
    final List<dynamic> items = json['items'] as List<dynamic>;
    final List<Expense> expenses =
        items.map((dynamic expense) => Expense.fromJson(expense)).toList();
    final int total = json['totalCount'] as int;
    final Map<String, dynamic> metaData = json['meta'] as Map<String, dynamic>;
    return ListPage<Expense>(
      itemList: expenses,
      grandTotalCount: total,
      metaData: metaData,
    );
  }

  @override
  Future<List<ExpenseCategory>> fetchExpenseCategories() async {
    final Map<String, dynamic> json =
        await _client.get(AutoManagerEndpoints.expenseCategories);
    final List<dynamic> items = json['items'] as List<dynamic>;
    final List<ExpenseCategory> expenseCategories = items
        .map((dynamic category) => ExpenseCategory.fromJson(category))
        .toList();

    return expenseCategories;
  }

  @override
  Future<Expense> addExpense(
      {required AddExpenseRequest addExpenseRequest}) async {
    final Map<String, dynamic> json = await _client
        .post(AutoManagerEndpoints.expenses, body: addExpenseRequest.toJson());
    return Expense.fromJson(json);
  }

  @override
  Future<Sale> deleteSale({required String saleId}) async {
    await _client.delete(AutoManagerEndpoints.sale(saleId));
    return Sale.empty();
  }

  @override
  Future<Expense> deleteExpense({required String expenseId}) async {
   final json = await _client.delete(AutoManagerEndpoints.expense(expenseId));
    print(json);
   return Expense.empty();
  }

  @override
  Future<Expense> updateExpense(
      {required String expenseId,
      required UpdateExpenseRequest updateExpenseRequest}) async {
    final Map<String, dynamic> json = await _client.put(
        AutoManagerEndpoints.expense(expenseId),
        body: updateExpenseRequest.toJson());
    return Expense.fromJson(json);
  }
}
