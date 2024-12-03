import 'package:automanager/feature/auto_manager/data/data.dart';
import 'package:automanager/feature/auto_manager/data/data.dart';
import 'package:automanager/feature/auto_manager/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/usecase/usecase.dart';

class VehicleController extends GetxController {
  VehicleController(
      {required this.fetchVehicles,
      required this.addVehicle,
      required this.updateVehicle,
      required this.deleteVehicle});

  final FetchVehicles fetchVehicles;
  final AddVehicle addVehicle;
  final UpdateVehicle updateVehicle;
  final DeleteVehicle deleteVehicle;

  //reactive variables
  RxInt totalCount = 0.obs;
  RxString query = ''.obs;
  RxBool isLoading = false.obs;

  //paging controller
  final PagingController<int, Vehicle> pagingController =
      PagingController<int, Vehicle>(firstPageKey: 1);

  @override
  void onInit() {
    pagingController.addPageRequestListener((int pageKey) {
      getVehicles(pageKey);
    });
    super.onInit();
  }

  void getVehicles(int pageKey) async {
    isLoading(true);
    final Either<Failure, ListPage<Vehicle>> failureOrVehicles =
        await fetchVehicles(PageParams(
      pageIndex: pageKey,
      pageSize: 10,
      query: query.value,
    ));

    failureOrVehicles.fold((Failure failure) {
      isLoading(false);
      pagingController.error = failure.message;
    }, (ListPage<Vehicle> newPage) {
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
      final List<Vehicle> newItems = newPage.itemList;
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
