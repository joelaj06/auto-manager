import 'package:automanager/core/core.dart';
import 'package:automanager/feature/auto_manager/data/data.dart';
import 'package:automanager/feature/auto_manager/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SalesController extends GetxController {
  SalesController({required this.fetchSales});

  final FetchSales fetchSales;

  //reactive variables
  RxBool isLoading = false.obs;
  RxString query = ''.obs;
  RxString dateText = 'This Month'.obs;
  Rx<DateTime> startDate =
      DateTime(DateTime.now().year, DateTime.now().month, 1).obs;
  Rx<DateTime> endDate = DateTime.now().obs;
  RxString driverId = ''.obs;
  RxString status = ''.obs;

  //paging controller
  final PagingController<int, Sale> pagingController =
      PagingController<int, Sale>(firstPageKey: 1);

  @override
  void onInit() {
    pagingController.addPageRequestListener((int pageKey) {
      getSales(pageKey);
    });
    super.onInit();
  }

  void onDateRangeSelected(BuildContext context) async {
    final DateRangeValues dateRangeValues =
    await AppDatePicker.showDateRangePicker(context);
    startDate(dateRangeValues.startDate);
    endDate(dateRangeValues.endDate);
    getTextDate(dateRangeValues);
    pagingController.refresh();
  }

  void getSales(int pageKey) async {
    isLoading(true);
    final Either<Failure, ListPage<Sale>> failureOrSales =
        await fetchSales(PageParams(
      pageIndex: pageKey,
      pageSize: 10,
      startDate: startDate.value.toIso8601String(),
      endDate: endDate.value.toIso8601String(),
      driverId: driverId.value,
      status: status.value,
      query: query.value,
    ));
    failureOrSales.fold((Failure failure) {
      pagingController.error = (failure);
    }, (ListPage<Sale> newPage) {
      isLoading(false);
      final int previouslyFetchedItemsCount =
          pagingController.itemList?.length ?? 0;

      final bool isLastPage = newPage.isLastPage(previouslyFetchedItemsCount);
      final List<Sale> newItems = newPage.itemList;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final int nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
    });
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
