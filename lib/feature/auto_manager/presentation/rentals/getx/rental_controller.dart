import 'package:automanager/core/usecase/usecase.dart';
import 'package:automanager/feature/auto_manager/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/presentation/utils/utils.dart';
import '../../../data/model/model.dart';

class RentalController extends GetxController {
  RentalController({required this.fetchRentals});

  final FetchRentals fetchRentals;

  //reactive variables
  RxInt totalCount = 0.obs;
  RxDouble totalAmount = 0.0.obs;
  RxList<Rental> rentals = <Rental>[].obs;
  RxString dateText = 'This Month'.obs;
  Rx<DateTime> startDate =
      DateTime(DateTime.now().year, DateTime.now().month, 1).obs;
  Rx<DateTime> endDate = DateTime.now().obs;
  RxBool isLoading = false.obs;

  //paging controller
  final PagingController<int, Rental> pagingController =
      PagingController<int, Rental>(firstPageKey: 1);


  @override
  void onInit() {
    pagingController.addPageRequestListener((int pageKey) {
      getRentals(pageKey);
    });
    super.onInit();
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }

  void getRentals(int pageKey) async {
    isLoading(true);
    final Either<Failure, ListPage<Rental>> failureOrRentals =
        await fetchRentals(PageParams(
      pageIndex: pageKey,
      pageSize: 10,
      startDate: startDate.value.toIso8601String(),
      endDate: endDate.value.toIso8601String(),
    ));

    failureOrRentals.fold((Failure failure) {
      isLoading(false);
      pagingController.error = failure.message;
    }, (ListPage<Rental> newPage) {
      isLoading(false);
      final Map<String, dynamic>? meta = newPage.metaData;
      if (meta != null) {
        totalCount(meta['totalCount']);
        totalAmount(double.tryParse(meta['totalRentals']) ?? 0.0);
      }
      //check if the new page is the last page
      final int previouslyFetchedItemsCount =
          pagingController.itemList?.length ?? 0;

      final bool isLastPage = newPage.isLastPage(previouslyFetchedItemsCount);
      final List<Rental> newItems = newPage.itemList;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final int nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
    });
  }

  void navigateToAddRentalScreen() {}

  void onDateRangeSelected(BuildContext context) async {
    final DateRangeValues dateRangeValues =
        await AppDatePicker.showDateRangePicker(context);
    startDate(dateRangeValues.startDate);
    endDate(dateRangeValues.endDate);
    dateText(AppDatePicker.getTextDate(dateRangeValues));
    pagingController.refresh();
  }
}
