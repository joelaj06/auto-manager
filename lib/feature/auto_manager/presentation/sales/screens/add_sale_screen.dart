import 'package:automanager/feature/auto_manager/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/utils/utils.dart';
import '../../../../../core/presentation/widgets/widgets.dart';
import '../../../data/model/model.dart';

class AddSaleScreen extends GetView<SalesController> {
  const AddSaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.loadDependencies();
    return Scaffold(
      extendBody: false,
      appBar: AppBar(
        title: const Text('New Sale'),
      ),
      bottomNavigationBar: _buildBottomBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: AppPaddings.mH,
            child: Column(
              children: <Widget>[
                AppSelectField<Driver>(
                  labelText: 'Driver',
                  onChanged: (Driver driver) {
                    controller.onDriverSelected(driver);
                  },
                  value: controller.selectedDriver.value,
                  options: controller.drivers,
                  titleBuilder: (_, Driver driver) =>
                      ('${driver.firstName} '
                              '${driver.lastName}')
                          .toTitleCase(),
                  validator: (Driver driver) =>
                      controller.validateField(driver.firstName),
                ),
                const AppSpacing(v: 10),
                Obx(() => AppSelectField<Vehicle>(
                    labelText: 'Vehicle',
                    onChanged: (Vehicle vehicle) {
                      controller.onVehicleSelected(vehicle);
                    },
                    value: controller.selectedVehicle.value,
                    options: controller.vehicles,
                    titleBuilder: (_, Vehicle vehicle) =>
                        ('${vehicle.model ?? ''} ${vehicle.make ?? ''}'
                                ' ${vehicle.color ?? ''} '
                                '${vehicle.year ?? ''}')
                            .toTitleCase(),
                    validator: (Vehicle vehicle) =>
                        controller.validateField(vehicle.model),
                  ),
                ),
                const AppSpacing(v: 10),
                AppTextInputField(
                  labelText: 'Amount',
                  onChanged: controller.onAmountInputChanged,
                  validator: controller.validateAmount,
                  textInputType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  initialValue: '0.0',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Obx(
        () => AppButton(
          text: controller.isLoading.value ? 'Loading...' : 'Save',
          onPressed: controller.onSaleSaved,
          enabled:
              controller.saleFormIsValid.value &&
                  !controller.isLoading.value,
        ),
      ),
    );
  }
}
