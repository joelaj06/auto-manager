import 'package:automanager/core/core.dart';
import 'package:automanager/core/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../core/presentation/routes/app_routes.dart';
import '../widgets/custom_tile.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  bool _isDarkMode = Get.isDarkMode;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    Get.changeThemeMode(isDarkMode ? ThemeMode.light : ThemeMode.dark);
    setState(() {
      _isDarkMode = !_isDarkMode; // Update the state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More'),
        actions: [
          IconButton(
            onPressed: toggleTheme,
            icon: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
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
              onPressed: () {},
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
