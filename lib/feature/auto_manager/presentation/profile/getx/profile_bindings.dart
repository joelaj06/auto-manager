import 'package:automanager/feature/authentication/domain/domain.dart';
import 'package:automanager/feature/auto_manager/domain/domain.dart';
import 'package:get/get.dart';

import 'profile_controller.dart';

class ProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController(
        fetchUser: FetchUser(
          autoManagerRepository: Get.find(),
        ),
        updateUserProfile: UpdateUserProfile(
          autoManagerRepository: Get.find(),
        ),
        loadUser: LoadUser(authRepository: Get.find())));
  }
}
