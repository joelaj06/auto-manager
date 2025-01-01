import 'package:get/get.dart';

import '../../../domain/usecase/role/role.dart';
import 'role_controller.dart';

class RoleBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoleController>(
      () => RoleController(
        fetchRoles: FetchRoles(autoManagerRepository: Get.find()),
        addRole: AddRole(autoManagerRepository: Get.find()),
        updateRole: UpdateRole(autoManagerRepository: Get.find()),
        fetchPermissions: FetchPermissions(autoManagerRepository: Get.find()),
      ),
    );
  }
}
