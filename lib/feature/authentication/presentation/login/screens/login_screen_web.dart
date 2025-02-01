import 'package:automanager/core/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/utils/utils.dart';
import '../../../../../core/presentation/widgets/widgets.dart';
import '../getx/login_controller.dart';

class LoginScreenWeb extends GetView<LoginController> {
  const LoginScreenWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  bottomNavigationBar: _buildBottomNavBar(context),
      body: Obx(
        () => controller.isLoadingLocalData.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding: AppPaddings.mA,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AssetImages.patternBgFull),
                    opacity: 0.02,
                    fit: BoxFit.cover,
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: _buildCoverImage(context),
                        ),
                      ),
                    ),
                    const AppSpacing(h: 20),
                    Expanded(
                      child: Container(
                        padding: AppPaddings.bodyA
                            .add(AppPaddings.bodyA)
                            .add(AppPaddings.bodyH.add(AppPaddings.bodyH)),
                        child: SingleChildScrollView(
                          child: AppAnimatedColumn(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Login to your account',
                                style: context.h2,
                                textAlign: TextAlign.left,
                              ),
                              const AppSpacing(v: 20),
                              _buildForm(),
                            ],
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

  Widget _buildCoverImage(BuildContext context) {
    return SizedBox.expand(
      // Ensures Stack takes full available space
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            // Makes the container fill the parent
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AssetImages.openDoorCar),
                  fit: BoxFit.cover, // Covers the entire container
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Colors.transparent,
                    Colors.black.withOpacity(0.9),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: AppPaddings.lA.add(AppPaddings.lB),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  AppAnimatedColumn(
                    duration: const Duration(seconds: 2),
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Streamlined Vehicle and Rental Management',
                        textAlign: TextAlign.center,
                        style: context.h4.copyWith(color: Colors.white),
                      ),
                      const AppSpacing(v: 10),
                      Text(
                        'Effortlessly manage your fleet, drivers,\n and rentals all '
                        'in one place',
                        style: context.h6.copyWith(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const AppSpacing(v: 20),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            width: 150,
            height: 150,
            child: Image.asset(
              AssetImages.logoWhite,
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
              backgroundColor: Colors.black,
              padding: AppPaddings.mA,
              onPressed: () => controller.login(),
              text: controller.isLoading.value ? 'Loading...' : 'Login',
              enabled:
                  !controller.isLoading.value && controller.formIsValid.value,
            ),
          ),
          Center(
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => controller.navigateToPasswordResetScreen(),
                child: const Text(
                  'Forgot your password?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


}
