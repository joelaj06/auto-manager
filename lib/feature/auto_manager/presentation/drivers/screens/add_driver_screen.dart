import 'package:automanager/core/presentation/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/widgets/widgets.dart';
import '../../../data/model/model.dart';
import '../arguments/driver_argument.dart';
import '../getx/driver_controller.dart';

class AddDriverScreen extends GetView<DriverController> {
  const AddDriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DriverArgument? args = Get.arguments as DriverArgument?;

    controller.clearFields();

    if (args != null) {
      controller.getDriverDataFromArgs(args.driver);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(args != null ? 'Update Driver' : 'New Driver'),
      ),
      bottomNavigationBar: _buildBottomBar(context, arg: args),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPaddings.mA,
          child: Column(
            children: <Widget>[
              AppTextInputField(
                labelText: 'First Name',
                onChanged: controller.onFirstNameInputChanged,
                validator: controller.validateField,
                initialValue: args != null ? args.driver.user.firstName : '',
              ),
              const AppSpacing(v: 10),
              AppTextInputField(
                labelText: 'Last Name',
                onChanged: controller.onLastNameInputChanged,
                validator: controller.validateField,
                initialValue: args != null ? args.driver.user.lastName : '',
              ),
              const AppSpacing(v: 10),
              AppTextInputField(
                labelText: 'Email',
                onChanged: controller.onEmailInputChanged,
                validator: controller.validateEmail,
                initialValue: args != null ? args.driver.user.email : '',
              ),
              const AppSpacing(v: 10),
              AppTextInputField(
                labelText: 'Phone',
                onChanged: controller.onPhoneInputChanged,
                textInputType: TextInputType.phone,
                initialValue: args != null ? args.driver.user.phone : '',
              ),
              const AppSpacing(v: 10),
              AppSelectField<Vehicle>(
                labelText: 'Assigned Vehicle',
                onChanged: (Vehicle vehicle) {
                  controller.onVehicleSelected(vehicle);
                },
                value: args != null
                    ? args.driver.vehicle
                    : controller.selectedVehicle.value,
                options: controller.vehicles,
                titleBuilder: (_, Vehicle vehicle) =>
                    ('${vehicle.model ?? ''} ${vehicle.make ?? ''}'
                        ' ${vehicle.color ?? ''} '
                        '${vehicle.year ?? ''}')
                        .toTitleCase(),
                validator: (Vehicle vehicle) =>
                    controller.validateField(vehicle.model),
              ),
              const AppSpacing(v: 10),
              AppTextInputField(
                labelText: 'License Number',
                onChanged: controller.onLicenseNumberInputChanged,
                initialValue: args != null ? args.driver.licenseNumber : '',
              ),
              Obx(
                    () =>
                    AppTextInputField(
                      controller: controller.licenseExpiryDateController.value,
                      labelText: 'License Expiry Date',
                      validator: (String? value) => null,
                      textInputType: TextInputType.datetime,
                      hintText: controller.licenseExpiryDateController.value
                          .text,
                      readOnly: true,
                      onTap: () {
                        controller.selectExtendedDate(context);
                      },
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context,
      {required DriverArgument? arg}) {
    return Padding(
      padding: AppPaddings.mA,
      child: SizedBox(
        height: 70,
        child: Obx(
              () =>
              AppButton(
                text: arg != null ? 'Update' : 'Save',
                onPressed: () {
                  arg != null
                      ? controller.updateTheDriver(arg.driver.user.id)
                      : controller.addADriver();
                },
                enabled: arg != null ? !controller.isLoading.value : controller
                    .driverFormIsValid.value &&
                    !controller.isLoading.value,
              ),
        ),
      ),
    );
  }
}
