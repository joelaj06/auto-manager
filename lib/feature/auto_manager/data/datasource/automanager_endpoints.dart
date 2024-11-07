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
}

class FilterParams{
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
