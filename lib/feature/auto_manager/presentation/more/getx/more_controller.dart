import 'package:automanager/core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/presentation/utils/app_snack.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../../authentication/data/models/response/generic/message_response.dart';
import '../../../../authentication/domain/usecase/logout.dart';

class MoreController extends GetxController {
  MoreController({required this.logout});

  final Logout logout;

  //reactive variables
  RxBool isDarkMode = (Get.isDarkMode).obs;

  void logUserOut() async {
    final Either<Failure, MessageResponse> failureOrMessageResponse =
        await logout(NoParams());

    failureOrMessageResponse.fold((Failure failure) {
      AppSnack.show(message: failure.message, status: SnackStatus.error);
    }, (MessageResponse messageResponse) {
      Get.offAllNamed(AppRoutes.login);
    });
  }

  void toggleTheme() {
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.light : ThemeMode.dark);
    isDarkMode(!isDarkMode.value);
  }
}
