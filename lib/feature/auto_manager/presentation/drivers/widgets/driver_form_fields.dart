import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/presentation/presentation.dart';
import '../../../data/model/model.dart';
import '../getx/driver_controller.dart';

class DriverFormFields extends StatelessWidget {
  const DriverFormFields({required this.controller, super.key});

  final DriverController controller;

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
          labelText: 'License Number',
          onChanged: controller.onLicenseNumberInputChanged,
          initialValue: controller.licenseNumber.value,
        ),
        const AppSpacing(v: 12),
        Obx(
          () => AppTextInputField(
            controller: controller.licenseExpiryDateController.value,
            labelText: 'License Expiry Date',
            readOnly: true,
            onTap: () => controller.selectLicenseDate(context),
          ),
        ),
        const AppSpacing(v: 12),
        Obx(
          () => AppSelectField<Vehicle>(
            labelText: 'Assigned Vehicle',
            onChanged: (Vehicle? vehicle) {
              if (vehicle != null) controller.onVehicleSelected(vehicle);
            },
            value: controller.selectedVehicle.value.id != null
                ? controller.selectedVehicle.value
                : null,
            options: controller.vehicles,
            titleBuilder: (_, Vehicle vehicle) =>
                '${vehicle.make} ${vehicle.model} (${vehicle.licensePlate})',
          ),
        ),
      ],
    );
  }
}
