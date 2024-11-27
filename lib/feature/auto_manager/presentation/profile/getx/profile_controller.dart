import 'package:automanager/core/core.dart';
import 'package:automanager/feature/authentication/data/data.dart';
import 'package:automanager/feature/auto_manager/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../authentication/domain/usecase/load_user.dart';

class ProfileController extends GetxController {
  ProfileController(
      {required this.fetchUser,
      required this.updateUserProfile,
      required this.loadUser});

  final FetchUser fetchUser;
  final UpdateUserProfile updateUserProfile;
  final LoadUser loadUser;

  //reactive variables
  Rx<User> user = User.empty().obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingUserData = false.obs;
  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  RxString email = ''.obs;
  RxString address = ''.obs;
  RxString phone = ''.obs;
  RxString imgUrl = ''.obs;
  final Rx<User> userPrefs = User.empty().obs;

  final TextEditingController firstNameTextEditingController =
      TextEditingController();

  final TextEditingController lastNameTextEditingController =
      TextEditingController();

  final TextEditingController emailTextEditingController =
      TextEditingController();

  final TextEditingController phoneTextEditingController =
      TextEditingController();

  @override
  void onInit() {
    loadUserData();

    super.onInit();
  }

  void updateProfile() async {
    isLoading(true);
    final UserRequest userRequest = UserRequest(
      id: user.value.id,
      firstName: firstName.isNotEmpty ? firstName.value.trim() : null,
      lastName: lastName.isNotEmpty ? lastName.value.trim() : null,
      email: email.isNotEmpty ? email.value.trim() : null,
      //address: user.value.address.trim(),
      phone: phone.isNotEmpty ? phone.value.trim() : null,
      image: imgUrl.isNotEmpty ? imgUrl.value : null,
    );

    final Either<Failure, User> failureOrUser =
        await updateUserProfile(userRequest);
    failureOrUser.fold((Failure failure) {
      isLoading(false);
      AppSnack.show(
          message: failure.message, status: SnackStatus.error);
    }, (User userProfile) {
      isLoading(false);
      user(userProfile);
      AppSnack.show(message: 'User updated', status: SnackStatus.success);
    });
  }

  void fetchProfile(String userId) async {
    isLoadingUserData(true);
    final Either<Failure, User> failureOrUser =
        await fetchUser(userId);
    failureOrUser.fold((Failure failure) {
      isLoadingUserData(false);
      AppSnack.show(message: failure.message, status: SnackStatus.error);
    }, (User userProfile) {
      isLoadingUserData(false);
      user(userProfile);
      updateControllers(userProfile);
    });
  }

  void loadUserData() async {
    // ignore: unawaited_futures
    isLoadingUserData(true);

    final Either<Failure, User> failureOrUser = await loadUser(null);
    failureOrUser.fold(
      (Failure failure) {
        isLoadingUserData(false);
      },
      (User userRes) {
        isLoadingUserData(false);
        fetchProfile(userRes.id);
      },
    );
  }

  void updateControllers(User data){
    firstNameTextEditingController.text = data.firstName;
    lastNameTextEditingController.text = data.lastName;
    emailTextEditingController.text = data.email;
    phoneTextEditingController.text = data.phone ?? '';
  }

  void onFirstNameInputChanged(String value) {
    firstName(value);
  }

  void onLastNameInputChanged(String value) {
    lastName(value);
  }

  void onEmailInputChanged(String value) {
    email(value);
  }

  void emailInputChanged(String value) {
    email(value);
  }

  void onPhoneInputChanged(String value) {
    phone(value);
  }
}
