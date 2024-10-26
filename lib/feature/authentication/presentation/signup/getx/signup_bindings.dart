
import 'package:automanager/feature/authentication/domain/domain.dart';
import 'package:get/get.dart';
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
      ), loadUserSignupData: LoadUserSignupData(
        authRepository: Get.find(),
      ),
      ),
    );
  }
}
