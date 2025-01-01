import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../authentication/data/models/request/user/user_request.dart';
import '../../../authentication/data/models/response/user/permission_model.dart';
import '../../../authentication/data/models/response/user/role_model.dart';
import '../../../authentication/data/models/response/user/user_model.dart';
import '../../data/model/model.dart';

abstract interface class AutoManagerRepository {
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
    required String? vehicleId,
    required String? status,
    required String? query,
  });

  Future<Either<Failure, Sale>> addSale(
      {required AddSaleRequest addSaleRequest});

  Future<Either<Failure, Sale>> deleteSale({required String saleId});

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
    required String? vehicleId,
  });

  Future<Either<Failure, List<ExpenseCategory>>> fetchExpenseCategories();

  Future<Either<Failure, Expense>> addExpense(
      {required AddExpenseRequest addExpenseRequest});

  Future<Either<Failure, Expense>> deleteExpense({required String expenseId});

  Future<Either<Failure, Expense>> updateExpense(
      {required UpdateExpenseRequest updateExpenseRequest});

  Future<Either<Failure, ListPage<Rental>>> fetchRentals({
    required int pageIndex,
    required int pageSize,
    required String? startDate,
    required String? endDate,
    required String? query,
    required String? customerId,
    required String? vehicleId,
  });

  Future<Either<Failure, Rental>> addRental(
      {required RentalRequest addRentalRequest});

  Future<Either<Failure, Rental>> deleteRental({required String rentalId});

  Future<Either<Failure, Rental>> updateRental(
      {required RentalRequest updateRentalRequest});

  Future<Either<Failure, ListPage<Customer>>> fetchCustomers({
    required int pageIndex,
    required int pageSize,
    required String? query,
  });

  Future<Either<Failure, Rental>> extendRental(
      {required ExtendRentalRequest extendRentalRequest});

  Future<Either<Failure, User>> fetchUser({required String userId});

  Future<Either<Failure, User>> updateUser({required UserRequest userRequest});

  Future<Either<Failure, Company>> updateCompany({
    required Company companyRequest,
  });

  Future<Either<Failure, Driver>> deleteDriver({required String driverId});

  Future<Either<Failure, User>> addUser({required UserRequest userRequest});

  Future<Either<Failure, Customer>> addCustomer(
      {required CustomerRequest customerRequest});

  Future<Either<Failure, Customer>> deleteCustomer(
      {required String customerId});

  Future<Either<Failure, Customer>> updateCustomer({
    required CustomerRequest customerRequest,
  });

  Future<Either<Failure, Vehicle>> addVehicle(
      {required VehicleRequest vehicleRequest});

  Future<Either<Failure, Vehicle>> updateVehicle(
      {required VehicleRequest vehicleRequest});

  Future<Either<Failure, Vehicle>> deleteVehicle({required String vehicleId});

  Future<Either<Failure, User>> deleteUser({required String userId});

  Future<Either<Failure, ListPage<User>>> fetchUsers({
    required int pageIndex,
    required int pageSize,
    required String? query,
  });

  Future<Either<Failure, Rental>> removeExtension(
      {required String rentalId,
      required RemoveExtensionRequest removeExtensionRequest});

  Future<Either<Failure, List<Role>>> fetchRoles();

  Future<Either<Failure, List<UserPermission>>> fetchPermissions();

  Future<Either<Failure, Role>> updateRole(
      {required RoleRequest roleRequest});

  Future<Either<Failure, Role>> addRole({required RoleRequest roleRequest});
}
