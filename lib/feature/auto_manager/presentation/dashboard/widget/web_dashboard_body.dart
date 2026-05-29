import 'package:flutter/material.dart';

import '../../../../../core/presentation/theme/app_theme.dart';
import '../getx/dashboard_controller.dart';
import 'web_right_panel.dart';
import 'web_weekly_chart_panel.dart';
class WebDashboardBody extends StatelessWidget {
  const WebDashboardBody({super.key, required this.controller});

  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // ── Left: weekly chart ──────────────────────────────────────────
        Expanded(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: colors.outlineVariant.withValues(alpha: 0.5),
                  width: 0.5,
                ),
              ),
            ),
            child: WebWeeklyChartPanel(controller: controller),
          ),
        ),

        // ── Right: revenue callout + 2×2 count grid ─────────────────────
        Expanded(
          flex: 2,
          child: WebRightPanel(controller: controller),
        ),
      ],
    );
  }
}