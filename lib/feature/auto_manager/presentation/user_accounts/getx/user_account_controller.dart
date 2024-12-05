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

class UserAccountController extends GetxController {
  UserAccountController({
    required this.addUser,
    required this.fetchUsers,
    required this.updateUser,
    required this.deleteUser,
  });

  final AddUser addUser;
  final UpdateUser updateUser;
  final FetchUsers fetchUsers;
  final DeleteUser deleteUser;

  //reactive variables
  RxInt totalCount = 0.obs;
  RxString query = ''.obs;
  RxBool isLoading = false.obs;
  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  RxString email = ''.obs;
  RxString phone = ''.obs;
  RxString address = ''.obs;
  RxString password = ''.obs;

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

  void updateUserAccount(String userId) async {
    isLoading(true);
    final UserRequest userRequest = UserRequest(
      id: userId,
      firstName: firstName.value.isNotEmpty ? firstName.value : null,
      lastName: lastName.value.isNotEmpty ? lastName.value : null,
      email: email.value.isNotEmpty ? email.value : null,
      phone: phone.value.isNotEmpty ? phone.value : null,
      address: address.value.isNotEmpty ? address.value : null,
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
}
