import 'package:automanager/feature/authentication/domain/domain.dart';
import 'package:get/get.dart';

import 'more_controller.dart';

class MoreBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MoreController>(() => MoreController(
          logout: Logout(authRepository: Get.find()),
          changePassword: ChangePassword(
            authRepository: Get.find(),
          ),
        ));
  }
}
