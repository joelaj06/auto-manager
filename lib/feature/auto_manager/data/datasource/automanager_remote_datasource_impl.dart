import 'package:automanager/feature/authentication/data/models/request/user/user_request.dart';
import 'package:automanager/feature/authentication/data/models/response/user/permission_model.dart';
import 'package:automanager/feature/authentication/data/models/response/user/role_model.dart';
import 'package:automanager/feature/authentication/data/models/response/user/user_model.dart';
import 'package:automanager/feature/auto_manager/data/data.dart';

import '../../../../core/utils/app_http_client.dart';

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
      required String? vehicleId,
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
          status,
          vehicleId),
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
    required String? vehicleId,
  }) async {
    final Map<String, dynamic> json = await _client.get(
      FilterParams.expenseParams(
        AutoManagerEndpoints.expenseList(
            pageIndex: pageIndex,
            pageSize: pageSize,
            startDate: startDate,
            endDate: endDate,
            categoryId: categoryId),
        categoryId,
        vehicleId,
      ),
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

  @override
  Future<ListPage<Rental>> fetchRentals({
    required int pageIndex,
    required int pageSize,
    required String? startDate,
    required String? endDate,
    required String? query,
    required String? customerId,
    required String? vehicleId,
  }) async {
    final Map<String, dynamic> json = await _client.get(
      FilterParams.rentalParams(
        AutoManagerEndpoints.rentalList(
          pageIndex: pageIndex,
          pageSize: pageSize,
          startDate: startDate,
          endDate: endDate,
        ),
        query,
        vehicleId,
        customerId,
      ),
    );

    final List<dynamic> items = json['items'] as List<dynamic>;
    final List<Rental> rentals =
        items.map((dynamic rental) => Rental.fromJson(rental)).toList();
    final int total = json['totalCount'] as int;
    final Map<String, dynamic> metaData = json['meta'] as Map<String, dynamic>;
    return ListPage<Rental>(
      itemList: rentals,
      grandTotalCount: total,
      metaData: metaData,
    );
  }

  @override
  Future<Rental> addRental({required RentalRequest addRentalRequest}) async {
    final Map<String, dynamic> json = await _client
        .post(AutoManagerEndpoints.rentals, body: addRentalRequest.toJson());
    return Rental.fromJson(json);
  }

  @override
  Future<Rental> deleteRental({required String rentalId}) async {
    await _client.delete(AutoManagerEndpoints.rental(rentalId));
    return Rental.empty();
  }

  @override
  Future<Rental> updateRental(
      {required String rentalId,
      required RentalRequest updateRentalRequest}) async {
    final Map<String, dynamic> json = await _client.put(
        AutoManagerEndpoints.rental(rentalId),
        body: updateRentalRequest.toJson());
    return Rental.fromJson(json);
  }

  @override
  Future<ListPage<Customer>> fetchCustomers(
      {required int pageIndex,
      required int pageSize,
      required String? query}) async {
    final Map<String, dynamic> json = await _client.get(
      FilterParams.customerParams(
          AutoManagerEndpoints.customerList(
              pageIndex: pageIndex, pageSize: pageSize),
          query),
    );
    final List<dynamic> items = json['items'] as List<dynamic>;
    final List<Customer> customers =
        items.map((dynamic customer) => Customer.fromJson(customer)).toList();
    final int total = json['totalCount'] as int;
    final Map<String, dynamic> metaData = json['meta'] as Map<String, dynamic>;
    return ListPage<Customer>(
      itemList: customers,
      grandTotalCount: total,
      metaData: metaData,
    );
  }

  @override
  Future<Rental> extendRental(
      {required String rentalId,
      required ExtendRentalRequest extendRentalRequest}) async {
    final Map<String, dynamic> json = await _client.put(
        AutoManagerEndpoints.extendRental(rentalId),
        body: extendRentalRequest.toJson());
    return Rental.fromJson(json);
  }

  @override
  Future<User> fetchUser(String userId) async {
    final Map<String, dynamic> json = await _client.get(
      AutoManagerEndpoints.user(userId),
    );
    return User.fromJson(json);
  }

  @override
  Future<User> updateUser(
      {required UserRequest updateUserRequest, required String userId}) async {
    final Map<String, dynamic> json = await _client.put(
      AutoManagerEndpoints.user(userId),
      body: updateUserRequest.toJson(),
    );
    return User.fromJson(json);
  }

  @override
  Future<Company> updateCompany({
    required Company updateCompanyRequest,
    required String companyId,
  }) async {
    final Map<String, dynamic> json = await _client.put(
      AutoManagerEndpoints.company(companyId),
      body: updateCompanyRequest.toJson(),
    );
    return Company.fromJson(json);
  }

  @override
  Future<Driver> deleteDriver({required String driverId}) async {
    await _client.delete(AutoManagerEndpoints.driver(driverId));
    return Driver.empty();
  }

  @override
  Future<User> addUser({required UserRequest userRequest}) async {
    final Map<String, dynamic> json = await _client.post(
      AutoManagerEndpoints.users,
      body: userRequest.toJson(),
    );
    return User.fromJson(json);
  }

  @override
  Future<Customer> addCustomer(
      {required CustomerRequest customerRequest}) async {
    final Map<String, dynamic> json = await _client.post(
      AutoManagerEndpoints.customers,
      body: customerRequest.toJson(),
    );
    return Customer.fromJson(json);
  }

  @override
  Future<Customer> deleteCustomer({required String customerId}) async {
    await _client.delete(AutoManagerEndpoints.customer(customerId));
    return Customer.empty();
  }

  @override
  Future<Customer> updateCustomer(
      {required CustomerRequest updateCustomerRequest,
      required String customerId}) async {
    final Map<String, dynamic> json = await _client.put(
      AutoManagerEndpoints.customer(customerId),
      body: updateCustomerRequest.toJson(),
    );
    return Customer.fromJson(json);
  }

  @override
  Future<Vehicle> addVehicle({required VehicleRequest vehicleRequest}) async {
    final Map<String, dynamic> json = await _client.post(
      AutoManagerEndpoints.vehicles,
      body: vehicleRequest.toJson(),
    );
    return Vehicle.fromJson(json);
  }

  @override
  Future<Vehicle> deleteVehicle({required String vehicleId}) async {
    await _client.delete(AutoManagerEndpoints.vehicle(vehicleId));
    return Vehicle.empty();
  }

  @override
  Future<Vehicle> updateVehicle(
      {required VehicleRequest vehicleRequest,
      required String vehicleId}) async {
    final Map<String, dynamic> json = await _client.put(
      AutoManagerEndpoints.vehicle(vehicleId),
      body: vehicleRequest.toJson(),
    );
    return Vehicle.fromJson(json);
  }

  @override
  Future<User> deleteUser({required String userId}) async {
    await _client.delete(AutoManagerEndpoints.user(userId));
    return User.empty();
  }

  @override
  Future<ListPage<User>> fetchUsers(
      {required int pageIndex,
      required int pageSize,
      required String? query}) async {
    final Map<String, dynamic> json = await _client.get(
      FilterParams.userParams(
          AutoManagerEndpoints.usersList(
              pageIndex: pageIndex, pageSize: pageSize),
          query),
    );
    final List<dynamic> items = json['items'] as List<dynamic>;
    final List<User> users =
        items.map((dynamic user) => User.fromJson(user)).toList();
    final int total = json['totalCount'] as int;
    final Map<String, dynamic> metaData = json['meta'] as Map<String, dynamic>;
    return ListPage<User>(
      itemList: users,
      grandTotalCount: total,
      metaData: metaData,
    );
  }

  @override
  Future<Rental> removeExtension(
      {required String rentalId,
      required RemoveExtensionRequest removeExtensionRequest}) async {
    final Map<String, dynamic> json = await _client.patch(
      AutoManagerEndpoints.removeExtension(
        rentalId,
      ),
      body: removeExtensionRequest.toJson(),
    );
    return Rental.fromJson(json);
  }

  @override
  Future<List<Role>> fetchRoles() async {
    final Map<String, dynamic> json =
        await _client.get(AutoManagerEndpoints.roles);
    final List<dynamic> items = json['items'] as List<dynamic>;
    final List<Role> roles =
        items.map((dynamic role) => Role.fromJson(role)).toList();
    return roles;
  }

  @override
  Future<List<UserPermission>> fetchPermissions() async {
    final Map<String, dynamic> json =
        await _client.get(AutoManagerEndpoints.permissions);
    final List<dynamic> items = json['items'] as List<dynamic>;
    final List<UserPermission> permissions = items
        .map((dynamic permission) => UserPermission.fromJson(permission))
        .toList();
    return permissions;
  }

  @override
  Future<Role> addRole({required RoleRequest roleRequest}) async {
    final Map<String, dynamic> json = await _client.post(
      AutoManagerEndpoints.roles,
      body: roleRequest.toJson(),
    );
    return Role.fromJson(json);
  }

  @override
  Future<Role> updateRole(
      {required RoleRequest roleRequest, required String roleId}) async {
    final Map<String, dynamic> json = await _client.put(
      AutoManagerEndpoints.role(roleId),
      body: roleRequest.toJson(),
    );
    return Role.fromJson(json);
  }
}
