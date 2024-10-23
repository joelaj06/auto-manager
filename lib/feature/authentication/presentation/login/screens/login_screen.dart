import 'package:automanager/core/presentation/utils/app_image_assets.dart';
import 'package:automanager/core/presentation/utils/app_padding.dart';
import 'package:automanager/core/presentation/utils/app_spacing.dart';
import 'package:automanager/core/presentation/widgets/animated_column.dart';
import 'package:automanager/feature/authentication/presentation/login/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/widgets/widgets.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNavBar(context),
      body: Container(
        padding: AppPaddings.lA,
        height: context.height,
        width: context.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetImages.loginBackground),
            opacity: 0.1,
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: AppAnimatedColumn(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const AppSpacing(v: 100),
              _buildLogo(context),
              _buildForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('Don\'t have an account? '),
          TextButton(
            onPressed: () {
              controller.navigateToSignUpScreen();
            },
            child: const Text(
              'Register',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildForm() {
    return AutofillGroup(
      child: AppAnimatedColumn(
        children: <Widget>[
          AppTextInputField(
            labelText: 'Email',
            hintText: 'user@mail.com',
            onChanged: controller.onEmailInputChanged,
            validator: controller.validateEmail,
            maxLines: 1,
            textInputType: TextInputType.emailAddress,
            autofillHints: const <String>[AutofillHints.email],
          ),
          const AppSpacing(
            v: 10,
          ),
          Obx(
            () => AppTextInputField(
              maxLines: 1,
              labelText: 'Password',
              onChanged: controller.onPasswordInputChanged,
              validator: controller.validatePassword,
              obscureText: !controller.showPassword.value,
              autofillHints: const <String>[AutofillHints.password],
              onEditingComplete: () => TextInput.finishAutofillContext(),
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
            v: 20,
          ),
          Obx(
            () => AppButton(
              key: const Key('loginButton'),
              onPressed: () => controller.login,
              text: 'Login',
              enabled: controller.formIsValid.value,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Padding(
      padding: AppPaddings.mA,
      child: Image.asset(
        context.isDarkMode
            ? AssetImages.appLogoWhite
            : AssetImages.appLogoBlack,
        height: 300,
        width: 300,
      ),
    );
  }
}
