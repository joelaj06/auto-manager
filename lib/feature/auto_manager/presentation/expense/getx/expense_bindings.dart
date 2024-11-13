import 'package:automanager/feature/auto_manager/domain/domain.dart';
import 'package:get/get.dart';

import 'expense_controller.dart';

class ExpenseBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExpenseController>(
      () => ExpenseController(
          fetchExpenses: FetchExpenses(
            autoManagerRepository: Get.find(),
          ),
          fetchExpenseCategories: FetchExpenseCategories(
            autoManagerRepository: Get.find(),
          ), addExpense: AddExpense(
        autoManagerRepository: Get.find(),
      )),
    );
  }
}
