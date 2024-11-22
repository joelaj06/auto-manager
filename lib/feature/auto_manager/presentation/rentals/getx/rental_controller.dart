import 'dart:async';

import 'package:automanager/core/usecase/usecase.dart';
import 'package:automanager/feature/auto_manager/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/presentation/routes/routes.dart';
import '../../../../../core/presentation/utils/utils.dart';
import '../../../data/model/model.dart';

class RentalController extends GetxController {
  RentalController(
      {required this.fetchRentals,
      required this.addRental,
      required this.updateRental,
      required this.deleteRental,
      required this.fetchCustomers,
      required this.fetchVehicles});

  final FetchRentals fetchRentals;
  final AddRental addRental;
  final UpdateRental updateRental;
  final DeleteRental deleteRental;
  final FetchCustomers fetchCustomers;
  final FetchVehicles fetchVehicles;

  //reactive variables
  RxInt totalCount = 0.obs;
  RxDouble totalAmount = 0.0.obs;
  RxList<Rental> rentals = <Rental>[].obs;
  RxString dateText = 'This Month'.obs;
  Rx<DateTime> startDate =
      DateTime(DateTime.now().year, DateTime.now().month, 1).obs;
  Rx<DateTime> endDate = DateTime.now().obs;
  RxBool isLoading = false.obs;
  Rx<Customer> selectedCustomer = Customer.empty().obs;
  Rx<Vehicle> selectedVehicle = Vehicle.empty().obs;
  RxList<Customer> customers = <Customer>[].obs;
  RxList<Vehicle> vehicles = <Vehicle>[].obs;
  RxDouble amount = (0.0).obs;
  RxString amountPaid = ('0.0').obs;
  RxString cost = ('0.0').obs;
  Rx<TextEditingController> dateController = TextEditingController().obs;
  Rx<DateTime> startingDate = DateTime.now().obs;
  Rx<DateTime> returnDate = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day + 1)
      .obs;
  RxInt days = 0.obs;
  RxString note = ''.obs;
  RxString purpose = ''.obs;
  RxDouble balance = 0.0.obs;
  RxString customerQuery = ''.obs;
  RxBool isCustomerSearching = false.obs;

  //paging controller
  final PagingController<int, Rental> pagingController =
      PagingController<int, Rental>(firstPageKey: 1);
  Timer? _debounceTimer;

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

  void deleteTheRental(Rental rental) async {
    final Either<Failure, Rental> failureOrRental =
        await deleteRental(rental.id);
    failureOrRental.fold((Failure failure) {
      AppSnack.show(message: failure.message, status: SnackStatus.error);
    }, (Rental rental) {
      pagingController.refresh();
    });
  }

  void updateTheRental(Rental rental) async {
    final RentalRequest updateRentalRequest = RentalRequest(
        renter: rental.renter!.id,
        vehicle: rental.vehicle!.id,
        startDate: rental.startDate,
        endDate: rental.endDate,
        cost: rental.cost,
        status: rental.status,
        amountPaid: rental.amountPaid,
        balance: rental.balance,
        totalAmount: rental.totalAmount,
        receiptNumber: rental.receiptNumber,
        purpose: rental.purpose,
        note: rental.note);
    final Either<Failure, Rental> failureOrRental =
        await updateRental(updateRentalRequest);
    failureOrRental.fold((Failure failure) {
      AppSnack.show(message: failure.message, status: SnackStatus.error);
    }, (Rental rental) {
      pagingController.refresh();
      Get.back<dynamic>(result: rental);
    });
  }

  void addNewRental() async {
    isLoading(true);
    final RentalRequest addRentalRequest = RentalRequest(
      renter: selectedCustomer.value.id,
      vehicle: selectedVehicle.value.id,
      startDate: startingDate.value.toIso8601String(),
      endDate: returnDate.value.toIso8601String(),
      cost: double.tryParse(cost.value) ?? 0.0,
      status: 'active',
      amountPaid: double.tryParse(amountPaid.value),
      balance: balance.value,
      totalAmount: double.tryParse(cost.value) ?? 0.0,
      receiptNumber: '0',
      purpose: purpose.value,
      note: note.value,
    );
    final Either<Failure, Rental> failureOrRental =
        await addRental(addRentalRequest);
    failureOrRental.fold((Failure failure) {
      isLoading(false);
      AppSnack.show(message: failure.message, status: SnackStatus.error);
    }, (Rental rental) {
      isLoading(false);
      endDate(DateTime.now());
      pagingController.refresh();
      Get.back<dynamic>(result: rental);
    });
  }

  String displayStringForOption(Customer customer) => customer.name;

  Future<void> onCustomerSearchChanged(String query) async {
    _debounceTimer?.cancel(); // Cancel any existing timer
    // wait for 1s before refreshing the controller
    _debounceTimer = Timer(const Duration(seconds: 1), () async {
      customerQuery(query);
      if (query.isNotEmpty &&
          query.length > 1 &&
          query != selectedCustomer.value.name) {
        await getCustomers();
      }
    });
  }

  Future<void> getCustomers() async {
    isCustomerSearching(true);
    final Either<Failure, ListPage<Customer>> failureOrCustomers =
        await fetchCustomers(
            PageParams(pageIndex: 1, pageSize: 10, query: customerQuery.value));
    failureOrCustomers.fold((Failure failure) {
      isCustomerSearching(false);
      AppSnack.show(message: failure.message, status: SnackStatus.error);
    }, (ListPage<Customer> newPage) {
      isCustomerSearching(false);
      customers(newPage.itemList);
    });
  }

  void fetchAllVehicles() async {
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
      },
    );

  }

  void getRentals(int pageKey) async {
    isLoading(true);
    final Either<Failure, ListPage<Rental>> failureOrRentals =
        await fetchRentals(
      PageParams(
        pageIndex: pageKey,
        pageSize: 10,
        startDate: startDate.value.toIso8601String(),
        endDate: endDate.value.toIso8601String(),
      ),
    );

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

  void navigateToUpdateRentalScreen(Rental rental) async {
    final dynamic result =
        await Get.toNamed(AppRoutes.addRental, arguments: rental);
    if (result != null) {
      AppSnack.show(
        message: 'Rental updated successfully',
        status: SnackStatus.success,
      );
    }
  }

  void navigateToAddRentalScreen() async {
    final dynamic result = await Get.toNamed(AppRoutes.addRental);
    if (result != null) {
      AppSnack.show(
        message: 'Rental added successfully',
        status: SnackStatus.success,
      );
    }
  }

  void onDateRangeSelected(BuildContext context) async {
    final DateRangeValues dateRangeValues =
        await AppDatePicker.showDateRangePicker(context);
    startDate(dateRangeValues.startDate);
    endDate(dateRangeValues.endDate);
    dateText(AppDatePicker.getTextDate(dateRangeValues));
    pagingController.refresh();
  }

  void selectDate(BuildContext context) async {
    final DateRangeValues dateRangeValues =
        await AppDatePicker.showDateRangePicker(context);
    startingDate(dateRangeValues.startDate);
    returnDate(dateRangeValues.endDate);
    final int numOfDays =
        returnDate.value.difference(startingDate.value).inDays;
    days(numOfDays);

    dateController.value.text = '${AppDatePicker.getTextDate(dateRangeValues)}'
        ' ($numOfDays Days)';
  }

  void calculateBalance() {
    final double amtPaid = double.tryParse(amountPaid.value) ?? 0.0;
    final double rentalCost = double.tryParse(cost.value) ?? 0.0;
    final double bal =  amtPaid - rentalCost ;
    balance(bal.toPrecision(2));
  }

  void onNotesInputChanged(String? value) {
    note(value);
  }

  void onPurposeInputChanged(String? value) {
    purpose(value);
  }

  void onRentalCostInputChanged(String? value) {
    cost(value);
    calculateBalance();
  }

  void onAmountPaidInputChanged(String? value) {
    amountPaid(value);
    calculateBalance();
  }

  void onVehicleSelected(Vehicle vehicle) {
    selectedVehicle(vehicle);
  }

  void onCustomerSelected(Customer customer) {
    selectedCustomer(customer);
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
    if ((double.tryParse(cost.value) ?? 0) <= 0) {
      errorMessage = 'Amount should be greater than 0';
    }
    return errorMessage;
  }

  RxBool get rentalFormIsValid => (validateAmount(cost.value) == null &&
          validateField(selectedCustomer.value.id) == null &&
          validateField(selectedVehicle.value.id) == null &&
          validateField(startingDate.value.toIso8601String()) == null)
      .obs;
}
