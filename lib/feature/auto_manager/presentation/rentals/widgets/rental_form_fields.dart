import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../../../../core/presentation/utils/utils.dart';
import '../../../../../core/presentation/widgets/widgets.dart';
import '../../../../../core/utils/data_formatter.dart';
import '../../../../../core/utils/permissions.dart';
import '../../../data/model/model.dart';
import '../arguments/add_rental_argument.dart';
import '../getx/rental_controller.dart';

class RentalFormFields extends StatelessWidget {
  const RentalFormFields({
    super.key,
    required this.controller,
    this.args,
  });

  final RentalController controller;
  final AddRentalArgument? args;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
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
        const AppSpacing(v: 10),
        _buildCustomerSearchAutoComplete(context),
        const AppSpacing(v: 10),
        Obx(
          () => AppSelectField<Vehicle>(
            labelText: 'Vehicle',
            onChanged: (Vehicle vehicle) {
              controller.onVehicleSelected(vehicle);
            },
            value: controller.selectedVehicle.value.id!.isEmpty && args != null
                ? args!.rental.vehicle
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
        ),
        const AppSpacing(v: 10),
        AppTextInputField(
          labelText: 'Rental Cost',
          onChanged: controller.onRentalCostInputChanged,
          validator: controller.validateAmount,
          textInputType: const TextInputType.numberWithOptions(
            decimal: true,
          ),
          initialValue: args != null ? args!.rental.cost.toString() : '0.0',
        ),
        const AppSpacing(v: 10),
        AppTextInputField(
          labelText: 'Amount Paid',
          onChanged: controller.onAmountPaidInputChanged,
          textInputType: const TextInputType.numberWithOptions(
            decimal: true,
          ),
          initialValue: args != null ? args!.rental.amountPaid.toString() : '0.0',
        ),
        const AppSpacing(v: 10),
        AppTextInputField(
          labelText: 'Purpose',
          maxLines: 2,
          onChanged: controller.onPurposeInputChanged,
          initialValue: args != null ? args!.rental.purpose : '',
        ),
        const AppSpacing(v: 10),
        AppTextInputField(
          labelText: 'Notes',
          maxLines: 2,
          onChanged: controller.onNotesInputChanged,
          initialValue: args != null ? args!.rental.note : '',
        ),
        const AppSpacing(v: 10),
        if (args != null) ...[
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Extensions',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const AppSpacing(v: 8),
          Obx(
            () => ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.rentalExtensions.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildExtensionCard(
                  context,
                  controller.rentalExtensions[index],
                  index,
                  args!.rental.id,
                );
              },
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildExtensionCard(
      BuildContext context, RentalExtension extension, int index, String rentalId) {
    return Padding(
      padding: AppPaddings.sB,
      child: Container(
        padding: AppPaddings.mA,
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Extended Date: ${DataFormatter.formatDateToString(extension.extendedDate ?? '')}',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Amount: ${DataFormatter.getLocalCurrencyFormatter(context).format(extension.extendedAmount ?? 0)}',
                    style: const TextStyle(fontSize: 12),
                  ),
                  if (extension.extendedNote?.isNotEmpty == true)
                    Text(
                      'Notes: ${extension.extendedNote}',
                      style: const TextStyle(fontSize: 11),
                    ),
                ],
              ),
            ),
            if (UserPermissions.validator.canDeleteRentalExtension)
              IconButton(
                icon: const Icon(IconlyLight.delete, color: Colors.red, size: 20),
                onPressed: () async {
                  await AppDialogs.showDialogWithButtons(
                    context,
                    onConfirmPressed: () =>
                        controller.removeTheExtension(extension, index, rentalId),
                    content: const Text(
                      'Are you sure you want to remove this extension?',
                      textAlign: TextAlign.center,
                    ),
                    confirmText: 'Remove',
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerSearchAutoComplete(BuildContext context) {
    return Autocomplete<Customer>(
      displayStringForOption: controller.displayStringForOption,
      initialValue: TextEditingValue(text: controller.selectedCustomer.value.name),
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<Customer>.empty();
        }
        await controller.onCustomerSearchChanged(textEditingValue.text);
        return controller.customers;
      },
      onSelected: controller.onCustomerSelected,
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        // If the controller's selected customer changes, update the text field
        return Obx(
          () {
             if (controller.selectedCustomer.value.name.isNotEmpty && textEditingController.text.isEmpty) {
               textEditingController.text = controller.selectedCustomer.value.name;
             }
             return AppTextInputField(
              controller: textEditingController,
              focusNode: focusNode,
              labelText: 'Search Customer',
              validator: (String? value) => controller.validateField(value),
              suffixIcon: controller.isCustomerSearching.value
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  : const SizedBox.shrink(),
            );
          },
        );
      },
    );
  }
}
