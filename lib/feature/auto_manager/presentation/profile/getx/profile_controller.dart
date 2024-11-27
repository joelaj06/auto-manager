import 'package:automanager/core/core.dart';
import 'package:automanager/feature/authentication/data/data.dart';
import 'package:automanager/feature/auto_manager/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

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

  ImagePicker picker = ImagePicker();

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
      image: imgUrl.value,
    );

    final Either<Failure, User> failureOrUser =
        await updateUserProfile(userRequest);
    failureOrUser.fold((Failure failure) {
      isLoading(false);
      AppSnack.show(message: failure.message, status: SnackStatus.error);
    }, (User userProfile) {
      isLoading(false);
      user(userProfile);

      AppSnack.show(message: 'User updated', status: SnackStatus.success);
    });
  }

  void fetchProfile(String userId) async {
    isLoadingUserData(true);
    final Either<Failure, User> failureOrUser = await fetchUser(userId);
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

  void addImage() async {
    await <Permission>[
      Permission.storage,
      Permission.camera,
    ].request();

    showImagePicker();
    /* if (statuses[Permission.storage]!.isGranted) {
      showImagePicker();
    } else {
      AppSnack.show(
        message: 'Permission not granted',
        status: SnackStatus.info,
      );
    }*/
  }

  void showImagePicker() async {
    final XFile? imageFile =
        await picker.pickImage(source: ImageSource.gallery);
    final double size = await Base64Convertor.checkImageSize(imageFile);
    if (size > 5) {
      AppSnack.show(
        message: 'Image should not exceed 5MB',
        status: SnackStatus.info,
      );

    } else{
      if (imageFile != null) {
        final String base64StringImage =
            Base64Convertor().imageToBase64(imageFile.path);
        imgUrl(base64StringImage.split('base64,').last);
      }
    }
  }

  void removeProfileImage() {
    imgUrl('');
  }

  void updateControllers(User data) {
    firstNameTextEditingController.text = data.firstName;
    lastNameTextEditingController.text = data.lastName;
    emailTextEditingController.text = data.email;
    phoneTextEditingController.text = data.phone ?? '';
    imgUrl(data.imgUrl ?? '');
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
