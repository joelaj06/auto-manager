import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/presentation/utils/app_spacing.dart';
import '../../../../../core/presentation/utils/string_utils.dart';
import '../../../../../core/presentation/widgets/app_select_field.dart';
import '../../../../../core/presentation/widgets/app_text_input_field.dart';
import '../../../data/model/response/driver/driver_model.dart';
import '../../../data/model/response/vehicle/vehicle_model.dart';
import '../getx/sales_controller.dart';

class SaleFormFields extends StatelessWidget {
  const SaleFormFields({required this.controller});

  final SalesController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AppSelectField<Driver>(
          labelText: 'Driver',
          onChanged: controller.onDriverSelected,
          value: controller.selectedDriver.value,
          options: controller.drivers,
          titleBuilder: (_, Driver driver) =>
              '${driver.firstName} ${driver.lastName}'.toTitleCase(),
          validator: (Driver driver) =>
              controller.validateField(driver.firstName),
        ),
        const AppSpacing(v: 12),
        Obx(
              () => AppSelectField<Vehicle>(
            labelText: 'Vehicle',
            onChanged: controller.onVehicleSelected,
            value: controller.selectedVehicle.value,
            options: controller.vehicles,
            titleBuilder: (_, Vehicle vehicle) =>
                '${vehicle.model ?? ''} ${vehicle.make ?? ''} '
                    '${vehicle.color ?? ''} ${vehicle.year ?? ''}'
                    .toTitleCase(),
            validator: (Vehicle vehicle) =>
                controller.validateField(vehicle.model),
          ),
        ),
        const AppSpacing(v: 12),
        AppTextInputField(
          labelText: 'Amount',
          onChanged: controller.onAmountInputChanged,
          validator: controller.validateAmount,
          textInputType: const TextInputType.numberWithOptions(
            decimal: true,
          ),
          initialValue: '0.0',
        ),
        const AppSpacing(v: 4),
      ],
    );
  }
}
