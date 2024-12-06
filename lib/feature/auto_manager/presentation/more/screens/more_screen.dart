import 'package:automanager/core/presentation/theme/app_theme.dart';
import 'package:automanager/core/presentation/utils/app_dialogs.dart';
import 'package:automanager/feature/auto_manager/presentation/more/getx/more_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../core/presentation/routes/routes.dart';
import '../../../../../core/presentation/utils/utils.dart';
import '../widgets/custom_tile.dart';

class MoreScreen extends GetView<MoreController> {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More'),
        actions: [
          IconButton(
            onPressed: controller.toggleTheme,
            icon: Icon(
              controller.isDarkMode.value ? Icons.light_mode : Icons.dark_mode,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: AppPaddings.mA,
        child: Column(
          children: <Widget>[
            CustomTile(
              icon: IconlyLight.profile,
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoutes.profile),
              text: 'Profile',
            ),
            CustomTile(
              icon: IconlyLight.work,
              onPressed: () => Navigator.of(context).pushNamed(
                AppRoutes.updateCompany,
              ),
              text: 'Company',
            ),
            CustomTile(
              icon: IconlyLight.discovery,
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoutes.drivers),
              text: 'Drivers',
            ),
            CustomTile(
              icon: IconlyLight.user_1,
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoutes.customers),
              text: 'Customers',
            ),
            CustomTile(
              icon: Ionicons.speedometer,
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoutes.vehicle),
              text: 'Vehicles',
            ),
            CustomTile(
              icon: IconlyLight.user,
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoutes.userAccounts),
              text: 'User Accounts',
            ),
            CustomTile(
              icon: IconlyLight.logout,
              onPressed: () async {
                await AppDialogs.showDialogWithButtons(
                  context,
                  onConfirmPressed: () => controller.logUserOut(),
                  content: const Text(
                    'Are you sure you want to logout?',
                    textAlign: TextAlign.center,
                  ),
                  confirmText: 'Logout',
                );
              },
              text: 'Logout',
              iconColor: context.colorScheme.error,
              textColor: context.colorScheme.error,
              hideMoreIcon: true,
            ),
          ],
        ),
      ),
    );
  }
}
