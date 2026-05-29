import 'package:automanager/feature/auto_manager/presentation/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/mobile_dashboard_layout.dart';
import '../widget/web_dashboard_layout.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final bool isWide = MediaQuery.of(context).size.width >= 768;

    return isWide
        ? WebDashboardLayout(controller: controller)
        : MobileDashboardLayout(controller: controller);

  }

}
