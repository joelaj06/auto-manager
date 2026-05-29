import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/presentation/presentation.dart';
import '../getx/customer_controller.dart';

class CustomerFormFields extends StatelessWidget {
  const CustomerFormFields({required this.controller, super.key});

  final CustomerController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AppTextInputField(
          labelText: 'Full Name',
          onChanged: controller.onNameInputChanged,
          initialValue: controller.name.value,
          validator: controller.validateField,
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
          labelText: 'Email',
          onChanged: controller.onEmailInputChanged,
          initialValue: controller.email.value,
          textInputType: TextInputType.emailAddress,
        ),
        const AppSpacing(v: 12),
        Obx(
          () => AppTextInputField(
            controller: controller.dobTextEditingController.value,
            labelText: 'Date of Birth',
            readOnly: true,
            onTap: () => controller.selectDateOfBirth(context),
          ),
        ),
        const AppSpacing(v: 12),
        AppTextInputField(
          labelText: 'ID Number',
          onChanged: controller.onIdNumberInputChanged,
          initialValue: controller.idNumber.value,
        ),
        const AppSpacing(v: 12),
        AppTextInputField(
          labelText: 'Address',
          onChanged: controller.onAddressInputChanged,
          initialValue: controller.address.value,
          maxLines: 2,
        ),
        const AppSpacing(v: 12),
        Row(
          children: [
            Expanded(
              child: AppTextInputField(
                labelText: 'Occupation',
                onChanged: controller.onOccupationInputChanged,
                initialValue: controller.occupation.value,
              ),
            ),
            const AppSpacing(h: 12),
            Expanded(
              child: AppTextInputField(
                labelText: 'Business',
                onChanged: controller.onBusinessInputChanged,
                initialValue: controller.business.value,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
