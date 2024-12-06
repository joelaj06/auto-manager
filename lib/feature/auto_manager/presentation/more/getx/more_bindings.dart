import 'package:get/get.dart';

import '../../../../authentication/domain/usecase/logout.dart';
import 'more_controller.dart';

class MoreBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MoreController>(() => MoreController(
      logout: Logout(authRepository: Get.find()),
    ));
  }

}