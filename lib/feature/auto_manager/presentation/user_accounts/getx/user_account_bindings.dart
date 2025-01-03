import 'package:automanager/feature/auto_manager/domain/domain.dart';
import 'package:get/get.dart';

import '../../../domain/usecase/role/fetch_roles.dart';
import 'user_account_controller.dart';

class UserAccountBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserAccountController>(
      () => UserAccountController(
        addUser: AddUser(
          autoManagerRepository: Get.find(),
        ),
        fetchUsers: FetchUsers(
          autoManagerRepository: Get.find(),
        ),
        updateUser: UpdateUser(
          autoManagerRepository: Get.find(),
        ),
        deleteUser: DeleteUser(
          autoManagerRepository: Get.find(),
        ),
        fetchRoles: FetchRoles(
          autoManagerRepository: Get.find(),
        ),
      ),
    );
  }
}
