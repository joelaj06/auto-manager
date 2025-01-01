import '../../../authentication/data/models/models.dart';
import '../model/model.dart';

abstract interface class AutoManagerRemoteDatasource {
  Future<Company> addCompany(Company company);

  Future<DashboardSummary> dashboardSummary(
      {required String startDate,
      required String endDate,
      required String companyId});

  Future<MonthlySales> monthlySales(
      {required String companyId, required int year, required int month});

  Future<Company> fetchCompany(String companyId);

  Future<ListPage<Sale>> fetchSales({
    required int pageIndex,
    required int pageSize,
    required String? startDate,
    required String? endDate,
    required String? driverId,
    required String? vehicleId,
    required String? status,
    required String? query,
  });

  Future<Sale> addSale({required AddSaleRequest addSaleRequest});

  Future<Sale> deleteSale({required String saleId});

  Future<ListPage<Driver>> fetchDrivers({
    required int pageIndex,
    required int pageSize,
    required String? query,
  });

  Future<ListPage<Vehicle>> fetchVehicles({
    required int pageIndex,
    required int pageSize,
    required String? query,
  });

  Future<ListPage<Expense>> fetchExpenses({
    required int pageIndex,
    required int pageSize,
    required String? startDate,
    required String? endDate,
    required String? categoryId,
    required String? vehicleId,
  });

  Future<List<ExpenseCategory>> fetchExpenseCategories();

  Future<Expense> addExpense({required AddExpenseRequest addExpenseRequest});

  Future<Expense> deleteExpense({required String expenseId});

  Future<Expense> updateExpense(
      {required String expenseId,
      required UpdateExpenseRequest updateExpenseRequest});

  Future<ListPage<Rental>> fetchRentals({
    required int pageIndex,
    required int pageSize,
    required String? startDate,
    required String? endDate,
    required String? query,
    required String? customerId,
    required String? vehicleId,
  });

  Future<Rental> addRental({required RentalRequest addRentalRequest});

  Future<Rental> updateRental(
      {required String rentalId, required RentalRequest updateRentalRequest});

  Future<Rental> deleteRental({required String rentalId});

  Future<ListPage<Customer>> fetchCustomers({
    required int pageIndex,
    required int pageSize,
    required String? query,
  });

  Future<Rental> extendRental(
      {required String rentalId,
      required ExtendRentalRequest extendRentalRequest});

  Future<User> fetchUser(String userId);

  Future<ListPage<User>> fetchUsers({
    required int pageIndex,
    required int pageSize,
    required String? query,
  });

  Future<User> deleteUser({required String userId});

  Future<User> updateUser({
    required UserRequest updateUserRequest,
    required String userId,
  });

  Future<User> addUser({required UserRequest userRequest});

  Future<Company> updateCompany({
    required Company updateCompanyRequest,
    required String companyId,
  });

  Future<Driver> deleteDriver({required String driverId});

  Future<Customer> addCustomer({required CustomerRequest customerRequest});

  Future<Customer> updateCustomer({
    required CustomerRequest updateCustomerRequest,
    required String customerId,
  });

  Future<Customer> deleteCustomer({required String customerId});

  Future<Vehicle> deleteVehicle({required String vehicleId});

  Future<Vehicle> addVehicle({required VehicleRequest vehicleRequest});

  Future<Vehicle> updateVehicle(
      {required VehicleRequest vehicleRequest, required String vehicleId});

  Future<Rental> removeExtension(
      {required String rentalId,
      required RemoveExtensionRequest removeExtensionRequest});

  Future<List<Role>> fetchRoles();

  Future<Role> updateRole(
      {required RoleRequest roleRequest, required String roleId});

  Future<Role> addRole({required RoleRequest roleRequest});

  Future<List<UserPermission>> fetchPermissions();
}
