import 'package:automanager/core/core.dart';
import 'package:automanager/feature/auto_manager/data/data.dart';
import 'package:automanager/feature/auto_manager/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SalesController extends GetxController
    with GetSingleTickerProviderStateMixin {
  SalesController(
      {required this.fetchSales,
      required this.fetchVehicles,
      required this.fetchDrivers,
      required this.addSale,
      required this.deleteSale});

  final FetchSales fetchSales;
  final FetchVehicles fetchVehicles;
  final FetchDrivers fetchDrivers;
  final AddSale addSale;
  final DeleteSale deleteSale;

  //reactive variables
  RxBool isLoading = false.obs;
  RxString query = ''.obs;
  RxString dateText = 'This Month'.obs;
  Rx<DateTime> startDate =
      DateTime(DateTime.now().year, DateTime.now().month, 1).obs;
  Rx<DateTime> endDate = DateTime.now().obs;
  RxString driverId = ''.obs;
  RxString status = 'approved'.obs;
  RxBool isSearching = false.obs;
  Rx<TextEditingController> searchQueryTextEditingController =
      TextEditingController().obs;
  RxInt totalCount = 0.obs;
  RxDouble totalAmount = 0.0.obs;
  Rx<Driver> selectedDriver = Driver.empty().obs;
  Rx<Vehicle> selectedVehicle = Vehicle.empty().obs;
  RxString amount = '0.0'.obs;
  RxString vehicleId = ''.obs;
  RxList<Driver> drivers = <Driver>[].obs;
  RxList<Vehicle> vehicles = <Vehicle>[].obs;

  //paging controller
  final PagingController<int, Sale> pagingController =
      PagingController<int, Sale>(firstPageKey: 1);

  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void onInit() {
    pagingController.addPageRequestListener((int pageKey) {
      getSales(pageKey);
    });
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );
    super.onInit();
  }

  @override
  void onClose() {
    searchQueryTextEditingController.value.dispose();
    pagingController.dispose();
    animationController.dispose();
    super.onClose();
  }


  void loadDependencies() {
    fetchAllVehicles();
    fetchAllDrivers();
    resetFields();
  }

  void deleteASale(String saleId) async{
    isLoading(true);
    final Either<Failure, Sale> failureOrSale = await deleteSale(saleId);
    failureOrSale.fold(
      (Failure failure) {
        isLoading(false);
        AppSnack.show(
          message: failure.message,
          status: SnackStatus.error,
        );
      },
      (_) {
        isLoading(false);
        pagingController.refresh();
      },
    );
  }

  void resetFields(){
    amount.value = '0.0';
    vehicleId.value = '';
    selectedVehicle.value = Vehicle.empty();
    selectedDriver.value = Driver.empty();
    driverId.value = '';
  }



  void onSaleSaved() async {
    isLoading(true);
    final AddSaleRequest addSaleRequest = AddSaleRequest(
      amount: double.parse(amount.value),
      //date: dateText.value,
      driverId: driverId.value,
      vehicleId: vehicleId.value,
    );

    final Either<Failure, Sale> failureOrSale = await addSale(addSaleRequest);
    failureOrSale.fold(
      (Failure failure) {
        isLoading(false);
        AppSnack.show(
          message: failure.message,
          status: SnackStatus.error,
        );
      },
      (Sale sale) {
        isLoading(false);
         Get.back<dynamic>(result: sale);
         endDate(DateTime.now());
        pagingController.refresh();
      },
    );
  }

  Future<List<Vehicle>?> fetchAllVehicles() async {
    final Either<Failure, ListPage<Vehicle>> failureOrVehicles =
        await fetchVehicles(const PageParams(
      pageIndex: 1,
      pageSize: 100,
      query: '',
    ));
    failureOrVehicles.fold(
      (Failure failure) => null,
      (ListPage<Vehicle> listPage) {
        vehicles(listPage.itemList);
        return listPage.itemList;
      },
    );
    return null;
  }

  void fetchAllDrivers() async {
    final Either<Failure, ListPage<Driver>> failureOrDrivers =
        await fetchDrivers(const PageParams(
      pageIndex: 1,
      pageSize: 100,
      query: '',
    ));
    failureOrDrivers.fold(
      (Failure failure) => null,
      (ListPage<Driver> listPage) {
        drivers(listPage.itemList);
      },
    );
  }

  void navigateToAddSalesScreen() async {
    final dynamic res = await Get.toNamed(AppRoutes.addSale);
    if(res != null) {
      AppSnack.show(
        message: 'Sale added successfully',
        status: SnackStatus.success,
      );
    }
  }

  //toggle the search on search icon pressed
  void toggleSearch() {
    isSearching(!isSearching.value);
    if (isSearching.value) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }

  void onSearchQuerySubmitted(String value) {
    query(value);
    pagingController.refresh();
  }

  void onSearchFieldInputChanged(String value) {
    query(value);
  }

  void clearSearchField() {
    query('');
    searchQueryTextEditingController.value.text = '';
    pagingController.refresh();
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
     // driverId: driverId.value,
     // status: status.value,
      query: query.value,
    ));
    failureOrSales.fold((Failure failure) {
      pagingController.error = (failure);
    }, (ListPage<Sale> newPage) {
      isLoading(false);

      //get meta data
      final Map<String, dynamic>? meta = newPage.metaData;
      if (meta != null) {
        totalCount(meta['totalCount']);
        totalAmount(double.tryParse(meta['totalSales']) ?? 0.0);
      }
      //check if the new page is the last page
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

  void onAmountInputChanged(String? value) {
    amount(value);
  }

  void onDriverSelected(Driver driver) {
    selectedDriver(driver);
    driverId(driver.id);
  }

  void onVehicleSelected(Vehicle vehicle) {
    selectedVehicle(vehicle);
    vehicleId(vehicle.id);
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
    if ((double.tryParse(amount.value) ?? 0) <= 0) {
      errorMessage = 'Amount should be greater than 0';
    }
    return errorMessage;
  }

  RxBool get saleFormIsValid =>
      (validateAmount(amount.value) == null &&
      validateField(driverId.value) == null &&
      validateField(vehicleId.value) == null).obs;
}
