import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../core/presentation/theme/app_theme.dart';
import '../getx/dashboard_controller.dart';
class DashboardWeeklyChart extends StatelessWidget {
  const DashboardWeeklyChart({super.key, required this.controller});

  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      id: 'salesForTheMonthData',
      builder: (DashboardController ctrl) {
        return SfCartesianChart(
          plotAreaBorderWidth: 0,
          title: const ChartTitle(
            text: 'Weekly Sales',
            alignment: ChartAlignment.near,
          ),
          primaryXAxis: CategoryAxis(
            axisLine: const AxisLine(width: 0),
            labelPosition: ChartDataLabelPosition.outside,
            majorTickLines: const MajorTickLines(width: 0),
            majorGridLines: const MajorGridLines(width: 0),
            axisLabelFormatter: (AxisLabelRenderDetails args) {
              return ChartAxisLabel(
                'Week ${args.value + 1}',
                const TextStyle(fontWeight: FontWeight.normal),
              );
            },
          ),
          primaryYAxis: NumericAxis(
            isVisible: false,
            numberFormat:
            NumberFormat.compactCurrency(symbol: ''),
          ),
          series: <ColumnSeries<ChartData, num>>[
            ColumnSeries<ChartData, num>(
              color: context.colorScheme.outline,
              width: 0.7,
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                labelAlignment: ChartDataLabelAlignment.top,
              ),
              dataSource: ctrl.salesForTheMonthData,
              borderRadius: BorderRadius.circular(15),
              xValueMapper: (ChartData sales, _) => sales.xValue,
              yValueMapper: (ChartData sales, _) => sales.yValue,
              onRendererCreated: (
                  ChartSeriesController<ChartData, num>
                  chartSeriesController,
                  ) {
                ctrl.chartSeriesController = chartSeriesController;
              },
            ),
          ],
          tooltipBehavior: ctrl.tooltipBehavior,
        );
      },
    );
  }
}