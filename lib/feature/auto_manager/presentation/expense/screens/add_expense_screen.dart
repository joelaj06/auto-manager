import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../arguments/add_expense_argument.dart';
import '../getx/expense_controller.dart';
import 'mobile_add_expense_screen.dart';
import 'web_add_expense_screen.dart';

class AddExpenseScreen extends GetView<ExpenseController> {
  const AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.loadDependencies();
    final AddExpenseArgument? args = Get.arguments as AddExpenseArgument?;

    if (args != null) {
      controller.getExpenseData(args.expense);
    }

    final bool isWide = MediaQuery.of(context).size.width >= 768;

    return isWide
        ? WebAddExpenseModal(controller: controller, args: args)
        : MobileAddExpenseScreen(controller: controller, args: args);
  }
}
