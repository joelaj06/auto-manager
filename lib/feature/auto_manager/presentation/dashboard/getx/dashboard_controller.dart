import 'package:automanager/core/core.dart';
import 'package:automanager/feature/authentication/domain/domain.dart';
import 'package:automanager/feature/auto_manager/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../authentication/data/models/models.dart';
import '../../../data/data.dart';

class DashboardController extends GetxController {
  DashboardController(
      {required this.fetchDashboardSummaryData,
      required this.fetchMonthlySales,
      required this.loadUser,
      required this.fetchCompany});

  final FetchDashboardSummaryData fetchDashboardSummaryData;
  final FetchMonthlySales fetchMonthlySales;
  final LoadUser loadUser;
  final FetchCompany fetchCompany;

  //reactive variables
  Rx<DashboardSummary> dashboardSummary = DashboardSummary.empty().obs;
  Rx<MonthlySales> monthlySales = MonthlySales.empty().obs;
  RxList<ChartData> salesForTheMonthData = <ChartData>[].obs;
  RxBool isDateFilter = false.obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxString dateText = 'This Month'.obs;
  Rx<DateTime> startDate =
      DateTime(DateTime.now().year, DateTime.now().month, 1).obs;
  Rx<DateTime> endDate = DateTime.now().obs;
  RxInt month = DateTime.now().month.obs;
  RxInt year = DateTime.now().year.obs;
  Rx<DateTime> selectedMonthYear = DateTime.now().obs;
  Rx<Company> company = Company.empty().obs;

  User loginResponse = User.empty();

  TooltipBehavior tooltipBehavior = TooltipBehavior();
  late ChartSeriesController<ChartData, num>? chartSeriesController;
  final SharedPreferencesWrapper sharedPreferencesWrapper = Get.find();

  @override
  void onInit() {
    tooltipBehavior = TooltipBehavior(
      enable: true,
      color: Get.theme.colorScheme.primary,
      opacity: 0.8,
    );
    clearRoute();
    loadDependencies();
    super.onInit();
  }

  @override
  void onClose() {
    chartSeriesController = null;
    super.onClose();
  }
  void loadDependencies() async {
    await loadUserData().then((_) {
      getCompany();
      getDashboardSummaryData();
      getMonthlySales();
    });
  }

  void getCompany() async {
    final Either<Failure, Company> failureOrCompany = await fetchCompany(
      PageParams(companyId: loginResponse.company),
    );
    failureOrCompany.fold((_) {}, (Company data){
      company(data);
    });
  }

  void onMonthSelected(BuildContext context) async {
    final DateTime? result = await AppDatePicker.showMonthYearPicker(context);
    if (result != null) {
      month(result.month);
      year(result.year);
      isDateFilter(true);
      selectedMonthYear(result);
      getMonthlySales();
    }
  }

  void onDateRangeSelected(BuildContext context) async {
    final DateRangeValues dateRangeValues =
        await AppDatePicker.showDateRangePicker(context);
    startDate(dateRangeValues.startDate);
    endDate(dateRangeValues.endDate);
    getTextDate(dateRangeValues);
    getDashboardSummaryData();
  }

  void getTextDate(DateRangeValues values) {
    if (values.startDate != null) {
      final String start = DataFormatter.formatDateToStringDateOnly(
        values.startDate!.toIso8601String(),
      );
      final String end = DataFormatter.formatDateToStringDateOnly(
        values.endDate!.toIso8601String(),
      );
      final String dateString = 'From $start to $end';
      dateText(dateString);
    }
  }

  void clearRoute() async {
    await sharedPreferencesWrapper.remove(SharedPrefsKeys.currentRoute);
  }

  void generateSalesOfTheMonthData(MonthlySales sale) {
    for (int i = 0; i < sale.weeks.length; i++) {
      salesForTheMonthData.add(
        ChartData(
          xValue: sale.weeks[i],
          yValue: sale.sales[i].toDouble(),
        ),
      );
    }
  }

  void updateDataSource(MonthlySales sale) {
    if (salesForTheMonthData.isNotEmpty && chartSeriesController != null) {
      // Clear the data and generate new data
      salesForTheMonthData.clear();
      generateSalesOfTheMonthData(sale);

      // Update all indices dynamically
      final List<int> updatedIndexes =
          List<int>.generate(salesForTheMonthData.length, (int index) => index);
      chartSeriesController!.updateDataSource(
        updatedDataIndexes: updatedIndexes,
      );
    }
  }

  void getMonthlySales() async {
    final Either<Failure, MonthlySales> failureOrMonthlySales =
        await fetchMonthlySales(
      PageParams(
        companyId: loginResponse.company,
        year: year.value,
        month: month.value,
      ),
    );
    failureOrMonthlySales.fold((Failure failure) {
      AppSnack.show(message: failure.message, status: SnackStatus.error);
    }, (MonthlySales sales) {
      monthlySales(sales);
      if (isDateFilter.value) {
        updateDataSource(sales);
      } else {
        salesForTheMonthData.clear();
        generateSalesOfTheMonthData(sales);
        chartSeriesController
            ?.updateDataSource(); // Update data after generating
      }
      isDateFilter(false);
    });
  }

  void getDashboardSummaryData() async {
    final Either<Failure, DashboardSummary> failureOrDashboardSummary =
        await fetchDashboardSummaryData(
      PageParams(
        startDate: startDate.value.toIso8601String(),
        endDate: endDate.value.toIso8601String(),
        companyId: loginResponse.company,
      ),
    );
    failureOrDashboardSummary.fold((Failure failure) {
      AppSnack.show(message: failure.message, status: SnackStatus.error);
    }, (DashboardSummary summary) {
      dashboardSummary(summary);
    });
  }

  Future<void> loadUserData() async {
    final Either<Failure, User> failureOrUser = await loadUser(null);
    // ignore: unawaited_futures
    failureOrUser.fold(
      (Failure failure) {},
      (User user) {
        loginResponse = (user);
      },
    );
  }
}

class ChartData {
  ChartData({
    required this.xValue,
    required this.yValue,
  });

  final int? xValue;
  final double? yValue;
}
