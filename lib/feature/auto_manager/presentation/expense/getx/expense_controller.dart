import 'package:automanager/core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../data/model/model.dart';
import '../../../domain/usecase/expenses/expense.dart';

class ExpenseController extends GetxController {
  ExpenseController({required this.fetchExpenses});

  final FetchExpenses fetchExpenses;

  RxString dateText = 'This Month'.obs;
  Rx<DateTime> startDate =
      DateTime(DateTime.now().year, DateTime.now().month, 1).obs;
  Rx<DateTime> endDate = DateTime.now().obs;
  RxInt totalCount = 0.obs;
  RxDouble totalAmount = 0.0.obs;
  RxBool isLoading = false.obs;

  //paging controller
  final PagingController<int, Expense> pagingController =
      PagingController<int, Expense>(firstPageKey: 1);


  @override
  void onInit() {
    pagingController.addPageRequestListener((int pageKey) {
      getAllExpenses(pageKey);
    });
    super.onInit();
  }

  void getAllExpenses(int pageKey) async {
    isLoading(true);
    final Either<Failure, ListPage<Expense>> failureOrExpense =
        await fetchExpenses(
       PageParams(
        pageIndex: 1,
        pageSize: 10,
        startDate: startDate.value.toIso8601String(),
        endDate: endDate.value.toIso8601String(),
        categoryId: null,
      ),
    );

    failureOrExpense.fold(
      (Failure failure) {
        isLoading(false);
       AppSnack.show(message: failure.message, status: SnackStatus.error);
      },
      (ListPage<Expense> newPage) {
        isLoading(false);

        //get meta data
        final Map<String, dynamic>? meta = newPage.metaData;
        if (meta != null) {
          totalCount(meta['totalCount']);
          totalAmount(double.tryParse(meta['totalExpenses']) ?? 0.0);
        }
        //check if the new page is the last page
        final int previouslyFetchedItemsCount =
            pagingController.itemList?.length ?? 0;

        final bool isLastPage = newPage.isLastPage(previouslyFetchedItemsCount);
        final List<Expense> newItems = newPage.itemList;
        if (isLastPage) {
          pagingController.appendLastPage(newItems);
        } else {
          final int nextPageKey = pageKey + 1;
          pagingController.appendPage(newItems, nextPageKey);
        }
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
}
