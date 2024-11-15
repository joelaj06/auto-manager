import 'package:automanager/feature/auto_manager/presentation/expense/expense.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/presentation.dart';
import '../../../data/model/model.dart';
import '../arguments/add_expense_argument.dart';

class AddExpenseScreen extends GetView<ExpenseController> {
  const AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AddExpenseArgument? args = Get.arguments as AddExpenseArgument?;

    if (args != null) {
      controller.getExpenseData(args.expense);
    }
    controller.loadDependencies();
    return Scaffold(
      extendBody: false,
      appBar: AppBar(
        title: Text(args != null ? 'Update Expense' : 'New Expense'),
      ),
      bottomNavigationBar: _buildBottomBar(context, args),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: AppPaddings.mH,
            child: Column(
              children: <Widget>[
                Obx(
                  () => AppTextInputField(
                    controller: controller.dateController.value,
                    labelText: 'Date',
                    // onChanged: controller.onDateSelected,
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
                AppSelectField<ExpenseCategory>(
                  labelText: 'Expense Category',
                  onChanged: (ExpenseCategory category) {
                    controller.onCategorySelected(category);
                  },
                  value: args != null
                      ? args.expense.category
                      : controller.selectedCategory.value,
                  options: controller.expenseCategories,
                  titleBuilder: (_, ExpenseCategory category) =>
                      (category.name ?? '').toTitleCase(),
                  validator: (ExpenseCategory category) =>
                      controller.validateField(category.name),
                ),
                AppSelectField<Vehicle>(
                  labelText: 'Vehicle',
                  onChanged: (Vehicle vehicle) {
                    controller.onVehicleSelected(vehicle);
                  },
                  value: args != null
                      ? args.expense.vehicle
                      : controller.selectedVehicle.value,
                  options: controller.salesController.vehicles,
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
                  labelText: 'Amount',
                  onChanged: controller.onAmountInputChanged,
                  validator: controller.validateAmount,
                  textInputType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  initialValue:
                      args != null ? args.expense.amount.toString() : '0.0',
                ),
                const AppSpacing(v: 10),
                AppTextInputField(
                  labelText: 'Notes',
                  maxLines: 3,
                  onChanged: controller.onDescriptionInputChanged,
                  initialValue: args != null ? args.expense.description : '',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, AddExpenseArgument? args) {
    return SizedBox(
      height: 70,
      child: Obx(
        () => AppButton(
          text: args != null ? 'Update' : 'Save',
          onPressed: () {
            if (args != null) {
              controller.updateTheExpense(args.expense.id);
            } else {
              controller.addNewExpense();
            }
          },
          enabled: args != null
              ? controller.amountIsValid.value
              : (controller.expenseFormIsValid.value &&
                  !controller.isLoading.value),
        ),
      ),
    );
  }
}
