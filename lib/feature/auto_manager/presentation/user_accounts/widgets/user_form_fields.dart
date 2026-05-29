import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/presentation/presentation.dart';
import '../../../../authentication/data/models/response/user/role_model.dart';
import '../../../data/model/model.dart';
import '../getx/user_account_controller.dart';

class UserFormFields extends StatelessWidget {
  const UserFormFields({required this.controller, this.isUpdate = false, super.key});

  final UserAccountController controller;
  final bool isUpdate;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: [
            Expanded(
              child: AppTextInputField(
                labelText: 'First Name',
                onChanged: controller.onFirstNameInputChanged,
                initialValue: controller.firstName.value,
                validator: controller.validateField,
              ),
            ),
            const AppSpacing(h: 12),
            Expanded(
              child: AppTextInputField(
                labelText: 'Last Name',
                onChanged: controller.onLastNameInputChanged,
                initialValue: controller.lastName.value,
                validator: controller.validateField,
              ),
            ),
          ],
        ),
        const AppSpacing(v: 12),
        AppTextInputField(
          labelText: 'Email',
          onChanged: controller.onEmailInputChanged,
          initialValue: controller.email.value,
          validator: controller.validateEmail,
          textInputType: TextInputType.emailAddress,
        ),
        const AppSpacing(v: 12),
        AppTextInputField(
          labelText: 'Phone',
          onChanged: controller.onPhoneInputChanged,
          initialValue: controller.phone.value,
          validator: controller.validateField,
          textInputType: TextInputType.phone,
        ),
        const AppSpacing(v: 12),
        AppTextInputField(
          labelText: 'Address',
          onChanged: controller.onAddressInputChanged,
          initialValue: controller.address.value,
        ),
        const AppSpacing(v: 12),
        Obx(
          () => AppSelectField<Role>(
            labelText: 'Role',
            onChanged: (Role role) => controller.onRoleSelected(role),
            value: controller.selectedRole.value.id.isNotEmpty ? controller.selectedRole.value : null,
            options: controller.roles,
            titleBuilder: (_, Role role) => role.name.toTitleCase(),
          ),
        ),
        if (!isUpdate) ...[
          const AppSpacing(v: 12),
          Obx(
            () => AppTextInputField(
              labelText: 'Password',
              onChanged: controller.onPasswordInputChanged,
              obscureText: !controller.showPassword.value,
              validator: controller.validatePassword,
              suffixIcon: IconButton(
                onPressed: controller.togglePassword,
                icon: Icon(controller.showPassword.value ? Icons.visibility_off : Icons.visibility),
              ),
            ),
          ),
          const AppSpacing(v: 12),
          AppTextInputField(
            labelText: 'Confirm Password',
            onChanged: controller.onConfirmPasswordInputChanged,
            obscureText: true,
            validator: controller.validatePasswordConfirmation,
          ),
        ],
      ],
    );
  }
}
