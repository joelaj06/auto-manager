import 'package:automanager/feature/authentication/data/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/presentation.dart';
import '../../../../../core/presentation/theme/app_theme.dart';
import '../getx/user_account_controller.dart';
import '../user_account.dart';
import '../widgets/user_form_fields.dart';

class AddUserScreen extends GetView<UserAccountController> {
  const AddUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserAccountArgument? args = Get.arguments as UserAccountArgument?;

    final bool isWide = MediaQuery.of(context).size.width >= 768;

    return isWide
        ? _WebAddUserModal(controller: controller, args: args)
        : _MobileAddUserScreen(controller: controller, args: args);
  }
}

class _MobileAddUserScreen extends StatelessWidget {
  const _MobileAddUserScreen({required this.controller, this.args});

  final UserAccountController controller;
  final UserAccountArgument? args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(args != null ? 'Update User' : 'New User'),
      ),
      bottomNavigationBar: _buildBottomBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPaddings.mA,
          child: UserFormFields(controller: controller, isUpdate: args != null),
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Padding(
      padding: AppPaddings.mA,
      child: SizedBox(
        height: 70,
        child: Obx(
          () => AppButton(
            text: controller.isLoading.value ? 'Loading...' : args != null ? 'Update' : 'Save',
            onPressed: () {
              args != null
                  ? controller.updateUserAccount(args!.user.id)
                  : controller.addUserAccount();
            },
            enabled: (args != null ? controller.userFormIsValid.value : controller.clientFormIsValid.value) && !controller.isLoading.value,
            loading: controller.isLoading.value,
          ),
        ),
      ),
    );
  }
}

class _WebAddUserModal extends StatelessWidget {
  const _WebAddUserModal({required this.controller, this.args});

  final UserAccountController controller;
  final UserAccountArgument? args;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colorScheme;

    return Scaffold(
      backgroundColor: Colors.black.withValues(alpha: 0.45),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Material(
            color: colors.surface,
            borderRadius: BorderRadius.circular(14),
            clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ModalHeader(
                  title: args != null ? 'Update User' : 'New User',
                  onClose: () => Get.back(),
                ),
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
                    child: UserFormFields(controller: controller, isUpdate: args != null),
                  ),
                ),
                Obx(
                  () => ModalFooter(
                    onSave: (args != null ? controller.userFormIsValid.value : controller.clientFormIsValid.value) && !controller.isLoading.value
                        ? () {
                            if (args != null) {
                              controller.updateUserAccount(args!.user.id);
                            } else {
                              controller.addUserAccount();
                            }
                          }
                        : null,
                    isLoading: controller.isLoading.value,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
