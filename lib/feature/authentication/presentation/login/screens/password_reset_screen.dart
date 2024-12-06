import 'package:automanager/core/core.dart';
import 'package:automanager/core/presentation/theme/app_theme.dart';
import 'package:automanager/feature/authentication/presentation/login/getx/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordResetScreen extends GetView<LoginController> {
  const PasswordResetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: controller.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            _buildResetInfoScreen(context),
            _buildOtpVerificationPage(context),
          ],
        ),
      ),
    );
  }

  Widget _buildResetInfoScreen(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppPaddings.mA.add(AppPaddings.bodyT),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              AssetImages.passwordReset,
              height: 200,
              width: 200,
            ),
            const AppSpacing(v: 20),
            Text(
              'Password Reset',
              style: context.h4.copyWith(fontWeight: FontWeight.bold),
            ),
            const AppSpacing(v: 10),
            const Text(
              'Enter your email address and we will '
              'an OTP to reset your password.',
              textAlign: TextAlign.center,
            ),
            const AppSpacing(v: 20),
            AppTextInputField(
              labelText: 'Email',
              textInputType: TextInputType.emailAddress,
              maxLines: 1,
              validator: controller.validateEmail,
              onChanged: controller.onResetPasswordEmailInputChanged,
            ),
            const AppSpacing(v: 20),
            Obx(
              () => AppButton(
                text: 'Continue',
                // fontSize: 18,
                onPressed: controller.resetUserPassword,
                enabled: controller.resetPasswordFormIsValid.value &&
                    !controller.isLoading.value,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpVerificationPage(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppPaddings.mA.add(AppPaddings.bodyT),
        child: AppAnimatedColumn(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              AssetImages.otp,
              height: 200,
              width: 200,
            ),
            const AppSpacing(v: 20),
            Text(
              'OTP Verification',
              style: context.h4.copyWith(fontWeight: FontWeight.bold),
            ),
            const AppSpacing(v: 10),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Obx(
                  () => AppOtp(
                    fieldCount: 6,
                    onCompleted: (String otp) {
                      controller.onOtpVerificationCodeInputChanged(otp);
                    },
                    // errorColor: Colors.red,
                    hasError: controller
                        .isWrongOtp.value, // Set to true to show error color
                  ),
                ),
                const AppSpacing(
                  v: 10,
                ),
                Row(
                  children: <Widget>[
                    const Text(
                      'Please enter the OTP sent to ',
                      textAlign: TextAlign.start,
                    ),
                    Obx(
                      () => Text(
                        controller.messageResponse.value.data?.email ??
                            'your email',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const AppSpacing(
                  v: 10,
                ),
                Obx(
                  () => AppTextInputField(
                    maxLines: 1,
                    labelText: 'Enter new password',
                    onChanged:
                        controller.onResetPasswordNewPasswordInputChanged,
                    validator: controller.validatePassword,
                    obscureText: !controller.showPassword.value,
                    textInputType: TextInputType.visiblePassword,
                    suffixIcon: AnimatedSwitcher(
                      reverseDuration: Duration.zero,
                      transitionBuilder:
                          (Widget? child, Animation<double> animation) {
                        final Animation<double> offset =
                            Tween<double>(begin: 0, end: 1.0)
                                .animate(animation);
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
                    text: 'Continue',
                    onPressed: controller.verifyUserPasswordReset,
                    enabled: !controller.isLoading.value &&
                        controller.otpVerificationFormIsValid.value,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
