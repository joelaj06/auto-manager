import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/utils/utils.dart';
import '../../../../../core/presentation/widgets/widgets.dart';
import '../user_account.dart';

class AddUserScreen extends GetView<UserAccountController> {
  const AddUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserAccountArgument? args = Get.arguments as UserAccountArgument?;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          args != null ? 'Edit Customer' : 'New Customer',
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context, arg: args),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPaddings.mA,
          child: Column(
            children: <Widget>[
              AppTextInputField(
                labelText: 'First Name',
                onChanged: controller.onFirstNameInputChanged,
                validator: controller.validateField,
                initialValue: args != null ? args.user.firstName : '',
              ),
              const AppSpacing(v: 10),
              AppTextInputField(
                labelText: 'Last Name',
                onChanged: controller.onLastNameInputChanged,
                validator: controller.validateField,
                initialValue: args != null ? args.user.lastName : '',
              ),
              const AppSpacing(v: 10),
              AppTextInputField(
                labelText: 'Email',
                onChanged: controller.onEmailInputChanged,
                initialValue: args != null ? args.user.email : '',
              ),
              const AppSpacing(v: 10),
              AppTextInputField(
                labelText: 'Phone',
                onChanged: controller.onPhoneInputChanged,
                textInputType: TextInputType.phone,
                validator: controller.validateField,
                initialValue: args != null ? args.user.phone : '',
              ),
              const AppSpacing(v: 10),
             if (args != null) const SizedBox.shrink() else Obx(
                () => AppTextInputField(
                  maxLines: 1,
                  labelText: 'Password',
                  onChanged: controller.onPasswordInputChanged,
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
              if (args != null) const SizedBox.shrink() else Obx(
                () => AppTextInputField(
                  maxLines: 1,
                  labelText: 'Confirm Password',
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context,
      {required UserAccountArgument? arg}) {
    return Padding(
      padding: AppPaddings.mA,
      child: SizedBox(
        height: 70,
        child: Obx(
          () => AppButton(
            text: arg != null ? 'Update' : 'Save',
            onPressed: () {
              arg != null
                  ? controller.updateUserAccount(arg.user.id)
                  : controller.addUserAccount();
            },
            enabled: arg != null
                ? !controller.isLoading.value
                : controller.clientFormIsValid.value &&
                    !controller.isLoading.value,
          ),
        ),
      ),
    );
  }
}
