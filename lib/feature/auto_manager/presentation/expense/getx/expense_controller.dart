import 'package:automanager/core/core.dart';
import 'package:automanager/feature/auto_manager/presentation/expense/arguments/add_expense_argument.dart';
import 'package:automanager/feature/auto_manager/presentation/presentation.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ionicons/ionicons.dart';

import '../../../data/model/model.dart';
import '../../../domain/usecase/expenses/expense.dart';

class ExpenseController extends GetxController {
  ExpenseController(
      {required this.fetchExpenses,
      required this.fetchExpenseCategories,
      required this.addExpense,
      required this.updateExpense,
      required this.deleteExpense});

  final FetchExpenses fetchExpenses;
  final FetchExpenseCategories fetchExpenseCategories;
  final AddExpense addExpense;
  final UpdateExpense updateExpense;
  final DeleteExpense deleteExpense;

  RxString dateText = 'This Month'.obs;
  Rx<DateTime> startDate =
      DateTime(DateTime.now().year, DateTime.now().month, 1).obs;
  Rx<DateTime> endDate = DateTime.now().obs;
  RxInt totalCount = 0.obs;
  RxDouble totalAmount = 0.0.obs;
  RxBool isLoading = false.obs;
  Rx<ExpenseCategory> selectedCategory = ExpenseCategory.empty().obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxString description = ''.obs;
  RxDouble amount = 0.0.obs;
  Rx<Vehicle> selectedVehicle = Vehicle.empty().obs;
  RxList<Vehicle> vehicles = <Vehicle>[].obs;
  RxList<ExpenseCategory> expenseCategories = <ExpenseCategory>[].obs;
  Rx<TextEditingController> dateController = TextEditingController().obs;
  Rx<Expense> expense = Expense.empty().obs;
  RxBool isDriversLoading = false.obs;
  RxBool isVehiclesLoading = false.obs;
  RxList<ExpandableItem<dynamic>> expandableList =
      <ExpandableItem<dynamic>>[].obs;
  RxString filteredVehicleId = ''.obs;
  RxString filteredCategoryId = ''.obs;

  //paging controller
  late final PagingController<int, Expense> pagingController;

  final SalesController salesController = Get.find();

  @override
  void onInit() {
    generateExpandableItems();
    pagingController = PagingController<int, Expense>(
      getNextPageKey: (PagingState<int, Expense> state) {
        if (state.hasNextPage) {
          return (state.keys?.last ?? 0) + 1;
        }
        return null;
      },
      fetchPage: (int pageKey) {
        return getAllExpenses(pageKey);
      },
    );

    getVehicles();
    super.onInit();
  }

  void loadDependencies() {
    getVehicles();
    getExpenseCategories();
    dateController.value.text = DataFormatter.formatDateToString(
      DateTime.now().toIso8601String(),
    );
    clearFields();
  }

  void resetFilters() {
    filteredCategoryId('');
    filteredVehicleId('');
    //Get.back();
  }

  void onFilteredVehicleSelected(String vehicleId) {
    filteredVehicleId(vehicleId);
  }

  void onFilteredCategorySelected(String categoryId) {
    filteredCategoryId(categoryId);
  }

  void onExpansionCallBack(int index) {
    expandableList[index].isExpanded = !expandableList[index].isExpanded;
    update(<Object>['filter']);
  }

  void generateExpandableItems() {
    expandableList.value = <ExpandableItem<dynamic>>[
      ExpandableItem<List<Vehicle>>(
          body: salesController.vehicles,
          headerValue: 'Vehicle',
          icon: Ionicons.speedometer),
      ExpandableItem<List<ExpenseCategory>>(
        body: expenseCategories,
        headerValue: 'Expense Category',
        icon: Icons.category,
      ),
    ];
  }

  void getExpenseData(Expense exp) {
    expense(exp);
    dateController.value.text = DataFormatter.formatDateToString(
      exp.date.toString(),
    );
  }

  void updateTheExpense(String expenseId) async {
    isLoading(true);
    final UpdateExpenseRequest expenseRequest = UpdateExpenseRequest(
      id: expenseId,
      description:
          description.value.isNotEmpty ? description.value.trim() : null,
      amount: amount.value > 0 ? amount.value : null,
      vehicleId: (selectedVehicle.value.id ?? '').isNotEmpty
          ? selectedVehicle.value.id
          : null,
      category: (selectedCategory.value.id ?? '').isNotEmpty
          ? selectedCategory.value.id
          : null,
      date: selectedDate.value.toIso8601String().isNotEmpty
          ? selectedDate.value.toIso8601String()
          : null,
    );

    final Either<Failure, Expense> failureOrExpense =
        await updateExpense(expenseRequest);
    failureOrExpense.fold(
      (Failure failure) {
        isLoading(false);
        AppSnack.show(message: failure.message, status: SnackStatus.error);
      },
      (Expense updatedExpense) {
        isLoading(false);
        refreshPage();
        Get.back<dynamic>(result: updatedExpense);
      },
    );
  }

  void deleteTheExpense(String expenseId) async {
    isLoading(true);
    final Either<Failure, Expense> failureOrExpense =
        await deleteExpense(expenseId);
    failureOrExpense.fold(
      (Failure failure) {
        isLoading(false);
        AppSnack.show(message: failure.message, status: SnackStatus.error);
      },
      (_) {
        isLoading(false);
        refreshPage();
        AppSnack.show(
            message: 'Expense deleted successfully',
            status: SnackStatus.success);
      },
    );
  }

  void navigateToUpdateExpenseScreen(Expense expense) async {
    final dynamic result = await Get.toNamed<dynamic>(AppRoutes.addExpense,
        arguments: AddExpenseArgument(expense));
    if (result != null) {
      AppSnack.show(
          message: 'Expense updated successfully', status: SnackStatus.success);
    }
  }

  void addNewExpense() async {
    isLoading(true);
    final AddExpenseRequest expenseRequest = AddExpenseRequest(
      category: selectedCategory.value.id ?? '',
      amount: amount.value,
      description: description.value,
      incurredBy: null,
      vehicleId: (selectedVehicle.value.id ?? '').isEmpty
          ? null
          : selectedVehicle.value.id,
      date: selectedDate.value.toIso8601String(),
    );
    final Either<Failure, Expense> failureOrExpense =
        await addExpense(expenseRequest);
    failureOrExpense.fold(
      (Failure failure) {
        isLoading(false);
        AppSnack.show(message: failure.message, status: SnackStatus.error);
      },
      (Expense newExpense) {
        isLoading(false);
        refreshPage();
        Get.back<dynamic>(result: newExpense);
      },
    );
  }

  void getExpenseCategories() async {
    final Either<Failure, List<ExpenseCategory>> failureOrCategories =
        await fetchExpenseCategories(
      NoParams(),
    );

    failureOrCategories.fold(
      (Failure failure) {
        AppSnack.show(message: failure.message, status: SnackStatus.error);
      },
      (List<ExpenseCategory> categories) {
        expenseCategories(categories);
      },
    );
  }

  void selectDate(BuildContext context) async {
    final DateTime? res = await AppDatePicker.showOnlyDatePicker(context);
    if (res != null) {
      selectedDate(res);
      dateController.value.text =
          DataFormatter.formatDateToString(res.toIso8601String());
    }
  }

  void getVehicles() async {
    await salesController.fetchAllVehicles();
  }

  void navigateToAddExpenseScreen() async {
    final dynamic res = await Get.toNamed<dynamic>(AppRoutes.addExpense);
    if (res != null) {
      AppSnack.show(
        message: 'Expense added successfully',
        status: SnackStatus.success,
      );
    }
  }

  Future<List<Expense>> getAllExpenses(int pageKey) async {
    isLoading(true);
    final Either<Failure, ListPage<Expense>> failureOrExpense =
        await fetchExpenses(
      PageParams(
        pageIndex: pageKey,
        pageSize: 10,
        startDate: startDate.value.toIso8601String(),
        endDate: endDate.value.toIso8601String(),
        categoryId: filteredCategoryId.value.isNotEmpty
            ? filteredCategoryId.value
            : null,
        vehicleId:
            filteredVehicleId.value.isNotEmpty ? filteredVehicleId.value : null,
      ),
    );

    return failureOrExpense.fold((Failure failure) {
      isLoading(false);
      pagingController.value = pagingController.value.copyWith(
        error: failure,
      );
      AppSnack.show(message: failure.message, status: SnackStatus.error);
      throw failure;
    }, (ListPage<Expense> newPage) {
      isLoading(false);

      //get meta data
      final Map<String, dynamic>? meta = newPage.metaData;
      if (meta != null) {
        totalCount(meta['totalCount']);
        totalAmount(double.tryParse(meta['totalExpenses']) ?? 0.0);
      }
      
      final PagingState<int, Expense> currentState = pagingController.value;
      final bool isLastPage = newPage.isLastPage(currentState.items?.length ?? 0);
      final List<Expense> newItems = newPage.itemList;

      pagingController.value = currentState.copyWith(
        hasNextPage: !isLastPage,
        error: null,
      );

      return newItems;
    });
  }

  void onDateRangeSelected(BuildContext context) async {
    final DateRangeValues dateRangeValues =
        await AppDatePicker.showDateRangePicker(context);
    startDate(dateRangeValues.startDate);
    endDate(dateRangeValues.endDate);
    getTextDate(dateRangeValues);
    pagingController.refresh();
  }

  void getTextDate(DateRangeValues values) {
    if (values.startDate != null) {
      final String start = DataFormatter.formatDateToStringDateOnly(
        values.startDate!.toIso8601String(),
      );
      final String end = DataFormatter.formatDateToStringDateOnly(
        values.endDate!.toIso8601String(),
      );
      final String dateString = 'From $start to $end';
      dateText(dateString);
    }
  }

  void refreshPage() {
    endDate(DateTime.now());
    pagingController.refresh();
  }

  void clearFields() {
    selectedDate(DateTime.now());
    dateController.value.text = DataFormatter.formatDateToString(
      DateTime.now().toIso8601String(),
    );
    selectedVehicle(Vehicle.empty());
    amount(0.0);
    description('');
    selectedCategory(ExpenseCategory.empty());
  }

  void clearExpiryFiled() {
    selectedDate(DateTime.now());
    dateController.value.text = DataFormatter.formatDateToString(
      DateTime.now().toIso8601String(),
    );
  }

  void onDateSelected(DateTime date) {
    selectedDate(date);
    dateController.value.text = DataFormatter.formatDateToStringDateOnly(
      date.toIso8601String(),
    );
  }

  void onVehicleSelected(Vehicle vehicle) {
    selectedVehicle(vehicle);
  }

  void onAmountInputChanged(String? value) {
    amount(double.tryParse(value ?? '0'));
  }

  void onDescriptionInputChanged(String? value) {
    description(value);
  }

  void onCategorySelected(ExpenseCategory category) {
    selectedCategory(category);
  }

  String? validateField(String? value) {
    String? errorMessage;
    if (value!.isEmpty) {
      errorMessage = 'Field is required';
    }
    return errorMessage;
  }

  String? validateAmount(String? value) {
    String? errorMessage;
    if (value!.isEmpty || double.tryParse(value) == null) {
      errorMessage = 'Please enter a valid amount';
    }
    if ((amount.value) <= 0) {
      errorMessage = 'Amount should be greater than 0';
    }
    return errorMessage;
  }

  RxBool get amountIsValid =>
      (validateAmount(amount.value.toStringAsFixed(2)) == null ||
              expense.value.amount! >= 0)
          .obs;

  RxBool get expenseFormIsValid =>
      (validateAmount(amount.value.toStringAsFixed(2)) == null &&
              validateField(selectedCategory.value.id) == null)
          .obs;
}
