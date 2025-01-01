import 'package:automanager/core/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../../../../core/presentation/utils/utils.dart';
import '../../../../../core/presentation/widgets/app_text_input_field.dart';
import '../../../../../core/utils/permissions.dart';
import '../getx/role_controller.dart';

class RoleScreen extends GetView<RoleController> {
  const RoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Roles'),
      ),
      floatingActionButton: UserPermissions.validator.canCreateRole
          ? FloatingActionButton(
              onPressed: controller.navigateToAddRoleScreen,
              child: const Icon(IconlyLight.plus),
            )
          : null,
      body: Column(
        children: <Widget>[
          _buildRoleSearchField(context),
          Expanded(
            child: _buildRoleList(context),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleList(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Future<void>.sync(() => controller.getRoles()),
      notificationPredicate: (_) => true,
      child: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return Slidable(
                    endActionPane: ActionPane(
                      motion: const DrawerMotion(),
                      children: <Widget>[
                        Visibility(
                          visible: UserPermissions.validator.canUpdateDriver,
                          child: SlidableAction(
                            backgroundColor: context.colorScheme.background,
                            icon: IconlyLight.edit,
                            label: 'Edit',
                            onPressed: (BuildContext context) {
                              controller.navigateToUpdateRoleScreen(
                                  controller.roles[index]);
                            },
                          ),
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(controller.roles[index].name),
                      subtitle: Text(
                          'Permissions: ${controller.roles[index].permissions.length}'),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
                itemCount: controller.roles.length,
              ),
      ),
    );
  }

  Widget _buildRoleSearchField(BuildContext context) {
    return Padding(
      padding: AppPaddings.mA,
      child: AppTextInputField(
        onChanged: controller.onSearchFieldInputChanged,
        hintText: 'Search Role',
        suffixIcon: GestureDetector(
          onTap: () {
            controller.onSearchQuerySubmitted();
          },
          child: const Icon(
            IconlyLight.search,
          ),
        ),
      ),
    );
  }
}
