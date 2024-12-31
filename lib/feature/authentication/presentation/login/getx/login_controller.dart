import 'package:automanager/core/core.dart';
import 'package:automanager/core/utils/validators.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/presentation/routes/app_routes.dart';
import '../../../../../core/presentation/utils/utils.dart';
import '../../../data/models/models.dart';
import '../../../domain/usecase/usecase.dart';

class LoginController extends GetxController {
  LoginController(
      {required this.loginUser,
      required this.loadUser,
      required this.resetPassword,
      required this.verifyPasswordReset});

  final LoginUser loginUser;
  final LoadUser loadUser;
  final ResetPassword resetPassword;
  final VerifyPasswordReset verifyPasswordReset;

  RxBool showPassword = false.obs;
  RxString email = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingLocalData = false.obs;
  RxString password = ''.obs;
  RxString passwordResetEmail = ''.obs;
  RxString passwordResetNewPassword = ''.obs;
  RxString passwordResetOtp = ''.obs;
  RxString userEmail = ''.obs;
  Rx<MessageResponse> messageResponse = const MessageResponse().obs;
  RxBool isWrongOtp = false.obs;

  late final PageController pageController;

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    loadUserData();
    super.onInit();
  }

  void verifyUserPasswordReset() async {
    isLoading(true);
    final Either<Failure, MessageResponse> failureOrMessageResponse =
        await verifyPasswordReset(
      PasswordResetRequest(
        email: messageResponse.value.data?.email ?? '',
        userId: messageResponse.value.data?.userId ?? '',
        newPassword: passwordResetNewPassword.value,
        otp: passwordResetOtp.value,
      ),
    );
    failureOrMessageResponse.fold(
      (Failure failure) {
        isLoading(false);
        if (failure.message.toLowerCase().contains('otp')) {
          isWrongOtp(true);
        }
        AppSnack.show(message: failure.message, status: SnackStatus.error);
      },
      (MessageResponse res) {
        isLoading(false);
        isWrongOtp(false);
        AppSnack.show(message: res.message!, status: SnackStatus.success);
        Get.toNamed<void>(AppRoutes.login);
      },
    );
  }

  void resetUserPassword() async {
    isLoading(true);
    final Either<Failure, MessageResponse> failureOrMessageResponse =
        await resetPassword(
            PasswordResetRequest(email: passwordResetEmail.value.trim()));
    failureOrMessageResponse.fold(
      (Failure failure) {
        isLoading(false);
        AppSnack.show(message: failure.message, status: SnackStatus.error);
      },
      (MessageResponse res) {
        messageResponse(res);
        isLoading(false);
        AppSnack.show(
          message: 'An OTP has been sent to your email',
          status: SnackStatus.success,
        );
        navigatePages(1);
      },
    );
  }

  void loadUserData() async {
    // ignore: unawaited_futures
    isLoadingLocalData(true);

    final Either<Failure, User> failureOrUser = await loadUser(null);

    // ignore: unawaited_futures
    failureOrUser.fold(
      (Failure failure) {
        isLoadingLocalData(false);
      },
      (User user) {
        isLoadingLocalData(false);
        Get.offAllNamed<void>(AppRoutes.base);
      },
    );
  }

  void login() async {
    // ignore: unawaited_futures
    isLoading(true);
    /* final String token =
    await _sharedPreferencesWrapper.getString(SharedPrefsKeys.fcmToken);
*/
    final Either<Failure, User> failureOrUser = await loginUser(
      LoginRequest(
        email: email.value,
        password: password.value,
        deviceToken: null,
      ),
    );
    // ignore: unawaited_futures
    failureOrUser.fold(
      (Failure failure) {
        isLoading(false);
        AppSnack.show(message: failure.message, status: SnackStatus.error);
      },
      (User user) {
        isLoading(false);
        AppSnack.show(message: 'Login Successful', status: SnackStatus.success);
        Get.toNamed<dynamic>(AppRoutes.base);
      },
    );
  }

  void navigatePages(int index) {
    if (pageController.hasClients) {
      final int nextPage = pageController.page!.toInt() + 1;
      pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void navigateToPasswordResetScreen() {
    Get.toNamed<dynamic>(AppRoutes.passwordReset);
  }

  void navigateToSignUpScreen() async {
    final dynamic result = await Get.toNamed<dynamic>(AppRoutes.signup);
    if (result != null) {
      AppSnack.show(
          message: 'User account created successfully',
          status: SnackStatus.success);
    }
  }

  void onResetPasswordNewPasswordInputChanged(String value) {
    passwordResetNewPassword(value);
  }

  void onOtpVerificationCodeInputChanged(String value) {
    passwordResetOtp(value);
  }

  void onResetPasswordEmailInputChanged(String value) {
    passwordResetEmail(value);
  }

  void togglePassword() {
    showPassword(!showPassword.value);
  }

  void onEmailInputChanged(String value) {
    email(value);
  }

  void onPasswordInputChanged(String value) {
    password(value);
  }

  String? validateEmail(String? email) {
    String? errorMessage;

    // Check if email is empty
    if (email == null || email.isEmpty) {
      errorMessage = 'Please enter an email address';
    }

    // Regular expression for validating an email address
    if (!Validators.isEmail(email!)) {
      errorMessage = 'Please enter a valid email address';
    }

    return errorMessage; // Return null if no error
  }

  String? validatePassword(String? password) {
    String? errorMessage;
    if (password!.isEmpty) {
      errorMessage = 'Please enter password';
    }
    return errorMessage;
  }

  RxBool get otpVerificationFormIsValid =>
      (validatePassword(passwordResetNewPassword.value) == null &&
              passwordResetOtp.value.length == 6)
          .obs;

  RxBool get resetPasswordFormIsValid =>
      (validateEmail(passwordResetEmail.value) == null).obs;

  RxBool get formIsValid => (validateEmail(email.value) == null &&
          validatePassword(password.value) == null)
      .obs;
}
