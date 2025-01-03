import 'package:automanager/feature/authentication/data/data.dart';
import 'package:automanager/feature/authentication/data/data.dart';
import 'package:automanager/feature/auto_manager/domain/domain.dart';
import 'package:automanager/feature/auto_manager/presentation/presentation.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/presentation/routes/app_routes.dart';
import '../../../../../core/presentation/utils/utils.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../data/model/response/listpage/listpage.dart';
import '../../../domain/usecase/role/fetch_roles.dart';

class UserAccountController extends GetxController {
  UserAccountController({
    required this.addUser,
    required this.fetchUsers,
    required this.updateUser,
    required this.deleteUser,
    required this.fetchRoles,
  });

  final AddUser addUser;
  final UpdateUser updateUser;
  final FetchUsers fetchUsers;
  final DeleteUser deleteUser;
  final FetchRoles fetchRoles;

  //reactive variables
  final RxInt totalCount = 0.obs;
  final RxString query = ''.obs;
  final RxBool isLoading = false.obs;
  final RxString firstName = ''.obs;
  final RxString lastName = ''.obs;
  final RxString email = ''.obs;
  final RxString phone = ''.obs;
  final RxString address = ''.obs;
  final RxString password = ''.obs;
  final RxString passwordConfirmation = ''.obs;
  final RxBool showPassword = false.obs;
  final RxList<Role> roles = <Role>[].obs;
  final Rx<Role> selectedRole = Role.empty().obs;

  //paging controller
  final PagingController<int, User> pagingController =
      PagingController<int, User>(firstPageKey: 1);

  @override
  void onInit() {
    pagingController.addPageRequestListener((int pageKey) {
      getUsers(pageKey);
    });
    super.onInit();
  }

  void getRoles() async {
    isLoading(true);
    final Either<Failure, List<Role>> failureOrRoles =
    await fetchRoles(NoParams());
    failureOrRoles.fold((Failure failure) {
      isLoading(false);
      AppSnack.show(message: failure.message, status: SnackStatus.error);
    }, (List<Role> rolesL) {
      isLoading(false);
      roles(rolesL);
    });
  }

  void updateUserAccount(String userId) async {
    isLoading(true);
    final UserRequest userRequest = UserRequest(
      id: userId,
      firstName: firstName.value.isNotEmpty ? firstName.value : null,
      lastName: lastName.value.isNotEmpty ? lastName.value : null,
      email: email.value.isNotEmpty ? email.value : null,
      phone: phone.value.isNotEmpty ? phone.value : null,
      address: address.value.isNotEmpty ? address.value : null,
      role: selectedRole.value.id.isNotEmpty ? selectedRole.value.id : null,
    );
    final Either<Failure, User> failureOrUser = await updateUser(userRequest);

    failureOrUser.fold((Failure failure) {
      isLoading(false);
      AppSnack.show(message: failure.message, status: SnackStatus.error);
    }, (User user) {
      isLoading(false);
      pagingController.refresh();
      Get.back<dynamic>(result: user);
    });
  }

  void deleteUserAccount(String userId) async {
    isLoading(true);
    final Either<Failure, User> failureOrUser = await deleteUser(userId);
    failureOrUser.fold((Failure failure) {
      isLoading(false);
      AppSnack.show(message: failure.message, status: SnackStatus.error);
    }, (User user) {
      isLoading(false);
      AppSnack.show(
          message: 'User Account Deleted Successfully',
          status: SnackStatus.success);
      pagingController.refresh();
    });
  }

  void addUserAccount() async {
    final UserRequest userRequest = UserRequest(
      firstName: firstName.value,
      lastName: lastName.value,
      email: email.value,
      phone: phone.value,
      address: address.value,
      password: password.value,
      role: selectedRole.value.id.toString(),
    );
    isLoading(true);
    final Either<Failure, User> failureOrUser = await addUser(userRequest);

    failureOrUser.fold((Failure failure) {
      isLoading(false);
      AppSnack.show(message: failure.message, status: SnackStatus.error);
    }, (User user) {
      isLoading(false);
      pagingController.refresh();
      Get.back<dynamic>(result: user);
    });
  }

  void getUsers(int pageKey) async {
    isLoading(true);
    final Either<Failure, ListPage<User>> failureOrUsers =
        await fetchUsers(PageParams(
      pageIndex: pageKey,
      pageSize: 10,
      query: query.value,
    ));
    failureOrUsers.fold((Failure failure) {
      isLoading(false);
      pagingController.error = failure;
    }, (ListPage<User> newPage) {
      isLoading(false);

      //get meta data
      final Map<String, dynamic>? meta = newPage.metaData;
      if (meta != null) {
        totalCount(meta['totalCount']);
      }
      //check if the new page is the last page
      final int previouslyFetchedItemsCount =
          pagingController.itemList?.length ?? 0;

      final bool isLastPage = newPage.isLastPage(previouslyFetchedItemsCount);
      final List<User> newItems = newPage.itemList;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final int nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
    });
  }

  void onRoleSelected(Role role) {
    selectedRole(role);
  }

  void onSearchQuerySubmitted() {
    pagingController.refresh();
  }

  void clearFields() {
    firstName('');
    lastName('');
    email('');
    phone('');
    address('');
    password('');
    selectedRole(Role.empty());
  }

  void onSearchFieldInputChanged(String value) {
    query(value);
  }

  void navigateToAddUserScreen() async {
    final dynamic result = await Get.toNamed(AppRoutes.addUser);
    if (result != null) {
      AppSnack.show(
        message: 'User added successfully',
        status: SnackStatus.success,
      );
    }
  }

  void navigateToUpdateUserScreen(User user) async {
    final dynamic result = await Get.toNamed(AppRoutes.addUser,
        arguments: UserAccountArgument(user));
    if (result != null) {
      AppSnack.show(
        message: 'User updated successfully',
        status: SnackStatus.success,
      );
    }
  }

  void togglePassword() {
    showPassword(!showPassword.value);
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

  void onPhoneInputChanged(String value) {
    phone(value);
  }

  void onAddressInputChanged(String value) {
    address(value);
  }

  void onPasswordInputChanged(String value) {
    password(value);
  }

  void onConfirmPasswordInputChanged(String value) {
    passwordConfirmation(value);
  }


  String? validatePasswordConfirmation(String? value) {
    String? errorMessage;
    if (value!.isEmpty || value != password.value) {
      errorMessage = 'Password do not match';
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



  String? validateField(String? value) {
    String? errorMessage;
    if (value!.isEmpty) {
      errorMessage = 'Field is required';
    }
    return errorMessage;
  }


  RxBool get clientFormIsValid => (validateEmail(email.value) == null &&
      validatePasswordConfirmation(passwordConfirmation.value) == null &&
      validateField(firstName.value) == null &&
      validateField(phone.value) == null &&
      validateField(lastName.value) == null &&
      validatePassword(password.value) == null &&
      validateField(selectedRole.value.name) == null )
      .obs;
}
