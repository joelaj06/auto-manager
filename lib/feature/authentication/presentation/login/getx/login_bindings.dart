import 'package:automanager/feature/authentication/domain/domain.dart';
import 'package:get/get.dart';
import 'login_controller.dart';

class LoginBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<LoginController>( () =>
      LoginController(
        loginUser: LoginUser(
          authRepository: Get.find()
        ),
        loadUser: LoadUser(
          authRepository: Get.find()
        ),
      ),
    );
  }

}