import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/presentation/presentation.dart';
import '../../../data/model/model.dart';
import '../getx/expense_controller.dart';

class ExpenseFormFields extends StatelessWidget {
  const ExpenseFormFields({required this.controller, super.key});

  final ExpenseController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Obx(
          () => AppTextInputField(
            controller: controller.dateController.value,
            labelText: 'Date',
            validator: (String? value) => null,
            textInputType: TextInputType.datetime,
            suffixIcon: IconButton(
              onPressed: controller.clearExpiryFiled,
              icon: const Icon(Icons.cancel),
            ),
            hintText: controller.dateController.value.text,
            readOnly: true,
            onTap: () {
              controller.selectDate(context);
            },
          ),
        ),
        const AppSpacing(v: 10),
        Obx(
          () => AppSelectField<ExpenseCategory>(
            labelText: 'Expense Category',
            onChanged: (ExpenseCategory category) {
              controller.onCategorySelected(category);
            },
            value: controller.selectedCategory.value,
            options: controller.expenseCategories,
            titleBuilder: (_, ExpenseCategory category) =>
                (category.name ?? '').toTitleCase(),
            validator: (ExpenseCategory category) =>
                controller.validateField(category.name),
          ),
        ),
        const AppSpacing(v: 10),
        Obx(
          () => AppSelectField<Vehicle>(
            labelText: 'Vehicle',
            onChanged: (Vehicle vehicle) {
              controller.onVehicleSelected(vehicle);
            },
            value: controller.selectedVehicle.value,
            options: controller.salesController.vehicles,
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
          initialValue: controller.amount.value.toString(),
        ),
        const AppSpacing(v: 10),
        AppTextInputField(
          labelText: 'Notes',
          maxLines: 3,
          onChanged: controller.onDescriptionInputChanged,
          initialValue: controller.description.value,
        ),
      ],
    );
  }
}
