class AutoManagerEndpoints {
  static const String companies = 'companies';

  static String dashboardSummary(
          {required String startDate,
          required String endDate,
          required String companyId}) =>
      'dashboard/dashboardSummary?startDate=$startDate&endDate='
      '$endDate&companyId=$companyId';

  static String monthlySales({
    required String companyId,
    required int year,
    required int month,
  }) =>
      'dashboard/monthlySales?month=$month&year=$year&company=$companyId';

  static String company(String companyId) => 'companies/$companyId';

  static const String sales = 'sales';
  static String sale(String saleId) => 'sales/$saleId';
  static String salesList({
    required int pageIndex,
    required int pageSize,
    required String? startDate,
    required String? endDate,
  }) =>
      'sales?pageIndex=$pageIndex&pageSize=$pageSize&startDate=$startDate&endDate=$endDate';

  static const String drivers = 'drivers';
  static String driver(String driverId) => 'drivers/$driverId';
  static String driversList({
    required int pageIndex,
    required int pageSize,
    required String? query,
  }) =>
      'drivers?pageIndex=$pageIndex&pageSize=$pageSize&query=$query';

  static const String vehicles = 'vehicles';

  static String vehicle(String vehicleId) => 'vehicles/$vehicleId';

  static String vehiclesList({
    required int pageIndex,
    required int pageSize,
    required String? query,
  }) =>
      'vehicles?pageIndex=$pageIndex&pageSize=$pageSize&search=$query';

  static String expenseList({
    required int pageIndex,
    required int pageSize,
    required String? startDate,
    required String? endDate,
    required String? categoryId,
  }) => 'expenses?pageIndex=$pageIndex&pageSize=$pageSize&startDate=$startDate&endDate=$endDate';

  static String expense(String expenseId) => 'expenses/$expenseId';

  static const String expenses = 'expenses';

  static const String expenseCategories = 'expense/expenseCategories';

  static const String rentals = 'rentals';

  static String rental(String rentalId) => 'rentals/$rentalId';

  static String extendRental(String rentalId) => 'rentals/$rentalId/extend';

  static String rentalList({
    required int pageIndex,
    required int pageSize,
    required String? startDate,
    required String? endDate,
  }) => 'rentals?pageIndex=$pageIndex&pageSize=$pageSize&startDate='
      '$startDate&endDate=$endDate';

  static const String customers = 'customers';

  static String customer(String customerId) => 'customers/$customerId';

  static String customerList({
    required int pageIndex,
    required int pageSize,
  }) => 'customers?pageIndex=$pageIndex&pageSize=$pageSize';


  static String user(String userId) => 'users/$userId';

  static const String users = 'users';

  static  String usersList({
    required int pageIndex,
    required int pageSize,
  }) => 'users?pageIndex=$pageIndex&pageSize=$pageSize';



}



class FilterParams{

  static String userParams(
      String endpoint,
      final String? search){

    String allParams = '';
    if(search != null && search.isNotEmpty){
      allParams = '$allParams&search=$search';
    }
    endpoint += allParams;
    return endpoint;
  }

  static String customerParams(
      String endpoint,
      final String? search,
      ){
    String allParams = '';
    if(search != null && search.isNotEmpty){
      allParams = '$allParams&search=$search';
    }
    endpoint += allParams;

    return endpoint;
  }

  static String rentalParams(
      String endpoint,
      final String? search,
      final String? vehicleId,
      final String? customerId,
      ){

    String allParams = '';
    if(search != null && search.isNotEmpty){
      allParams = '$allParams&search=$search';
    }
    if(vehicleId != null && vehicleId.isNotEmpty){
      allParams = '$allParams&vehicleId=$vehicleId';
    }
    if(customerId != null && customerId.isNotEmpty){
      allParams = '$allParams&renter=$customerId';
    }

    endpoint += allParams;

    return endpoint;

      }


  static String expenseParams(
      String endpoint,
      final String? categoryId
      ){
        String allParams = '';

        if(categoryId != null && categoryId.isNotEmpty){
          allParams = '$allParams&categoryId=$categoryId';
        }

        endpoint += allParams;

        return endpoint;
      }
 static String salesParams(
      String endpoint,
      final String? driverId,
      final String? search,
      final String? status
      ){
   String allParams = '';

   if(driverId != null && driverId.isNotEmpty){
     allParams = '$allParams&driverId=$driverId';
   }
   if(search != null && search.isNotEmpty){
     allParams = '$allParams&search=$search';
   }
   if(status != null && status.isNotEmpty){
     allParams = '$allParams&status=$status';
   }

   endpoint += allParams;

   return endpoint;
  }
}
