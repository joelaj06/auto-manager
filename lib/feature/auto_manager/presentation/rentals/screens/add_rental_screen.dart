import 'package:automanager/feature/auto_manager/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../../../../core/presentation/utils/utils.dart';
import '../../../../../core/presentation/widgets/widgets.dart';
import '../../../../../core/utils/data_formatter.dart';
import '../../../data/model/model.dart';

class AddRentalScreen extends GetView<RentalController> {
  const AddRentalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.fetchAllVehicles();
    final AddRentalArgument? args = Get.arguments as AddRentalArgument?;

    controller.clearFields();
    if (args != null) {
      controller.getRentalDataFromArgs(args.rental);
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(args != null ? 'Update Rental' : 'New Rental'),
        ),
        bottomNavigationBar: _buildBottomBar(context, arg: args),
        body: SingleChildScrollView(
          child: Padding(
            padding: AppPaddings.mA,
            child: Column(
              children: <Widget>[
                Obx(
                  () => AppTextInputField(
                    controller: controller.dateController.value,
                    labelText: 'Select Period',
                    validator: (String? value) =>
                        controller.validateField(value),
                    textInputType: TextInputType.datetime,
                    hintText: controller.dateController.value.text,
                    readOnly: true,
                    onTap: () {
                      controller.selectDate(context);
                    },
                  ),
                ),
                const AppSpacing(v: 10),
                _buildCustomerSearchAutoComplete(context, args),
                const AppSpacing(v: 10),
                AppSelectField<Vehicle>(
                  labelText: 'Vehicle',
                  onChanged: (Vehicle vehicle) {
                    controller.onVehicleSelected(vehicle);
                  },
                  value: args != null
                      ? args.rental.vehicle
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
                  labelText: 'Rental Cost',
                  onChanged: controller.onRentalCostInputChanged,
                  validator: controller.validateAmount,
                  textInputType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  initialValue:
                      args != null ? args.rental.cost.toString() : '0.0',
                ),
                const AppSpacing(v: 10),
                AppTextInputField(
                  labelText: 'Amount Paid',
                  onChanged: controller.onAmountPaidInputChanged,
                  textInputType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  initialValue:
                      args != null ? args.rental.amountPaid.toString() : '0.0',
                ),
                const AppSpacing(v: 10),
                AppTextInputField(
                  labelText: 'Purpose',
                  maxLines: 2,
                  onChanged: controller.onPurposeInputChanged,
                  initialValue: args != null ? args.rental.purpose : '',
                ),
                const AppSpacing(v: 10),
                AppTextInputField(
                  labelText: 'Notes',
                  maxLines: 2,
                  onChanged: controller.onNotesInputChanged,
                  initialValue: args != null ? args.rental.note : '',
                ),
                const AppSpacing(v: 10),
                Visibility(
                  visible: args != null,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Extensions',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const AppSpacing(v: 15),
                      Obx(
                        () => ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.rentalExtensions.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  const AppSpacing(h: 10),
                                  Expanded(
                                    child: Obx(
                                      () => _buildExtensionCard(
                                        context,
                                        controller.rentalExtensions[index],
                                      ),
                                    ),
                                  ),
                                  const AppSpacing(h: 10),
                                  IconButton(
                                    icon: const Icon(
                                      IconlyLight.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () async {
                                      await AppDialogs.showDialogWithButtons(
                                        context,
                                        onConfirmPressed: () =>
                                            controller.removeExtension(
                                          controller.rentalExtensions[index],
                                        ),
                                        content: const Text(
                                          'Are you sure you want to remove this '
                                              'extension?',
                                          textAlign: TextAlign.center,
                                        ),
                                        confirmText: 'Remove',
                                      );
                                    },
                                  ),
                                ],
                              );
                            }),
                      )
                      /* ...List<Widget>.generate(
                          controller.rentalExtensions.length,
                              (int index) => Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const AppSpacing(h: 10),
                              Expanded(
                                child: Obx(() => _buildExtensionCard(
                                    context,
                                    controller.rentalExtensions[index],
                                  ),
                                ),
                              ),
                              const AppSpacing(h: 10),
                              IconButton(
                                icon:  const Icon(IconlyLight.delete,
                                  color: Colors.red,),
                                onPressed: () {
                                  controller.removeExtension(
                                      controller.rentalExtensions[index],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),*/
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget _buildExtensionCard(BuildContext context, RentalExtension extension) {
    return Padding(
      padding: AppPaddings.sB,
      child: Container(
        padding: AppPaddings.mA,
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ModalListCard(
              title: 'Extended Date',
              value: DataFormatter.formatDateToString(
                  extension.extendedDate ?? ''),
            ),
            ModalListCard(
              title: 'Extended Amount',
              value: DataFormatter.getLocalCurrencyFormatter(context)
                  .format(extension.extendedAmount ?? 0),
            ),
            ModalListCard(
              title: 'Notes',
              value: extension.extendedNote ?? '--',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerSearchAutoComplete(
      BuildContext context, AddRentalArgument? args) {
    return Autocomplete<Customer>(
      displayStringForOption: controller.displayStringForOption,
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
        if (args != null) {
          textEditingController.text = args.rental.renter?.name ?? '';
        }
        return Obx(
          () => AppTextInputField(
            controller: textEditingController,
            focusNode: focusNode,
            labelText: 'Search Customer',
            validator: (String? value) => controller.validateField(value),
            suffixIcon: controller.isCustomerSearching.value
                ? Image.asset(
                    AssetGifs.loadingDots,
                    height: 50.0,
                    width: 50.0,
                  )
                : const SizedBox.shrink(),
          ),
        );
      },
    );
  }

  Widget _buildBottomBar(BuildContext context,
      {required AddRentalArgument? arg}) {
    return Padding(
      padding: AppPaddings.mA,
      child: SizedBox(
        height: 70,
        child: Obx(
          () => AppButton(
            text: arg != null ? 'Update' : 'Save',
            onPressed: () {
              arg != null
                  ? controller.updateTheRental(arg.rental)
                  : controller.addNewRental();
            },
            enabled: controller.rentalFormIsValid.value &&
                !controller.isLoading.value,
          ),
        ),
      ),
    );
  }
}
