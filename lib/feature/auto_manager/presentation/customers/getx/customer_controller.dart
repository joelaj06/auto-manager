import 'package:automanager/core/usecase/usecase.dart';
import 'package:automanager/feature/auto_manager/data/model/model.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../core/errors/failure.dart';
import '../../../domain/usecase/customer/customer.dart';

class CustomerController extends GetxController {
  CustomerController({
    required this.fetchCustomers,
    required this.addCustomer,
    required this.updateCustomer,
    required this.deleteCustomer,
  });

  final FetchCustomers fetchCustomers;
  final AddCustomer addCustomer;
  final UpdateCustomer updateCustomer;
  final DeleteCustomer deleteCustomer;

  RxInt totalCount = 0.obs;
  RxString query = ''.obs;
  RxBool isLoading = false.obs;

  //paging controller
  final PagingController<int, Customer> pagingController =
      PagingController<int, Customer>(firstPageKey: 1);

  @override
  void onInit() {
    pagingController.addPageRequestListener((int pageKey) {
      getCustomers(pageKey);
    });
    super.onInit();
  }

  void getCustomers(int pageKey) async {
    isLoading(true);
    final Either<Failure, ListPage<Customer>> failureOrCustomers =
        await fetchCustomers(PageParams(
      pageIndex: pageKey,
      pageSize: 10,
      query: query.value,
    ));

    failureOrCustomers.fold((Failure failure) {
      isLoading(false);
      pagingController.error = failure.message;
    }, (ListPage<Customer> newPage) {
      isLoading(false);

      //get meta data
      final Map<String, dynamic>? meta = newPage.metaData;
      if (meta != null) {
        totalCount(meta['totalCount']);
      }
      //check if the new page is the last page
      final int previouslyFetchedItemsCount =
          pagingController.itemList?.length ?? 0;

      final bool isLastPage = newPage.isLastPage(previouslyFetchedItemsCount);
      final List<Customer> newItems = newPage.itemList;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final int nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
    });
  }

  void onSearchFieldInputChanged(String value) {
    query(value);

  }

  void onSearchQuerySubmitted() {
    pagingController.refresh();
  }
}
