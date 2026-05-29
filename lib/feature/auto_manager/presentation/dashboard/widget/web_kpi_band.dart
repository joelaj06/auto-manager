import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../core/presentation/theme/app_theme.dart';
import '../../../../../core/utils/data_formatter.dart';
import '../getx/dashboard_controller.dart';

class WebKpiBand extends StatelessWidget {
  const WebKpiBand({super.key, required this.controller});

  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colorScheme;

    return Obx(() {
      final summary = controller.dashboardSummary.value;
      final formatter =
      DataFormatter.getLocalCompactCurrencyFormatter(context);

      final List<_KpiItem> items = <_KpiItem>[
        _KpiItem(
          label: 'Revenue',
          value: formatter.format(summary.revenue),
          icon: Iconsax.moneys5,
          isNegative: (summary.revenue ?? 0) < 0,
        ),
        _KpiItem(
          label: 'Sales',
          value: formatter.format(summary.sales),
          icon: Icons.money_rounded,
        ),
        _KpiItem(
          label: 'Expenses',
          value: formatter.format(summary.expenses),
          icon: IconlyBold.wallet,
        ),
        _KpiItem(
          label: 'Rentals',
          value: formatter.format(summary.rentalSales),
          icon: Ionicons.car,
        ),
        _KpiItem(
          label: 'Vehicles',
          value: summary.vehicles.toString(),
          icon: Ionicons.speedometer,
          isCurrency: false,
        ),
        _KpiItem(
          label: 'Drivers',
          value: summary.drivers.toString(),
          icon: IconlyBold.discovery,
          isCurrency: false,
        ),
        _KpiItem(
          label: 'Customers',
          value: summary.customers.toString(),
          icon: IconlyBold.user_3,
          isCurrency: false,
        ),
      ];

      return Container(
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border(
            bottom: BorderSide(
              color: colors.outlineVariant.withValues(alpha: 0.5),
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: items.asMap().entries.map((
              MapEntry<int, _KpiItem> entry,
              ) {
            final bool isLast = entry.key == items.length - 1;
            return Expanded(
              child: _KpiBandCell(
                item: entry.value,
                showRightBorder: !isLast,
              ),
            );
          }).toList(),
        ),
      );
    });
  }
}

class _KpiItem {
  const _KpiItem({
    required this.label,
    required this.value,
    required this.icon,
    this.isNegative = false,
    this.isCurrency = true,
  });

  final String label;
  final String value;
  final IconData icon;
  final bool isNegative;
  final bool isCurrency;
}

class _KpiBandCell extends StatelessWidget {
  const _KpiBandCell({
    required this.item,
    required this.showRightBorder,
  });

  final _KpiItem item;
  final bool showRightBorder;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          right: showRightBorder
              ? BorderSide(
            color: colors.outlineVariant.withValues(alpha: 0.5),
            width: 0.5,
          )
              : BorderSide.none,
        ),
      ),
      child: Row(
        children: <Widget>[
          // Icon
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: colors.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(item.icon, size: 15,
                color: colors.onSurfaceVariant),
          ),
          const SizedBox(width: 10),

          // Label + value
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  item.label.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                    color: colors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        item.value,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: item.isNegative
                              ? colors.error
                              : colors.onSurface,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (item.isNegative)
                      Icon(Ionicons.arrow_down,
                          size: 12, color: colors.error),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}