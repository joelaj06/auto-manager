import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../core/presentation/theme/app_theme.dart';
import '../../../../../core/utils/data_formatter.dart';
import '../getx/dashboard_controller.dart';
import 'web_date_chip.dart';
class WebWeeklyChartPanel extends StatelessWidget {
  const WebWeeklyChartPanel({super.key, required this.controller});

  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colorScheme;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Panel header
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Weekly Sales',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: colors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Obx(
                          () => Text(
                        DataFormatter.formatDateToTextMonthYear(
                          controller.selectedMonthYear.value
                              .toIso8601String(),
                        ),
                        style: TextStyle(
                          fontSize: 12,
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Month picker chip
              Obx(() => WebDateChip(
                  label: DataFormatter.formatDateToTextMonthYear(
                      controller.selectedMonthYear.value.toIso8601String()
                    ),
                  onTap: () => controller.onMonthSelected(context),
                  icon: IconlyLight.calendar,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Chart — fills remaining space
          Expanded(
            child: GetBuilder<DashboardController>(
              id: 'salesForTheMonthData',
              builder: (DashboardController ctrl) {
                return SfCartesianChart(
                  plotAreaBorderWidth: 0,
                  margin: EdgeInsets.zero,
                  primaryXAxis: CategoryAxis(
                    axisLine: const AxisLine(width: 0),
                    labelPosition: ChartDataLabelPosition.outside,
                    majorTickLines: const MajorTickLines(width: 0),
                    majorGridLines: const MajorGridLines(width: 0),
                    labelStyle: TextStyle(
                      fontSize: 11,
                      color: colors.onSurfaceVariant,
                    ),
                    axisLabelFormatter: (AxisLabelRenderDetails args) {
                      return ChartAxisLabel(
                        'Week ${args.value + 1}',
                        TextStyle(
                          fontSize: 11,
                          color: colors.onSurfaceVariant,
                        ),
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
                      color: colors.primary,
                      width: 0.55,
                      dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                        labelAlignment: ChartDataLabelAlignment.top,
                        textStyle: TextStyle(
                          fontSize: 11,
                          color: colors.onSurface,
                        ),
                      ),
                      dataSource: ctrl.salesForTheMonthData,
                      borderRadius: BorderRadius.circular(6),
                      xValueMapper: (ChartData sales, _) =>
                      sales.xValue,
                      yValueMapper: (ChartData sales, _) =>
                      sales.yValue,
                      onRendererCreated: (
                          ChartSeriesController<ChartData, num>
                          chartSeriesController,
                          ) {
                        ctrl.chartSeriesController =
                            chartSeriesController;
                      },
                    ),
                  ],
                  tooltipBehavior: ctrl.tooltipBehavior,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}