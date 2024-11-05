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

}
