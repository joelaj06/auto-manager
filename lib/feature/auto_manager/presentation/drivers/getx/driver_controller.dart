import 'package:automanager/core/core.dart';
import 'package:automanager/feature/authentication/data/data.dart';
import 'package:automanager/feature/auto_manager/data/data.dart';
import 'package:automanager/feature/auto_manager/domain/domain.dart';
import 'package:automanager/feature/auto_manager/presentation/drivers/arguments/driver_argument.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class DriverController extends GetxController {
  DriverController(
      {required this.fetchDrivers,
      required this.updateDriver,
      required this.deleteDriver,
      required this.addUser});

  final FetchDrivers fetchDrivers;
  final UpdateUser updateDriver;
  final DeleteDriver deleteDriver;
  final AddUser addUser;

  //reactive variables
  RxBool isLoading = false.obs;
  RxInt totalCount = 0.obs;
  RxList<Driver> drivers = <Driver>[].obs;
  RxString query = ''.obs;
  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  RxString email = ''.obs;
  RxString phone = ''.obs;
  RxString licenseNumber = ''.obs;
  RxString licenseExpiryDate = ''.obs;
  Rx<Vehicle> selectedVehicle = Vehicle.empty().obs;
  RxList<Vehicle> vehicles = <Vehicle>[].obs;
  Rx<TextEditingController> licenseExpiryDateController =
      TextEditingController().obs;
  Rx<DateTime> selectedLicenseExpiryDate = DateTime.now().obs;

  //paging controller
  final PagingController<int, Driver> pagingController =
      PagingController<int, Driver>(firstPageKey: 1);

  @override
  void onInit() {
    pagingController.addPageRequestListener((int pageKey) {
      getDrivers(pageKey);
    });
    super.onInit();
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }

  void deleteTheDriver(Driver driver) async {
    isLoading(true);
    final Either<Failure, Driver> failureOrUnit =
        await deleteDriver(driver.id!);
    isLoading(false);
    failureOrUnit.fold((Failure failure) {
      AppSnack.show(message: failure.message, status: SnackStatus.error);
    }, (_) {
      isLoading(false);
      AppSnack.show(
          message: 'Driver deleted successfully', status: SnackStatus.success);
      pagingController.refresh();
    });
  }

  void updateTheDriver(String driverId) async {
    final UserRequest userRequest = UserRequest(
        id: driverId,
        firstName: firstName.value.isNotEmpty ? firstName.value : null,
        lastName: lastName.value.isNotEmpty ? lastName.value : null,
        email: email.value.isNotEmpty ? email.value : null,
        phone: phone.value.isNotEmpty ? phone.value : null,
        licenseNumber:
            licenseNumber.value.isNotEmpty ? licenseNumber.value : null,
        licenceExpiryDate:
            selectedLicenseExpiryDate.value.toIso8601String().isNotEmpty
                ? selectedLicenseExpiryDate.value.toIso8601String()
                : null,
        vehicleId: (selectedVehicle.value.id ?? '').isNotEmpty
            ? selectedVehicle.value.id
            : null);

    final Either<Failure, User> failureOrDriver =
        await updateDriver(userRequest);
    isLoading(true);
    failureOrDriver.fold((Failure failure) {
      isLoading(false);
      AppSnack.show(message: failure.message, status: SnackStatus.error);
    }, (User newDriver) {
      isLoading(false);
      pagingController.refresh();
      Get.back<dynamic>(result: newDriver);
    });
  }

  void addADriver() async {
    final UserRequest userRequest = UserRequest(
        firstName: firstName.value,
        lastName: lastName.value,
        email: email.value,
        phone: phone.value,
        role: 'driver',
        licenseNumber: licenseNumber.value,
        licenceExpiryDate: selectedLicenseExpiryDate.value.toIso8601String(),
        vehicleId: selectedVehicle.value.id);
    final Either<Failure, User> failureOrDriver = await addUser(userRequest);

    isLoading(true);

    failureOrDriver.fold((Failure failure) {
      isLoading(false);
      AppSnack.show(message: failure.message, status: SnackStatus.error);
    }, (User newDriver) {
      isLoading(false);
      pagingController.refresh();
      Get.back<dynamic>(result: newDriver);
    });
  }

  void getDrivers(int pageKey) async {
    final Either<Failure, ListPage<Driver>> failureOrDrivers =
        await fetchDrivers(PageParams(
      query: query.value,
      pageIndex: pageKey,
      pageSize: 10,
    ));

    failureOrDrivers.fold((Failure failure) {
      isLoading(false);
      pagingController.error = failure.message;
    }, (ListPage<Driver> newPage) {
      isLoading(false);
      final Map<String, dynamic>? meta = newPage.metaData;
      if (meta != null) {
        totalCount(meta['totalCount']);
      }
      //check if the new page is the last page
      final int previouslyFetchedItemsCount =
          pagingController.itemList?.length ?? 0;

      final bool isLastPage = newPage.isLastPage(previouslyFetchedItemsCount);
      final List<Driver> newItems = newPage.itemList;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final int nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
    });
  }

  void navigateToUpdateDriverScreen(Driver driver) async {
    final dynamic res = await Get.toNamed(
      AppRoutes.addDriver,
      arguments: DriverArgument(driver),
    );
    if (res != null) {
      AppSnack.show(
          message: 'Driver updated successfully', status: SnackStatus.success);
    }
  }

  void clearFields() {
    firstName('');
    lastName('');
    email('');
    phone('');
    licenseNumber('');
    licenseExpiryDate('');
    selectedLicenseExpiryDate(DateTime.now());
    selectedVehicle(Vehicle.empty());
  }

  void getDriverDataFromArgs(Driver driver) {
    licenseExpiryDateController.value.text =
        DataFormatter.formatDateToString(driver.licenceExpiryDate!);
  }

  void selectExtendedDate(BuildContext context) async {
    final DateTime? res = await AppDatePicker.showOnlyDatePicker(context);
    if (res != null) {
      selectedLicenseExpiryDate(res);
      licenseExpiryDateController.value.text =
          DataFormatter.formatDateToString(res.toIso8601String());
    }
  }

  void onVehicleSelected(Vehicle vehicle) {
    selectedVehicle(vehicle);
  }

  void onEmailInputChanged(String value) {
    email(value);
  }

  void onLicenseNumberInputChanged(String value) {
    licenseNumber(value);
  }

  void onLicenseExpiryDateInputChanged(String value) {
    licenseExpiryDate(value);
  }

  void onFirstNameInputChanged(String value) {
    firstName(value);
  }

  void onPhoneInputChanged(String value) {
    phone(value);
  }

  void onLastNameInputChanged(String value) {
    lastName(value);
  }

  String? validateField(String? value) {
    String? errorMessage;
    if (value!.isEmpty) {
      errorMessage = 'Field is required';
    }
    return errorMessage;
  }

  RxBool get driverFormIsValid => (validateField(firstName.value) == null &&
          validateField(lastName.value) == null)
      .obs;
}
