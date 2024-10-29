import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/presentation/routes/app_routes.dart';
import '../../../../../core/presentation/utils/utils.dart';
import '../../../data/models/models.dart';
import '../../../domain/usecase/usecase.dart';
class LoginController extends GetxController{

  LoginController({required this.loginUser,
    required this.loadUser,});

  final LoginUser loginUser;
  final LoadUser loadUser;

  RxBool showPassword = false.obs;
  RxBool isLoading = false.obs;
  RxString email = ''.obs;
  RxString password = ''.obs;

 // final SharedPreferencesWrapper _sharedPreferencesWrapper = Get.find();

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  void loadUserData() async {
    // ignore: unawaited_futures
    isLoading(true);

    final Either<Failure, User> failureOrUser = await loadUser(null);

    // ignore: unawaited_futures
    failureOrUser.fold(
          (Failure failure) {
        isLoading(false);
      },
          (User user) {
        isLoading(false);
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

  void navigateToSignUpScreen() async{
    final dynamic result = await Get.toNamed<dynamic>(AppRoutes.signup);
    if(result != null){
      AppSnack.show(message: 'User account created successfully',
          status: SnackStatus.success);

    }
  }


  void togglePassword(){
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
    final  RegExp emailPattern = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!emailPattern.hasMatch(email!)) {
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

  RxBool get formIsValid =>
      (validateEmail(email.value) == null &&
          validatePassword(password.value) == null).obs;

}