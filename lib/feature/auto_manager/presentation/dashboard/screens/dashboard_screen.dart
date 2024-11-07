import 'package:automanager/core/core.dart';
import 'package:automanager/core/presentation/theme/app_theme.dart';
import 'package:automanager/feature/auto_manager/presentation/dashboard/dashboard.dart';
import 'package:automanager/feature/auto_manager/presentation/dashboard/widget/dashboard_cards.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
          title: SizedBox(
            width: context.width,
            height: kToolbarHeight,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Obx(
                () => Text(controller.company.value.name ?? 'Auto Manager',
                textAlign: TextAlign.left,),
              ),
            ),
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
            Obx(
              () => _logoWrapper(
                context,
                child: controller.company.value.logoUrl != null &&
                        controller.company.value.logoUrl != ''
                    ? CachedNetworkImage(
                        imageUrl: controller.company.value.logoUrl!,
                        errorWidget:
                            (BuildContext context, String url, dynamic error) =>
                                const Icon(Icons.error),
                      )
                    : const AppLogo(),
              ),
            ),
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
          _buildDashboardSummaryDateField(context),
          const AppSpacing(
            v: 10,
          ),
          Obx(
            () => DashboardSummaryCard(
              title: 'Revenue',
              value: DataFormatter.getLocalCompactCurrencyFormatter(context)
                  .format(
                controller.dashboardSummary.value.revenue,
              ),
              icon: Iconsax.moneys5,
              onTap: () {},
              valueIcon: (controller.dashboardSummary.value.revenue ?? 0) < 0
                  ? Icon(
                      Ionicons.arrow_down,
                      size: 14,
                      color: context.colorScheme.error,
                    )
                  : null,
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
                    title: 'Sales',
                    value:
                        DataFormatter.getLocalCompactCurrencyFormatter(context)
                            .format(
                      controller.dashboardSummary.value.sales,
                    ),
                    icon: Icons.money_rounded,
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
                        DataFormatter.getLocalCompactCurrencyFormatter(context)
                            .format(
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
                    title: 'Rentals',
                    value:
                        DataFormatter.getLocalCompactCurrencyFormatter(context)
                            .format(
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
                    title: 'Vehicles',
                    value:
                        controller.dashboardSummary.value.vehicles.toString(),
                    icon: Ionicons.speedometer,
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
      onTap: () {
        controller.onMonthSelected(context);
      },
      child: Container(
        padding: AppPaddings.mA,
        decoration: BoxDecoration(
          color: context.colorScheme.outline.withOpacity(0.2),
          borderRadius: AppBorderRadius.card,
        ),
        // padding: AppPaddings.sA.add(AppPaddings.sH),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              IconlyLight.calendar,
            ),
            const AppSpacing(
              h: 10,
            ),
            Obx(
              () => Text(
                DataFormatter.formatDateToTextMonthYear(
                  controller.selectedMonthYear.value.toIso8601String(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklyChart(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: const ChartTitle(
        text: 'Weekly Sales',
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
        onRendererCreated:
            (ChartSeriesController<ChartData, num> chartSeriesController) {
          controller.chartSeriesController = chartSeriesController;
        },
      ),
    ];
  }

  Widget _buildDashboardSummaryDateField(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.onDateRangeSelected(context);
      },
      child: Container(
        padding: AppPaddings.mA,
        decoration: BoxDecoration(
            borderRadius: AppBorderRadius.card,
            border: Border.all(
              color: context.colorScheme.secondary.withOpacity(0.4),
            )),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              IconlyLight.calendar,
            ),
            const AppSpacing(
              h: 10,
            ),
            Obx(
              () => Text(
                controller.dateText.value,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
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
