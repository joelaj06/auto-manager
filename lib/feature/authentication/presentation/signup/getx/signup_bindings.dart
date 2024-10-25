
import 'package:automanager/feature/authentication/domain/usecase/verifyRegistrationOtp.dart';
import 'package:get/get.dart';
import '../../../domain/usecase/signup.dart';
import 'signup_controller.dart';

class SignUpBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>( () =>
      SignUpController(
        userSignUp: UserSignUp(
          authRepository: Get.find(),
        ), verifyRegistrationOtp: VerifyRegistrationOtp(
        authRepository: Get.find(),
      ),
      ),
    );
  }
}
