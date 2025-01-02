import 'package:automanager/core/presentation/theme/app_theme.dart';
import 'package:automanager/core/utils/permissions.dart';
import 'package:automanager/core/utils/validators.dart';
import 'package:automanager/feature/auto_manager/presentation/role/argument/role_argument.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/utils/utils.dart';
import '../../../../../core/presentation/widgets/app_button.dart';
import '../../../../../core/presentation/widgets/app_text_input_field.dart';
import '../getx/role_controller.dart';

class AddRoleScreen extends GetView<RoleController> {
  const AddRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RoleArgument? args = Get.arguments as RoleArgument?;
    controller.clearField();
   // controller.getPermissions();
    if (args != null) {
      controller.getRoleDataFromArgs(args.role);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          args != null ? 'Update Role' : 'New Role',
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context, arg: args),
      body: Padding(
        padding: AppPaddings.mA,
        child: Column(
          children: <Widget>[
            AppTextInputField(
              labelText: 'Name',
              onChanged: controller.onNameInputChanged,
              validator: Validators.validateField,
              initialValue: args != null ? args.role.name : '',
            ),
            const AppSpacing(v: 10),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Permissions',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
            Expanded(child: _buildPermissions(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissions(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: UserPermissions.categorizedPermissions
          .map((CategorizedPermissions category) {
        return ExpansionTile(
          childrenPadding: EdgeInsets.zero,
          visualDensity: const VisualDensity(vertical: -4),
          title: Text(
            category.title,
          ),
          children: category.permissionActions
              .map((CategorizedPermissionActions actionData) {
            final String action = actionData.action;
            final String permission = actionData.permission;
            return Obx(
              () => CheckboxListTile(
                visualDensity: const VisualDensity(vertical: -4),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                title: Text(action,
                    style: TextStyle(
                      color: context.colorScheme.onSurface.withOpacity(.8),
                      fontSize: 14,
                    )),
                value: controller.selectedPermissions.contains(permission),
                onChanged: (bool? isChecked) {
                  if (isChecked == true) {
                    controller.addPermission(permission);
                  } else {
                    controller.removePermission(permission);
                  }
                },
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }

  Widget _buildBottomBar(BuildContext context, {required RoleArgument? arg}) {
    return Padding(
      padding: AppPaddings.mA,
      child: SizedBox(
        height: 70,
        child: Obx(
          () => AppButton(
            text: controller.isLoading.value
                ? 'Loading...'
                : arg != null
                    ? 'Update'
                    : 'Save',
            onPressed: () {
              arg != null
                  ? controller.updateTheRole(arg.role.id)
                  : controller.addNewRole();
            },
            enabled: arg != null
                ? !controller.isLoading.value
                : controller.roleFormIsValid.value &&
                    !controller.isLoading.value,
          ),
        ),
      ),
    );
  }
}
