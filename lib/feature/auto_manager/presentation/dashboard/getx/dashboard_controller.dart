import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardController extends GetxController{

  RxList<ChartData> salesForTheWeekData = <ChartData>[].obs;


  TooltipBehavior tooltipBehavior = TooltipBehavior();
  late ChartSeriesController? chartSeriesController;


  @override
  void onInit() {
    tooltipBehavior = TooltipBehavior(enable: true,
    color: Get.theme.colorScheme.primary,
    opacity: 0.8,);
    super.onInit();
  }

  @override
  void onClose() {
    chartSeriesController = null;
    super.onClose();
  }

}

class ChartData{
  ChartData({
    required this.xValue,
    required this.yValue,
  });

  final String xValue;
  final double? yValue;
}

