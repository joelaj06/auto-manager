import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../core/presentation/theme/app_theme.dart';
import '../../../../../core/utils/data_formatter.dart';
import '../getx/dashboard_controller.dart';
class WebRightPanel extends StatelessWidget {
  const WebRightPanel({super.key, required this.controller});

  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // ── Revenue hero ────────────────────────────────────────────────
        Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: colors.outlineVariant.withValues(alpha: 0.5),
                width: 0.5,
              ),
            ),
          ),
          child: Obx(() {
            final num revenue =
                controller.dashboardSummary.value.revenue ?? 0;
            final bool isNegative = revenue < 0;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'NET REVENUE',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.6,
                    color: colors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        DataFormatter.getLocalCompactCurrencyFormatter(
                          context,
                        ).format(revenue),
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          color: isNegative
                              ? colors.error
                              : colors.onSurface,
                        ),
                      ),
                    ),
                    if (isNegative)
                      Icon(Ionicons.arrow_down,
                          size: 18, color: colors.error),
                  ],
                ),
                const SizedBox(height: 4),
                Obx(
                      () => Text(
                    controller.dateText.value,
                    style: TextStyle(
                      fontSize: 12,
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            );
          }),
        ),

        // ── 2×2 count grid ───────────────────────────────────────────────
        Expanded(
          child: Obx(() {
            final summary = controller.dashboardSummary.value;

            final List<_CountItem> counts = <_CountItem>[
              _CountItem(
                label: 'Vehicles',
                value: summary.vehicles.toString(),
                icon: Ionicons.speedometer,
                iconBg: colors.surfaceContainerHighest,
              ),
              _CountItem(
                label: 'Drivers',
                value: summary.drivers.toString(),
                icon: IconlyBold.discovery,
                iconBg: colors.surfaceContainerHighest,
              ),
              _CountItem(
                label: 'Customers',
                value: summary.customers.toString(),
                icon: IconlyBold.user_3,
                iconBg: colors.surfaceContainerHighest,
              ),
              _CountItem(
                label: 'Rentals',
                value: DataFormatter.getLocalCompactCurrencyFormatter(
                  context,
                ).format(summary.rentalSales),
                icon: Ionicons.car,
                iconBg: colors.surfaceContainerHighest,
              ),
            ];

            return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: counts.length,
              itemBuilder: (BuildContext context, int index) {
                return _CountGridCell(
                  item: counts[index],
                  showRightBorder: index % 2 == 0,
                  showBottomBorder: index < 2,
                );
              },
            );
          }),
        ),
      ],
    );
  }
}

class _CountItem {
  const _CountItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.iconBg,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color iconBg;
}

class _CountGridCell extends StatelessWidget {
  const _CountGridCell({
    required this.item,
    required this.showRightBorder,
    required this.showBottomBorder,
  });

  final _CountItem item;
  final bool showRightBorder;
  final bool showBottomBorder;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          right: showRightBorder
              ? BorderSide(
            color:
            colors.outlineVariant.withValues(alpha: 0.5),
            width: 0.5,
          )
              : BorderSide.none,
          bottom: showBottomBorder
              ? BorderSide(
            color:
            colors.outlineVariant.withValues(alpha: 0.5),
            width: 0.5,
          )
              : BorderSide.none,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: item.iconBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(item.icon,
                size: 16, color: colors.onSurfaceVariant),
          ),
          const SizedBox(height: 10),
          Text(
            item.label.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
              color: colors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            item.value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: colors.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}