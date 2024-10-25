import 'package:automanager/feature/authentication/domain/usecase/verifyRegistrationOtp.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/presentation/utils/utils.dart';
import '../../../data/models/models.dart';
import '../../../domain/usecase/signup.dart';

class SignUpController extends GetxController {
  SignUpController(
      {required this.userSignUp, required this.verifyRegistrationOtp});

  final UserSignUp userSignUp;
  final VerifyRegistrationOtp verifyRegistrationOtp;

  //reactive variables
  final RxInt pageIndex = 0.obs;
  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  RxString email = ''.obs;
  RxString phone = ''.obs;
  RxString password = ''.obs;
  RxString passwordConfirmation = ''.obs;
  RxBool showPassword = false.obs;
  RxBool isLoading = false.obs;
  Rx<User> user = User.empty().obs;
  RxString otpCode = ''.obs;
  RxBool wrongOtp = false.obs;
  Rx<UserRegistration> registrationResponse = UserRegistration.empty().obs;

  final PageController pageController = PageController(initialPage: 0);

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void verifyUserOtp() async {
    final OtpVerificationRequest otpVerificationRequest =
        OtpVerificationRequest(
            otp: otpCode.value.trim(),
            userId: registrationResponse.value.data?.userId ?? '');
    isLoading(true);
    final Either<Failure, UserRegistration> failureOrUser =
        await verifyRegistrationOtp(otpVerificationRequest);
    failureOrUser.fold(
      (Failure failure) {
        wrongOtp(true);
        isLoading(false);
        AppSnack.show(
            title: '', message: failure.message, status: SnackStatus.error);
      },
      (UserRegistration userRes) {
        wrongOtp(false);
        isLoading(false);
        AppSnack.show(
            title: '', message: userRes.message, status: SnackStatus.success);
      },
    );
  }

  void signUp() async {
    isLoading(true);
    final UserRequest userRequest = UserRequest(
      lastName: lastName.value.trim(),
      firstName: firstName.value.trim(),
      email: email.value.trim(),
      phone: phone.value.trim(),
      password: password.value,
      confirmPassword: null,
      isActive: true,
      isVerified: false,
    );
    final Either<Failure, UserRegistration> failureOrUser =
        await userSignUp(userRequest);
    failureOrUser.fold(
      (Failure failure) {
        isLoading(false);
        AppSnack.show(
            title: '', message: failure.message, status: SnackStatus.error);
      },
      (UserRegistration userRes) {
        isLoading(false);
        registrationResponse(userRes);
        AppSnack.show(
            title: '', message: userRes.message, status: SnackStatus.success);
        navigatePages(1);
      },
    );
  }

  void togglePassword() {
    showPassword(!showPassword.value);
  }

  void onPageChanged(int index) {
    pageIndex(index);
  }

  void navigatePages(int value) {
    pageController.animateToPage(value,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  void otpVerificationCode(String value) {
    otpCode(value);
    if (otpCode.value.length == 6) {
      verifyUserOtp();
    }
  }

  void onFirstNameInputChanged(String value) {
    firstName(value);
  }

  void onPhoneInputChanged(String value) {
    phone(value);
  }

  void onLastNameInputChanged(String value) {
    lastName(value);
  }

  void onEmailInputChanged(String value) {
    email(value);
  }

  void onPasswordInputChanged(String value) {
    password(value);
  }

  void onPasswordConfirmationInputChanged(String value) {
    passwordConfirmation(value);
  }

  String? validatePasswordConfirmation(String? value) {
    String? errorMessage;
    if (value!.isEmpty || value != password.value) {
      errorMessage = 'Password do not match';
    }
    return errorMessage;
  }

  String? validateName(String? value) {
    String? errorMessage;
    if (value!.isEmpty) {
      errorMessage = 'Field must not be empty';
    }
    return errorMessage;
  }

  String? validateEmail(String? email) {
    String? errorMessage;
    // Check if email is empty
    if (email == null || email.isEmpty) {
      errorMessage = 'Please enter an email address';
    }

    // Regular expression for validating an email address
    final RegExp emailPattern = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    // Check if email is valid using regex
    if (!emailPattern.hasMatch(email!)) {
      errorMessage = 'Please enter a valid email address';
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

  RxBool get clientFormIsValid => (validateEmail(email.value) == null &&
          validatePasswordConfirmation(passwordConfirmation.value) == null &&
          validateName(firstName.value) == null &&
          validateName(phone.value) == null &&
          validateName(lastName.value) == null &&
          validatePassword(password.value) == null)
      .obs;
}
