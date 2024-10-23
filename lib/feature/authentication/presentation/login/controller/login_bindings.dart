import 'package:get/get.dart';
import '../login.dart';

class LoginBindings extends Bindings{
  @override
  void dependencies() {
    Get.put<LoginController>(
      LoginController(),
    );
  }

}