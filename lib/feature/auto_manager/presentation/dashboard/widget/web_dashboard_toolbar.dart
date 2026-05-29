import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import '../../../../../core/presentation/theme/app_theme.dart';
import '../getx/dashboard_controller.dart';
import 'logo.dart';
import 'web_date_chip.dart';

class WebDashboardTopBar extends StatelessWidget {
  const WebDashboardTopBar({super.key, required this.controller});

  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colorScheme;

    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 24),
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
        children: <Widget>[
          // Company name
          Obx(
                () => Text(
              controller.company.value.name ?? 'AutoForce Manager',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const Spacer(),

          // Date range picker chip
          Obx(() => WebDateChip(
              label: controller.dateText.value,
              onTap: () => controller.onDateRangeSelected(context),
              icon: IconlyLight.calendar,
            ),
          ),

          const SizedBox(width: 12),

          // Company logo
          Obx(
                () => LogoWidget(
              logoUrl: controller.company.value.logoUrl,
              size: 36,
              radius: 8,
            ),
          ),
        ],
      ),
    );
  }
}