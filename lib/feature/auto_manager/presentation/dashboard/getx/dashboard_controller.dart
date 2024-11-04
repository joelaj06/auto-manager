import 'package:automanager/core/core.dart';
import 'package:automanager/feature/auto_manager/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../data/data.dart';

class DashboardController extends GetxController {
  DashboardController(
      {required this.fetchDashboardSummaryData,
      required this.fetchMonthlySales});

  FetchDashboardSummaryData fetchDashboardSummaryData;
  FetchMonthlySales fetchMonthlySales;

  RxList<ChartData> salesForTheWeekData = <ChartData>[].obs;
  Rx<DashboardSummary> dashboardSummary = DashboardSummary.empty().obs;
  RxString startDate = '2024-10-01'.obs;
  RxString endDate = '2024-10-31'.obs;
  RxString companyId = '64f1a4b77a5e5f5a098e4c77'.obs;
  Rx<MonthlySales> monthlySales = MonthlySales.empty().obs;
  RxList<ChartData> salesForTheMonthData = <ChartData>[].obs;
  RxBool isDateFilter = false.obs;

  TooltipBehavior tooltipBehavior = TooltipBehavior();
  late ChartSeriesController? chartSeriesController;
  final SharedPreferencesWrapper sharedPreferencesWrapper = Get.find();

  @override
  void onInit() {
    tooltipBehavior = TooltipBehavior(
      enable: true,
      color: Get.theme.colorScheme.primary,
      opacity: 0.8,
    );
    clearRoute();
    getMonthlySales();
    getDashboardSummaryData();
    super.onInit();
  }

  @override
  void onClose() {
    chartSeriesController = null;
    super.onClose();
  }

  void clearRoute() async {
    await sharedPreferencesWrapper.remove(SharedPrefsKeys.currentRoute);
  }

  void getSalesOfTheMonthData(MonthlySales sale) {
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
    if (salesForTheWeekData.isNotEmpty) {
      salesForTheWeekData.clear();
      getSalesOfTheMonthData(sale);
      chartSeriesController?.updateDataSource(
        removedDataIndexes: <int>[0, 1, 2, 3,],
        addedDataIndexes: <int>[0, 1, 2, 3,],
      );
    }
  }

  void getMonthlySales() async {
    final Either<Failure, MonthlySales> failureOrMonthlySales =
        await fetchMonthlySales(
      PageParams(
        companyId: companyId.value,
        year: DateTime.now().year,
        month: DateTime.now().month - 1,
      ),
    );
    failureOrMonthlySales.fold((Failure failure) {
      AppSnack.show(message: failure.message, status: SnackStatus.error);
    }, (MonthlySales sales) {
      monthlySales(sales);
      salesForTheMonthData.clear();
      getSalesOfTheMonthData(sales);
      if (isDateFilter.value) {
        updateDataSource(sales);
      }
      isDateFilter(false);
    });
  }

  void getDashboardSummaryData() async {
    final Either<Failure, DashboardSummary> failureOrDashboardSummary =
        await fetchDashboardSummaryData(
      PageParams(
        startDate: startDate.value,
        endDate: endDate.value,
        companyId: companyId.value,
      ),
    );
    failureOrDashboardSummary.fold((Failure failure) {
      AppSnack.show(message: failure.message, status: SnackStatus.error);
    }, (DashboardSummary summary) {
      dashboardSummary(summary);
    });
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
