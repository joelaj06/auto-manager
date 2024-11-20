import 'package:automanager/feature/auto_manager/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/utils/utils.dart';
import '../../../../../core/presentation/widgets/widgets.dart';
import '../../../data/model/model.dart';
class AddRentalScreen extends GetView<RentalController> {
  const AddRentalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('New Rental'),
      ),
      bottomNavigationBar: _buildBottomBar(context),
      body: Padding(
        padding: AppPaddings.mA,
        child: Column(
          children: <Widget>[
            Obx(
                  () => AppTextInputField(
                controller: controller.dateController.value,
                labelText: 'Select Period',
                validator: (String? value) => controller.validateField(value),
                textInputType: TextInputType.datetime,
                hintText: controller.dateController.value.text,
                readOnly: true,
                onTap: () {
                  controller.selectDate(context);
                },
              ),
            ),
            AppSelectField<Customer>(
              labelText: 'Customer',
              onChanged: (Customer customer) {
                controller.onCustomerSelected(customer);
              },
              value: controller.selectedCustomer.value,
              options: controller.customers,
              titleBuilder: (_, Customer customer) =>
                  customer.name
                      .toTitleCase(),
              validator: (Customer customer) =>
                  controller.validateField(customer.name),
            ),
            const AppSpacing(v: 10),
            AppSelectField<Vehicle>(
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
            const AppSpacing(v: 10),
            AppTextInputField(
              labelText: 'Rental Cost',
              onChanged: controller.onRentalCostInputChanged,
              validator: controller.validateAmount,
              textInputType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              initialValue: '0.0',
            ), const AppSpacing(v: 10),
            AppTextInputField(
              labelText: 'Amount Paid',
              onChanged: controller.onAmountPaidInputChanged,
              textInputType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              initialValue: '0.0',
            ),
            const AppSpacing(v: 10),
            AppTextInputField(
              labelText: 'Purpose',
              maxLines: 2,
              onChanged: controller.onPurposeInputChanged,
              initialValue: '',
            ),
            const AppSpacing(v: 10),
            AppTextInputField(
              labelText: 'Notes',
              maxLines: 2,
              onChanged: controller.onNotesInputChanged,
              initialValue: '',
            ),
          ],
        ),
      )
    );
  }


  Widget _buildBottomBar(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Obx(
            () => AppButton(
          text: 'Save',
          onPressed: controller.addNewRental,
          enabled:
          controller.rentalFormIsValid.value &&
              !controller.isLoading.value,
        ),
      ),
    );
  }
}
