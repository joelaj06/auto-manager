import 'package:automanager/core/core.dart';
import 'package:automanager/feature/auto_manager/data/data.dart';
import 'package:automanager/feature/auto_manager/domain/usecase/role/role.dart';
import 'package:automanager/feature/auto_manager/presentation/role/argument/role_argument.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../../authentication/data/models/response/user/permission_model.dart';
import '../../../../authentication/data/models/response/user/role_model.dart';

class RoleController extends GetxController {
  RoleController({
    required this.fetchRoles,
    required this.addRole,
    required this.updateRole,
    required this.fetchPermissions,
  });

  final FetchRoles fetchRoles;
  final AddRole addRole;
  final UpdateRole updateRole;
  final FetchPermissions fetchPermissions;

  //reactive variables
  RxList<Role> roles = <Role>[].obs;
  RxBool isLoading = false.obs;
  RxString name = ''.obs;
  RxList<String> selectedPermissions = <String>[].obs;
  RxList<UserPermission> permissions = <UserPermission>[].obs;
  RxString query = ''.obs;

  @override
  void onInit() {
    getRoles();
    super.onInit();
  }

  void updateTheRole(String roleId) async {
    final RoleRequest roleRequest = RoleRequest(
      id: roleId,
      name: name.value.isNotEmpty ? name.value : null,
      permissions: selectedPermissions,
    );
    isLoading(true);
    final Either<Failure, Role> failureOrRole = await updateRole(roleRequest);
    failureOrRole.fold((Failure failure) {
      isLoading(false);
      AppSnack.show(message: failure.message, status: SnackStatus.error);
    }, (Role role) {
      isLoading(false);
      getRoles();
      Get.back<dynamic>(result: role);
    });
  }

  void addNewRole() async {
    final RoleRequest roleRequest = RoleRequest(
      name: name.value,
      permissions: selectedPermissions,
    );
    isLoading(true);
    final Either<Failure, Role> failureOrRole = await addRole(roleRequest);
    failureOrRole.fold((Failure failure) {
      isLoading(false);
      AppSnack.show(message: failure.message, status: SnackStatus.error);
    }, (Role role) {
      isLoading(false);
      getRoles();
      Get.back<dynamic>(result: role);
    });
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

  void getPermissions() async {
    final Either<Failure, List<UserPermission>> failureOrPermissions =
        await fetchPermissions(NoParams());
    failureOrPermissions.fold((Failure failure) {
      isLoading(false);
      AppSnack.show(message: failure.message, status: SnackStatus.error);
    }, (List<UserPermission> permissionsL) {
      isLoading(false);
      permissions(permissionsL);
    });
  }

  void navigateToAddRoleScreen() async {
    final dynamic res = await Get.toNamed<dynamic>(AppRoutes.addRole);
    if (res != null) {
      AppSnack.show(
        message: 'Role added successfully',
        status: SnackStatus.success,
      );
    }
  }

  void navigateToUpdateRoleScreen(Role role) async {
    final dynamic res = await Get.toNamed<dynamic>(AppRoutes.addRole,
        arguments: RoleArgument(role));
    if (res != null) {
      AppSnack.show(
          message: 'Role updated successfully', status: SnackStatus.success);
    }
  }

  void onSearchQuerySubmitted() {
    final List<Role> queriedRoles =
        (roles.where((Role role) => role.name.contains(query.value)).toList());
    roles(queriedRoles);
  }

  void onSearchFieldInputChanged(String value) {
    query(value);
  }
}
