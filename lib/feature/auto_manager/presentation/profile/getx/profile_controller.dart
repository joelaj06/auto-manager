import 'package:automanager/core/core.dart';
import 'package:automanager/feature/authentication/data/data.dart';
import 'package:automanager/feature/auto_manager/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  ProfileController({required this.fetchUser, required this.updateUserProfile});

  final FetchUser fetchUser;
  final UpdateUserProfile updateUserProfile;

  //reactive variables
  Rx<User> user = User.empty().obs;
  RxBool isLoading = false.obs;

  String userId = '';

  void updateProfile() async {
    isLoading(true);
    final UserRequest userRequest = UserRequest(
      id: user.value.id,
      firstName: user.value.firstName,
      lastName: user.value.lastName,
      email: user.value.email,
      address: user.value.address,
      phone: user.value.phone,
      image: user.value.imgUrl,
    );

    final Either<Failure, User> failureOrUser =
        await updateUserProfile(userRequest);
    failureOrUser.fold((Failure failure) {
      isLoading(false);
      AppSnack.show(
          message: 'Failed to update user', status: SnackStatus.error);
    }, (User userProfile) {
      isLoading(false);
      user(userProfile);
      AppSnack.show(message: 'User updated', status: SnackStatus.success);
    });
  }

  void fetchProfile() async {
    isLoading(true);
    final Either<Failure, User> failureOrUser = await fetchUser(userId);
    failureOrUser.fold((Failure failure) {
      isLoading(false);
      AppSnack.show(message: 'Failed to fetch user', status: SnackStatus.error);
    }, (User userProfile) {
      isLoading(false);
      user(userProfile);
    });
  }
}
