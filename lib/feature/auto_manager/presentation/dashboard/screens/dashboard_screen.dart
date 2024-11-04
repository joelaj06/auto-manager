import 'package:automanager/core/core.dart';
import 'package:automanager/core/presentation/theme/app_theme.dart';
import 'package:automanager/core/utils/data_formatter.dart';
import 'package:automanager/feature/auto_manager/presentation/dashboard/dashboard.dart';
import 'package:automanager/feature/auto_manager/presentation/dashboard/widget/dashboard_cards.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // controller.getMonthlySales();
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const FittedBox(
            fit: BoxFit.fill,
            child: Text('LA Logistics'),
          ),
          toolbarHeight: kToolbarHeight * 1.3,
          actions: <Widget>[
            _logoWrapper(
              context,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Iconsax.notification5,
                  size: 28,
                ),
              ),
            ),
            _logoWrapper(context, child: const FlutterLogo()),
          ],
        ),
        body: Column(
          children: <Widget>[
            const Divider(),
            Expanded(child: _buildDashboardContents(context)),
          ],
        ));
  }

  Widget _buildDashboardContents(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppPaddings.mA,
        child: Column(children: <Widget>[
          _buildDateField(context),
          const AppSpacing(
            v: 10,
          ),
          Obx(
            () => DashboardSummaryCard(
              title: 'Revenue',
              value: DataFormatter.getLocalCompactCurrencyFormatter(context).format(
                controller.dashboardSummary.value.revenue,
              ),
              icon: Iconsax.moneys5,
              onTap: () {},
            ),
          ),
          const AppSpacing(
            v: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Obx(
                  () => DashboardSummaryCard(
                    title: 'Rentals',
                    value:
                        DataFormatter.getLocalCompactCurrencyFormatter(context).format(
                      controller.dashboardSummary.value.rentalSales,
                    ),
                    icon: Ionicons.car,
                  ),
                ),
              ),
              const AppSpacing(
                h: 10,
              ),
              Expanded(
                child: Obx(
                  () => DashboardSummaryCard(
                    title: 'Expenses',
                    value:
                        DataFormatter.getLocalCompactCurrencyFormatter(context).format(
                      controller.dashboardSummary.value.expenses,
                    ),
                    icon: IconlyBold.wallet,
                  ),
                ),
              ),
            ],
          ),
          const AppSpacing(
            v: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Obx(
                  () => DashboardSummaryCard(
                    title: 'Drivers',
                    value: controller.dashboardSummary.value.drivers.toString(),
                    icon: IconlyBold.discovery,
                  ),
                ),
              ),
              const AppSpacing(
                h: 10,
              ),
              Expanded(
                child: Obx(
                  () => DashboardSummaryCard(
                    title: 'Customers',
                    value:
                        controller.dashboardSummary.value.customers.toString(),
                    icon: IconlyBold.user_3,
                  ),
                ),
              ),
            ],
          ),
          const AppSpacing(
            v: 10,
          ),
          Card(
            color: context.colorScheme.outline.withOpacity(0.1),
            shadowColor: context.colorScheme.outline.withOpacity(0.1),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: _buildMonthDateField(context),
                ),
                _buildWeeklyChart(context),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildMonthDateField(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: AppPaddings.mA,
        decoration: BoxDecoration(
          color: context.colorScheme.outline.withOpacity(0.2),
          borderRadius: AppBorderRadius.card,
        ),
        // padding: AppPaddings.sA.add(AppPaddings.sH),
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              IconlyLight.calendar,
            ),
            AppSpacing(
              h: 10,
            ),
            Row(
              children: <Widget>[
                Text('October 2024'),
              ],
            )
          ],
        ),
      ),
    );
  }

  SfCartesianChart _buildWeeklyChart(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: const ChartTitle(
        text: 'Weekly Revenue',
        alignment: ChartAlignment.near,
      ),
      primaryXAxis: const NumericAxis(
        axisLine: AxisLine(width: 0),
        labelPosition: ChartDataLabelPosition.outside,
        majorTickLines: MajorTickLines(width: 0),
        majorGridLines: MajorGridLines(width: 0),
        labelFormat: 'Week {value}',
      ),
      primaryYAxis: NumericAxis(
        isVisible: false,
        /*majorGridLines: const MajorGridLines(
          width: 0.7,
          dashArray: <double>[5, 10],
        ),*/
        numberFormat: NumberFormat.compactCurrency(
          symbol: '',
        ),
      ),
      series: _getRoundedColumnSeries(context),
      tooltipBehavior: controller.tooltipBehavior,
    );
  }

  List<ColumnSeries<ChartData, num>> _getRoundedColumnSeries(
      BuildContext context) {
    return <ColumnSeries<ChartData, num>>[
      ColumnSeries<ChartData, num>(
        color: context.colorScheme.outline,
        width: 0.7,
        dataLabelSettings: const DataLabelSettings(
            isVisible: true, labelAlignment: ChartDataLabelAlignment.top),
        dataSource: controller.salesForTheMonthData,
        borderRadius: BorderRadius.circular(15),
        xValueMapper: (ChartData sales, _) => sales.xValue,
        yValueMapper: (ChartData sales, _) => sales.yValue,
        onRendererCreated: (ChartSeriesController chartSeriesController) {
          controller.chartSeriesController = chartSeriesController;
        },
      ),
    ];
  }

  Widget _buildDateField(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: AppPaddings.mA,
        decoration: BoxDecoration(
            borderRadius: AppBorderRadius.card,
            border: Border.all(
              color: context.colorScheme.secondary.withOpacity(0.4),
            )),
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              IconlyLight.calendar,
            ),
            AppSpacing(
              h: 10,
            ),
            Row(
              children: <Widget>[
                Text('From '),
                Text(
                  '1st October 2024 to 31st October 2024',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _logoWrapper(BuildContext context, {required Widget child}) {
    return Padding(
      padding: AppPaddings.mA,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: context.colorScheme.secondary.withOpacity(0.4),
            )),
        child: child,
      ),
    );
  }
}
