import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../core/presentation/theme/app_theme.dart';
import '../../../../../core/presentation/utils/app_padding.dart';
import '../../../../../core/presentation/utils/app_spacing.dart';
import '../../../../../core/utils/data_formatter.dart';
import '../getx/dashboard_controller.dart';
import 'package:get/get.dart';

import 'dashboard_cards.dart';
import 'dashboard_date_field.dart';
import 'dashboard_weekly_chart.dart';
import 'logo.dart';
class MobileDashboardLayout extends StatelessWidget {
  const MobileDashboardLayout({required this.controller});

  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: SizedBox(
          width: context.width,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Obx(
                  () => Text(
                controller.company.value.name ?? 'AutoForce Manager',
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ),
        toolbarHeight: kToolbarHeight * 1.3,
        actions: <Widget>[
          Obx(
                () => LogoWidget(
              logoUrl: controller.company.value.logoUrl,
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: _MobileDashboardBody(controller: controller)),
        ],
      ),
    );
  }
}

class _MobileDashboardBody extends StatelessWidget {
  const _MobileDashboardBody({required this.controller});

  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppPaddings.mA,
        child: Column(
          children: <Widget>[
            DashboardDateRangeField(controller: controller),
            const AppSpacing(v: 10),
            Obx(
                  () => DashboardSummaryCard(
                title: 'Revenue',
                value: DataFormatter.getLocalCompactCurrencyFormatter(
                  context,
                ).format(controller.dashboardSummary.value.revenue),
                icon: Iconsax.moneys5,
                onTap: () {},
                valueIcon:
                (controller.dashboardSummary.value.revenue ?? 0) < 0
                    ? Icon(Ionicons.arrow_down,
                    size: 14, color: context.colorScheme.error)
                    : null,
              ),
            ),
            const AppSpacing(v: 10),
            Row(
              children: <Widget>[
                Expanded(
                  child: Obx(
                        () => DashboardSummaryCard(
                      title: 'Sales',
                      value:
                      DataFormatter.getLocalCompactCurrencyFormatter(
                        context,
                      ).format(
                          controller.dashboardSummary.value.sales),
                      icon: Icons.money_rounded,
                    ),
                  ),
                ),
                const AppSpacing(h: 10),
                Expanded(
                  child: Obx(
                        () => DashboardSummaryCard(
                      title: 'Expenses',
                      value:
                      DataFormatter.getLocalCompactCurrencyFormatter(
                        context,
                      ).format(
                          controller.dashboardSummary.value.expenses),
                      icon: IconlyBold.wallet,
                    ),
                  ),
                ),
              ],
            ),
            const AppSpacing(v: 10),
            Row(
              children: <Widget>[
                Expanded(
                  child: Obx(
                        () => DashboardSummaryCard(
                      title: 'Rentals',
                      value:
                      DataFormatter.getLocalCompactCurrencyFormatter(
                        context,
                      ).format(controller
                          .dashboardSummary.value.rentalSales),
                      icon: Ionicons.car,
                    ),
                  ),
                ),
                const AppSpacing(h: 10),
                Expanded(
                  child: Obx(
                        () => DashboardSummaryCard(
                      title: 'Vehicles',
                      value: controller.dashboardSummary.value.vehicles
                          .toString(),
                      icon: Ionicons.speedometer,
                    ),
                  ),
                ),
              ],
            ),
            const AppSpacing(v: 10),
            Row(
              children: <Widget>[
                Expanded(
                  child: Obx(
                        () => DashboardSummaryCard(
                      title: 'Drivers',
                      value: controller.dashboardSummary.value.drivers
                          .toString(),
                      icon: IconlyBold.discovery,
                    ),
                  ),
                ),
                const AppSpacing(h: 10),
                Expanded(
                  child: Obx(
                        () => DashboardSummaryCard(
                      title: 'Customers',
                      value: controller.dashboardSummary.value.customers
                          .toString(),
                      icon: IconlyBold.user_3,
                    ),
                  ),
                ),
              ],
            ),
            const AppSpacing(v: 10),
            Card(
              color: context.colorScheme.outline.withValues(alpha: 0.1),
              shadowColor:
              context.colorScheme.outline.withValues(alpha: 0.1),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerRight,
                    child:
                    DashboardMonthField(controller: controller),
                  ),
                  DashboardWeeklyChart(controller: controller),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}