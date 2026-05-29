import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/theme/app_theme.dart';
import '../../../../../core/presentation/utils/app_padding.dart';
import '../../../../../core/presentation/utils/app_spacing.dart';
import '../../../../../core/presentation/widgets/app_button.dart';
import '../../../../../core/presentation/widgets/app_text_input_field.dart';
import '../../more/getx/more_controller.dart';
class ChangePasswordSheet extends StatelessWidget {
  const ChangePasswordSheet({required this.controller});

  final MoreController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.mA.add(
        EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const AppSpacing(v: 16),
            Text(
              'Change Password',
              style: context.h6.copyWith(fontWeight: FontWeight.bold),
            ),
            const AppSpacing(v: 16),

            // Old password
            Obx(
                  () => AppTextInputField(
                maxLines: 1,
                labelText: 'Old Password',
                onChanged: controller.onOldPasswordInputChanged,
                validator: controller.validatePassword,
                textInputType: TextInputType.visiblePassword,
                obscureText: !controller.showPassword.value,
                suffixIcon: _PasswordToggleIcon(
                  controller: controller,
                ),
              ),
            ),
            const AppSpacing(v: 10),

            // New password
            Obx(
                  () => AppTextInputField(
                maxLines: 1,
                labelText: 'New Password',
                onChanged: controller.onNewPasswordInputChanged,
                validator: controller.validatePassword,
                textInputType: TextInputType.visiblePassword,
                obscureText: !controller.showPassword.value,
                suffixIcon: _PasswordToggleIcon(
                  controller: controller,
                ),
              ),
            ),
            const AppSpacing(v: 10),

            // Confirm password
            Obx(
                  () => AppTextInputField(
                maxLines: 1,
                labelText: 'Confirm New Password',
                onChanged: controller.onConfirmPasswordInputChanged,
                validator: controller.validatePasswordConfirmation,
                obscureText: !controller.showPassword.value,
                textInputType: TextInputType.visiblePassword,
                suffixIcon: _PasswordToggleIcon(
                  controller: controller,
                ),
              ),
            ),
            const AppSpacing(v: 16),

            Obx(
                  () => AppButton(
                text: controller.isLoading.value
                    ? 'Updating...'
                    : 'Change Password',
                onPressed: controller.onChangePassword,
                enabled: controller.isFormValid.value &&
                    !controller.isLoading.value,
              ),
            ),
            const AppSpacing(v: 16),
          ],
        ),
      ),
    );
  }
}

// ─── Reusable password visibility toggle ─────────────────────────────────────

class _PasswordToggleIcon extends StatelessWidget {
  const _PasswordToggleIcon({required this.controller});

  final MoreController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      reverseDuration: Duration.zero,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0, end: 1.0).animate(animation),
          child: child,
        );
      },
      switchInCurve: Curves.elasticOut,
      duration: const Duration(milliseconds: 700),
      child: IconButton(
        key: ValueKey<bool>(controller.showPassword.value),
        onPressed: controller.togglePassword,
        icon: Obx(
              () => Icon(
            controller.showPassword.value
                ? Icons.visibility
                : Icons.visibility_off,
            size: 20,
          ),
        ),
      ),
    );
  }
}