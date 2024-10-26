import 'package:automanager/core/presentation/widgets/app_otp_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/utils/utils.dart';
import '../../../../../core/presentation/widgets/animated_column.dart';
import '../../../../../core/presentation/widgets/app_button.dart';
import '../../../../../core/presentation/widgets/app_text_input_field.dart';
import '../getx/signup_controller.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildSignUpFormPage(context);
  }

  Scaffold _buildSignUpFormPage(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Sign Up'),
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: Obx(
          () => controller.pageIndex.value == 0 ? AppButton(
            enabled: !controller.isLoading.value &&
                controller.clientFormIsValid.value,
            onPressed: () {
              controller.signUp();
            },
            text: 'Continue',
            // fontSize: 18,
          ): const SizedBox.shrink(),
        ),
      ),
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
        child: FutureBuilder<String>(
          future: controller.currentPageFuture,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if(snapshot.hasData){
              return PageView(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                // physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  SingleChildScrollView(
                    child: AppAnimatedColumn(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        _buildLogo(context),
                        _buildPersonalProfilePage(context),
                      ],
                    ),
                  ),
                  _buildOtpVerificationPage(context),
                ],
              );
            }else{
              return const SizedBox.shrink();
            }
          }
        ),
      ),
    );
  }

  Widget _buildOtpVerificationPage(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.zero,
        child: AppAnimatedColumn(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildLogo(context),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Obx(
                  () => AppOtp(
                    fieldCount: 6,
                    onCompleted: (String otp) {
                      controller.otpVerificationCode(otp);
                    },
                   // errorColor: Colors.red,
                    hasError: controller.wrongOtp.value, // Set to true to show error color
                  ),
                ),
                const AppSpacing(
                  v: 10,
                ),
                Row(
                  children: [
                    const Text(
                      'Please enter the OTP sent to ',
                      textAlign: TextAlign.start,
                    ),
                   Obx(() =>Text(
                        controller.email.value,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalProfilePage(
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AppAnimatedColumn(
            children: <Widget>[
              AppTextInputField(
                labelText: 'First Name',
                onChanged: controller.onFirstNameInputChanged,
                validator: controller.validateName,
              ),
              const AppSpacing(
                v: 10,
              ),
              AppTextInputField(
                labelText: 'Last Name',
                onChanged: controller.onLastNameInputChanged,
                validator: controller.validateName,
              ),
              const AppSpacing(
                v: 10,
              ),
              AppTextInputField(
                labelText: 'Email',
                onChanged: controller.onEmailInputChanged,
                validator: controller.validateEmail,
              ),
              const AppSpacing(
                v: 10,
              ),
              AppTextInputField(
                labelText: 'Phone number',
                onChanged: controller.onPhoneInputChanged,
                textInputType: TextInputType.phone,
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
                  labelText: 'Confirm Password',
                  onChanged: controller.onPasswordConfirmationInputChanged,
                  validator: controller.validatePasswordConfirmation,
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Image.asset(
      context.isDarkMode ? AssetImages.appLogoWhite : AssetImages.appLogoBlack,
      height: 200,
      width: 200,
    );
  }
}
