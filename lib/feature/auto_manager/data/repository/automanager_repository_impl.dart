import 'package:automanager/core/errors/failure.dart';
import 'package:automanager/feature/authentication/data/models/request/user/user_request.dart';
import 'package:automanager/feature/authentication/data/models/response/user/user_model.dart';

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
  Future<Either<Failure, ListPage<Sale>>> fetchSales({required int pageIndex,
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

  @override
  Future<Either<Failure, List<ExpenseCategory>>> fetchExpenseCategories() {
    return makeRequest(autoManagerRemoteDataSource.fetchExpenseCategories());
  }

  @override
  Future<Either<Failure, Expense>> addExpense(
      {required AddExpenseRequest addExpenseRequest}) {
    return makeRequest(autoManagerRemoteDataSource.addExpense(
        addExpenseRequest: addExpenseRequest));
  }

  @override
  Future<Either<Failure, Sale>> deleteSale({required String saleId}) {
    return makeRequest(autoManagerRemoteDataSource.deleteSale(saleId: saleId));
  }

  @override
  Future<Either<Failure, Expense>> deleteExpense({required String expenseId}) {
    return makeRequest(
        autoManagerRemoteDataSource.deleteExpense(expenseId: expenseId));
  }

  @override
  Future<Either<Failure, Expense>> updateExpense(
      {required UpdateExpenseRequest updateExpenseRequest}) {
    return makeRequest(
      autoManagerRemoteDataSource.updateExpense(
        expenseId: updateExpenseRequest.id,
        updateExpenseRequest: updateExpenseRequest,
      ),
    );
  }

  @override
  Future<Either<Failure, ListPage<Rental>>> fetchRentals(
      {required int pageIndex,
        required int pageSize,
        required String? startDate,
        required String? endDate,
        required String? query,
        required String? customerId,
        required String? vehicleId}) {
    return makeRequest(autoManagerRemoteDataSource.fetchRentals(
      pageIndex: pageIndex,
      pageSize: pageSize,
      startDate: startDate,
      endDate: endDate,
      query: query,
      customerId: customerId,
      vehicleId: vehicleId,
    ));
  }

  @override
  Future<Either<Failure, Rental>> addRental({
    required RentalRequest addRentalRequest,
  }) {
    return makeRequest(autoManagerRemoteDataSource.addRental(
      addRentalRequest: addRentalRequest,
    ));
  }

  @override
  Future<Either<Failure, Rental>> deleteRental({
    required String rentalId,
  }) {
    return makeRequest(autoManagerRemoteDataSource.deleteRental(
      rentalId: rentalId,
    ));
  }

  @override
  Future<Either<Failure, Rental>> updateRental({
    required RentalRequest updateRentalRequest,
  }) {
    return makeRequest(autoManagerRemoteDataSource.updateRental(
      rentalId: updateRentalRequest.id!,
      updateRentalRequest: updateRentalRequest,
    ));
  }

  @override
  Future<Either<Failure, ListPage<Customer>>> fetchCustomers(
      {required int pageIndex, required int pageSize, required String? query}) {
    return makeRequest(autoManagerRemoteDataSource.fetchCustomers(
      pageIndex: pageIndex,
      pageSize: pageSize,
      query: query,
    ));
  }

  @override
  Future<Either<Failure, Rental>> extendRental(
      {required ExtendRentalRequest extendRentalRequest}) {
    return makeRequest(autoManagerRemoteDataSource.extendRental(
      rentalId: extendRentalRequest.id!,
      extendRentalRequest: extendRentalRequest,
    ));
  }

  @override
  Future<Either<Failure, User>> fetchUser({required String userId}) {
    return makeRequest(autoManagerRemoteDataSource.fetchUser(userId));
  }

  @override
  Future<Either<Failure, User>> updateUser({required UserRequest userRequest}) {
    return makeRequest(autoManagerRemoteDataSource.updateUser(
      updateUserRequest: userRequest,
      userId: userRequest.id!,
    ));
  }

  @override
  Future<Either<Failure, Company>> updateCompany(
      {required Company companyRequest}) {
    return makeRequest(
      autoManagerRemoteDataSource.updateCompany(
        updateCompanyRequest: companyRequest,
        companyId: companyRequest.id!,
      ),
    );
  }

  @override
  Future<Either<Failure, Driver>> deleteDriver({required String driverId}) {
    return makeRequest(autoManagerRemoteDataSource.deleteDriver(
      driverId: driverId,
    ));
  }

  @override
  Future<Either<Failure, User>> addUser({required UserRequest userRequest}) {
    return makeRequest(autoManagerRemoteDataSource.addUser(
      userRequest: userRequest,
    ));
  }

  @override
  Future<Either<Failure, Customer>> addCustomer(
      {required CustomerRequest customerRequest}) {
    return makeRequest(autoManagerRemoteDataSource.addCustomer(
      customerRequest: customerRequest,
    ));
  }

  @override
  Future<Either<Failure, Customer>> deleteCustomer(
      {required String customerId}) {
    return makeRequest(autoManagerRemoteDataSource.deleteCustomer(
      customerId: customerId,
    ));
  }

  @override
  Future<Either<Failure, Customer>> updateCustomer({
    required CustomerRequest customerRequest,
  }) {
    return makeRequest(autoManagerRemoteDataSource.updateCustomer(
      updateCustomerRequest: customerRequest,
      customerId: customerRequest.id!,
    ));
  }

  @override
  Future<Either<Failure, Vehicle>> addVehicle(
      {required VehicleRequest vehicleRequest}) {
    return makeRequest(autoManagerRemoteDataSource.addVehicle(
      vehicleRequest: vehicleRequest,
    ));
  }

  @override
  Future<Either<Failure, Vehicle>> deleteVehicle({required String vehicleId}) {
    return makeRequest(autoManagerRemoteDataSource.deleteVehicle(
      vehicleId: vehicleId,
    ));
  }

  @override
  Future<Either<Failure, Vehicle>> updateVehicle(
      {required VehicleRequest vehicleRequest}) {
    return makeRequest(autoManagerRemoteDataSource.updateVehicle(
      vehicleRequest: vehicleRequest,
      vehicleId: vehicleRequest.id!,
    ));
  }

  @override
  Future<Either<Failure, User>> deleteUser({required String userId}) {
    return makeRequest(autoManagerRemoteDataSource.deleteUser(
      userId: userId,
    ));
  }

  @override
  Future<Either<Failure, ListPage<User>>> fetchUsers(
      {required int pageIndex, required int pageSize, required String? query}) {
    return makeRequest(autoManagerRemoteDataSource.fetchUsers(
      pageIndex: pageIndex,
      pageSize: pageSize,
      query: query,
    ));
  }

  @override
  Future<Either<Failure, Rental>> removeExtension(
      {required String rentalId, required RemoveExtensionRequest removeExtensionRequest}) {
    return makeRequest(autoManagerRemoteDataSource.removeExtension(
      rentalId: rentalId, removeExtensionRequest: removeExtensionRequest,),);
  }
}
