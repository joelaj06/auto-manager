import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../../../../core/presentation/theme/app_theme.dart';
import '../../../../../core/presentation/utils/app_border_radius.dart';
import '../../../../../core/presentation/utils/app_padding.dart';
import '../../../../../core/presentation/utils/app_spacing.dart';
import '../../../../../core/utils/data_formatter.dart';
import '../getx/dashboard_controller.dart';
class DashboardDateRangeField extends StatelessWidget {
  const DashboardDateRangeField({super.key, required this.controller});

  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => controller.onDateRangeSelected(context),
      child: Container(
        padding: AppPaddings.mA,
        decoration: BoxDecoration(
          borderRadius: AppBorderRadius.card,
          border: Border.all(
            color: context.colorScheme.secondary
                .withValues(alpha: 0.4),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(IconlyLight.calendar),
            const AppSpacing(h: 10),
            Obx(
                  () => Text(
                controller.dateText.value,
                style:
                const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Mobile month picker field ─────────────────────────────────────────────────
class DashboardMonthField extends StatelessWidget {
  const DashboardMonthField({super.key, required this.controller});

  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => controller.onMonthSelected(context),
      child: Container(
        padding: AppPaddings.mA,
        decoration: BoxDecoration(
          color: context.colorScheme.outline.withValues(alpha: 0.2),
          borderRadius: AppBorderRadius.card,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(IconlyLight.calendar),
            const AppSpacing(h: 10),
            Obx(
                  () => Text(
                DataFormatter.formatDateToTextMonthYear(
                  controller.selectedMonthYear.value
                      .toIso8601String(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
