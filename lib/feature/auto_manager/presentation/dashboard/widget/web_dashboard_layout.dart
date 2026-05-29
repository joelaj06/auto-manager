import 'package:flutter/material.dart';

import '../../../../../core/presentation/theme/app_theme.dart';
import '../getx/dashboard_controller.dart';
import 'web_dashboard_body.dart';
import 'web_dashboard_toolbar.dart';
import 'web_kpi_band.dart';
class WebDashboardLayout extends StatelessWidget {
  const WebDashboardLayout({required this.controller});

  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // ── Top bar ──────────────────────────────────────────────────────
          WebDashboardTopBar(controller: controller),

          // ── KPI band ─────────────────────────────────────────────────────
          WebKpiBand(controller: controller),

          // ── Body: chart left, revenue + mini metrics right ───────────────
          Expanded(
            child: WebDashboardBody(controller: controller),
          ),
        ],
      ),
    );
  }
}