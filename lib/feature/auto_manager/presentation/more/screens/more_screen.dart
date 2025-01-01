import 'package:automanager/core/core.dart';
import 'package:automanager/core/presentation/theme/app_theme.dart';
import 'package:automanager/feature/auto_manager/presentation/more/getx/more_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ionicons/ionicons.dart';

import '../widgets/custom_tile.dart';

class MoreScreen extends GetView<MoreController> {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More'),
        actions: <Widget>[
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
            Visibility(
              visible: UserPermissions.validator.canUpdateCompany,
              child: CustomTile(
                icon: IconlyLight.work,
                onPressed: () => Navigator.of(context).pushNamed(
                  AppRoutes.updateCompany,
                ),
                text: 'Company',
              ),
            ),
            Visibility(
              visible: UserPermissions.validator.canViewDrivers,
              child: CustomTile(
                icon: IconlyLight.discovery,
                onPressed: () =>
                    Navigator.of(context).pushNamed(AppRoutes.drivers),
                text: 'Drivers',
              ),
            ),
            Visibility(
              visible: UserPermissions.validator.canViewCustomers,
              child: CustomTile(
                icon: IconlyLight.user_1,
                onPressed: () =>
                    Navigator.of(context).pushNamed(AppRoutes.customers),
                text: 'Customers',
              ),
            ),
            Visibility(
              visible: UserPermissions.validator.canViewVehicles,
              child: CustomTile(
                icon: Ionicons.speedometer,
                onPressed: () =>
                    Navigator.of(context).pushNamed(AppRoutes.vehicle),
                text: 'Vehicles',
              ),
            ),
            Visibility(
              visible: UserPermissions.validator.canViewUsers,
              child: CustomTile(
                icon: IconlyLight.user,
                onPressed: () =>
                    Navigator.of(context).pushNamed(AppRoutes.userAccounts),
                text: 'User Accounts',
              ),
            ), Visibility(
              visible: UserPermissions.validator.canViewRoles,
              child: CustomTile(
                icon: IconlyLight.lock,
                onPressed: () =>
                    Navigator.of(context).pushNamed(AppRoutes.role),
                text: 'Roles',
              ),
            ),
            CustomTile(
              icon: IconlyLight.shield_done,
              onPressed: () async {
                await showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) =>
                      _buildChangePasswordForm(context),
                );
              },
              text: 'Change Password',
              hideMoreIcon: true,
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

  Widget _buildChangePasswordForm(BuildContext context) {
    return Padding(
      padding: AppPaddings.mA,
      child: Column(
        children: <Widget>[
          const AppSpacing(
            v: 30,
          ),
          Text(
            'Change Password',
            style: context.h6.copyWith(fontWeight: FontWeight.bold),
          ),
          const AppSpacing(
            v: 10,
          ),
          Obx(
            () => AppTextInputField(
              maxLines: 1,
              labelText: 'Old Password',
              onChanged: controller.onOldPasswordInputChanged,
              validator: controller.validatePassword,
              textInputType: TextInputType.visiblePassword,
              obscureText: !controller.showPassword.value,
              suffixIcon: AnimatedSwitcher(
                reverseDuration: Duration.zero,
                transitionBuilder:
                    (Widget? child, Animation<double> animation) {
                  final Animation<double> offset =
                      Tween<double>(begin: 0, end: 1.0).animate(animation);
                  return ScaleTransition(scale: offset, child: child);
                },
                switchInCurve: Curves.elasticOut,
                duration: const Duration(milliseconds: 700),
                child: IconButton(
                  key: ValueKey<bool>(controller.showPassword.value),
                  onPressed: controller.togglePassword,
                  icon: Obx(
                    () => controller.showPassword.value
                        ? const Icon(
                            Icons.visibility,
                            size: 20,
                          )
                        : const Icon(
                            Icons.visibility_off,
                            size: 20,
                          ),
                  ),
                ),
              ),
            ),
          ),
          const AppSpacing(
            v: 10,
          ),
          Obx(
            () => AppTextInputField(
              maxLines: 1,
              labelText: 'New Password',
              onChanged: controller.onNewPasswordInputChanged,
              validator: controller.validatePassword,
              textInputType: TextInputType.visiblePassword,
              obscureText: !controller.showPassword.value,
              suffixIcon: AnimatedSwitcher(
                reverseDuration: Duration.zero,
                transitionBuilder:
                    (Widget? child, Animation<double> animation) {
                  final Animation<double> offset =
                      Tween<double>(begin: 0, end: 1.0).animate(animation);
                  return ScaleTransition(scale: offset, child: child);
                },
                switchInCurve: Curves.elasticOut,
                duration: const Duration(milliseconds: 700),
                child: IconButton(
                  key: ValueKey<bool>(controller.showPassword.value),
                  onPressed: controller.togglePassword,
                  icon: Obx(
                    () => controller.showPassword.value
                        ? const Icon(
                            Icons.visibility,
                            size: 20,
                          )
                        : const Icon(
                            Icons.visibility_off,
                            size: 20,
                          ),
                  ),
                ),
              ),
            ),
          ),
          const AppSpacing(
            v: 10,
          ),
          Obx(
            () => AppTextInputField(
              maxLines: 1,
              labelText: 'Confirm New Password',
              onChanged: controller.onConfirmPasswordInputChanged,
              validator: controller.validatePasswordConfirmation,
              obscureText: !controller.showPassword.value,
              textInputType: TextInputType.visiblePassword,
              suffixIcon: AnimatedSwitcher(
                reverseDuration: Duration.zero,
                transitionBuilder:
                    (Widget? child, Animation<double> animation) {
                  final Animation<double> offset =
                      Tween<double>(begin: 0, end: 1.0).animate(animation);
                  return ScaleTransition(scale: offset, child: child);
                },
                switchInCurve: Curves.elasticOut,
                duration: const Duration(milliseconds: 700),
                child: IconButton(
                  key: ValueKey<bool>(controller.showPassword.value),
                  onPressed: controller.togglePassword,
                  icon: Obx(
                    () => controller.showPassword.value
                        ? const Icon(
                            Icons.visibility,
                            size: 20,
                          )
                        : const Icon(
                            Icons.visibility_off,
                            size: 20,
                          ),
                  ),
                ),
              ),
            ),
          ),
          const AppSpacing(
            v: 10,
          ),
          Obx(
            () => AppButton(
              text: 'Change Password',
              onPressed: controller.onChangePassword,
              enabled:
                  controller.isFormValid.value && !controller.isLoading.value,
            ),
          ),
        ],
      ),
    );
  }
}
