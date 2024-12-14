import 'package:automanager/feature/auto_manager/data/data.dart';
import 'package:automanager/feature/auto_manager/data/data.dart';
import 'package:automanager/feature/auto_manager/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/presentation/routes/app_routes.dart';
import '../../../../../core/presentation/utils/app_snack.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../../../core/utils/utils.dart';
import '../arguments/vehicle_argument.dart';

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
  RxString make = ''.obs;
  RxString model = ''.obs;
  RxString year = ''.obs;
  RxString color = ''.obs;
  RxString plateNumber = ''.obs;
  RxString image = ''.obs;
  RxBool isVehicleReleased = false.obs;
  RxString status = ''.obs;

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

  void addNewVehicle() async {
    final VehicleRequest vehicleRequest = VehicleRequest(
      make: make.value,
      model: model.value,
      year: int.parse(year.value),
      color: color.value,
      licensePlate: plateNumber.value,
      image: image.value,
    );

    isLoading(true);
    final Either<Failure, Vehicle> failureOrVehicle =
        await addVehicle(vehicleRequest);
    failureOrVehicle.fold((Failure failure) {
      isLoading(false);
      AppSnack.show(message: failure.message, status: SnackStatus.error);
    }, (Vehicle vehicle) {
      isLoading(false);
      pagingController.refresh();
      Get.back<dynamic>(result: vehicle);
    });
  }

  void updateTheVehicle(String vehicleId) async {
    final VehicleRequest vehicleRequest = VehicleRequest(
      id: vehicleId,
      make: make.value.isNotEmpty ? make.value : null,
      model: model.value.isNotEmpty ? model.value : null,
      year: year.value.isNotEmpty ? int.parse(year.value) : null,
      color: color.value.isNotEmpty ? color.value : null,
      licensePlate: plateNumber.value.isNotEmpty ? plateNumber.value : null,
      image: image.value,
      status: isVehicleReleased.value ? VehicleStatus.available.name : null,
    );
    isLoading(true);
    final Either<Failure, Vehicle> failureOrVehicle =
        await updateVehicle(vehicleRequest);
    isLoading(false);
    failureOrVehicle.fold((Failure failure) {
      AppSnack.show(message: failure.message, status: SnackStatus.error);
    }, (Vehicle vehicle) {
      isLoading(false);
      pagingController.refresh();
      Get.back<dynamic>(result: vehicle);
    });
  }

  void deleteTheVehicle(String vehicleId) async {
    isLoading(true);
    final Either<Failure, Vehicle> failureOrVehicle =
        await deleteVehicle(vehicleId);
    isLoading(false);
    failureOrVehicle.fold((Failure failure) {
      AppSnack.show(message: failure.message, status: SnackStatus.error);
    }, (Vehicle vehicle) {
      pagingController.refresh();
      AppSnack.show(
        message: 'Vehicle deleted successfully',
        status: SnackStatus.success,
      );
    });
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
      pagingController.error = failure;
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

  void navigateToAddVehicleScreen() async {
    final dynamic result = await Get.toNamed(AppRoutes.addVehicle);
    if (result != null) {
      AppSnack.show(
        message: 'Vehicle added successfully',
        status: SnackStatus.success,
      );
    }
  }

  void navigateToUpdateVehicleScreen(Vehicle vehicle) async {
    final dynamic result = await Get.toNamed(
      AppRoutes.addVehicle,
      arguments: VehicleArgument(vehicle),
    );
    if (result != null) {
      AppSnack.show(
        message: 'Vehicle updated successfully',
        status: SnackStatus.success,
      );
    }
  }

  void addImage() async {
    await <Permission>[
      Permission.storage,
      Permission.camera,
    ].request();
    final String? img = await AppImagePicker.showImagePicker();
    if (img != null) {
      image(img);
    }
  }

  void removeProfileImage() {
    image('');
  }

  void clearFields() {
    make('');
    model('');
    year('');
    color('');
    plateNumber('');
    image('');
  }

  void getVehicleDataFromArgs(Vehicle vehicle) {
    make(vehicle.make);
    model(vehicle.model);
    year(vehicle.year.toString());
    color(vehicle.color);
    plateNumber(vehicle.licensePlate);
    image(vehicle.image);
  }

  void toggleVehicleRelease(bool value) {
    isVehicleReleased(value);
  }

  void onMakeInputChanged(String value) {
    make(value);
  }

  void onModelInputChanged(String value) {
    model(value);
  }

  void onYearInputChanged(String value) {
    year(value);
  }

  void onPlateNumberInputChanged(String value) {
    plateNumber(value);
  }

  void onColorInputChanged(String value) {
    color(value);
  }

  void onSearchFieldInputChanged(String value) {
    query(value);
  }

  void onSearchQuerySubmitted() {
    pagingController.refresh();
  }

  String? validateField(String? value) {
    String? errorMessage;
    if (value!.isEmpty) {
      errorMessage = 'Field is required';
    }
    return errorMessage;
  }

  RxBool get customerFormIsValid => (
          validateField(make.value) == null &&
          validateField(color.value) == null &&
          validateField(model.value) == null &&
          validateField(year.value) == null)
      .obs;
}

enum VehicleStatus{
  available,
  rented,
}
