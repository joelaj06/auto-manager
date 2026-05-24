import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/presentation/presentation.dart';
import '../arguments/add_expense_argument.dart';
import '../getx/expense_controller.dart';
import '../widgets/expense_form_fields.dart';

class MobileAddExpenseScreen extends StatelessWidget {
  const MobileAddExpenseScreen({required this.controller, this.args, super.key});

  final ExpenseController controller;
  final AddExpenseArgument? args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      appBar: AppBar(
        title: Text(args != null ? 'Update Expense' : 'New Expense'),
      ),
      bottomNavigationBar: _buildBottomBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: AppPaddings.mH,
            child: ExpenseFormFields(controller: controller),
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
          text: args != null ? 'Update' : 'Save',
          onPressed: () {
            if (args != null) {
              controller.updateTheExpense(args!.expense.id);
            } else {
              controller.addNewExpense();
            }
          },
          enabled: args != null
              ? controller.amountIsValid.value
              : controller.expenseFormIsValid.value,
          loading: controller.isLoading.value,
        ),
      ),
    );
  }
}
