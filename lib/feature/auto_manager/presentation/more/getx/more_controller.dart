import 'package:automanager/feature/authentication/data/data.dart';
import 'package:automanager/feature/authentication/data/data.dart';
import 'package:automanager/feature/authentication/data/data.dart';
import 'package:automanager/feature/authentication/data/data.dart';
import 'package:automanager/feature/authentication/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/presentation/routes/app_routes.dart';
import '../../../../../core/presentation/utils/app_snack.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../../authentication/data/models/response/generic/message_response.dart';
import '../../../../authentication/domain/usecase/logout.dart';

class MoreController extends GetxController {
  MoreController({
    required this.logout,
    required this.changePassword,
  });

  final Logout logout;
  final ChangePassword changePassword;

  //reactive variables
  RxBool isDarkMode = (Get.isDarkMode).obs;
  RxString oldPassword = ''.obs;
  RxString newPassword = ''.obs;
  RxString confirmPassword = ''.obs;
  RxBool showPassword = false.obs;
  RxBool isLoading = false.obs;

  void onChangePassword() async {
    final ChangePasswordRequest changePasswordRequest = ChangePasswordRequest(
      currentPassword: oldPassword.value,
      newPassword: newPassword.value,
    );
    isLoading(true);
    final Either<Failure, User> failureOrUser =
        await changePassword(changePasswordRequest);
    failureOrUser.fold(
      (Failure failure) {
        isLoading(false);
        AppSnack.show(message: failure.message, status: SnackStatus.error);
      },
      (_) {
        isLoading(false);
        Get.back();
        AppSnack.show(
          message: 'Password updated',
          status: SnackStatus.success,
        );
      },
    );
  }

  void logUserOut() async {
    final Either<Failure, MessageResponse> failureOrMessageResponse =
        await logout(NoParams());

    failureOrMessageResponse.fold((Failure failure) {
      AppSnack.show(message: failure.message, status: SnackStatus.error);
    }, (MessageResponse messageResponse) {
      Get.offAllNamed(AppRoutes.login);
    });
  }

  void onOldPasswordInputChanged(String value) {
    oldPassword(value);
  }

  void onNewPasswordInputChanged(String value) {
    newPassword(value);
  }

  void onConfirmPasswordInputChanged(String value) {
    confirmPassword(value);
  }

  void toggleTheme() {
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.light : ThemeMode.dark);
    isDarkMode(!isDarkMode.value);
  }

  void togglePassword() {
    showPassword(!showPassword.value);
  }

  String? validatePasswordConfirmation(String? value) {
    String? errorMessage;
    if (value!.isEmpty || value != newPassword.value) {
      errorMessage = 'Password do not match';
    }
    return errorMessage;
  }

  String? validatePassword(String? password) {
    String? errorMessage;
    if (password!.isNotEmpty) {
      if (password.length < 8) {
        errorMessage = 'Password must be 8 characters or more';
      }
    } else {
      errorMessage = 'Please enter password';
    }
    return errorMessage;
  }

  RxBool get isFormValid => (validatePassword(oldPassword.value) == null &&
          validatePassword(newPassword.value) == null &&
          validatePasswordConfirmation(confirmPassword.value) == null)
      .obs;
}
