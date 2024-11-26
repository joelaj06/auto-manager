import '../../../authentication/data/models/request/user/user_request.dart';
import '../../../authentication/data/models/response/user/user_model.dart';
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

  Future<User> updateUser({required UserRequest updateUserRequest, required String userId});
}
