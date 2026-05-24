import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/theme/app_theme.dart';
import '../../../../../core/presentation/widgets/modal_header.dart';
import '../arguments/add_expense_argument.dart';
import '../getx/expense_controller.dart';
import '../widgets/expense_form_fields.dart';

class WebAddExpenseModal extends StatelessWidget {
  const WebAddExpenseModal({required this.controller, this.args, super.key});

  final ExpenseController controller;
  final AddExpenseArgument? args;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colorScheme;

    return Scaffold(
      backgroundColor: Colors.black.withValues(alpha: 0.45),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 460),
          child: Material(
            color: colors.surface,
            borderRadius: BorderRadius.circular(14),
            clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ModalHeader(
                  title: args != null ? 'Update Expense' : 'New Expense',
                  onClose: () => Get.back(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
                  child: ExpenseFormFields(controller: controller),
                ),
                Obx(
                  () => ModalFooter(
                    saveText: args != null ? 'Update' : 'Save',
                    onSave: (args != null
                                ? controller.amountIsValid.value
                                : controller.expenseFormIsValid.value) &&
                            !controller.isLoading.value
                        ? () {
                            if (args != null) {
                              controller.updateTheExpense(args!.expense.id);
                            } else {
                              controller.addNewExpense();
                            }
                          }
                        : null,
                    isLoading: controller.isLoading.value,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
