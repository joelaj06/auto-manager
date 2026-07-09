import 'package:automanager/core/core.dart';
import 'package:automanager/feature/auto_manager/domain/domain.dart';
import 'package:automanager/feature/auto_manager/presentation/drivers/arguments/driver_argument.dart';
import 'package:automanager/feature/auto_manager/presentation/work_pay/arguments/work_pay_arguments.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../data/model/model.dart';

class DriverDetailController extends GetxController {
  DriverDetailController({
    required this.fetchWorkAndPayAgreementByDriverId,
    required this.deleteDriver,
    required this.fetchDriver,
  });

  final FetchWorkAndPayAgreementByDriverId fetchWorkAndPayAgreementByDriverId;
  final DeleteDriver deleteDriver;
  final FetchDriver fetchDriver;

  final Rxn<Driver> driver = Rxn<Driver>();
  final Rxn<WorkAndPayAgreement> workAndPayAgreement = Rxn<WorkAndPayAgreement>();
  final RxBool isLoading = false.obs;
  final RxBool isLoadingWorkPay = false.obs;

  @override
  void onInit() {

    super.onInit();
  }

  @override
  void onReady() {
    final DriverArgument? args = Get.arguments as DriverArgument?;
    if (args != null) {
      driver.value = args.driver;
      _fetchWorkAndPay(args.driver.id!);
    }
    super.onReady();
  }

  Future<void> _fetchWorkAndPay(String driverId) async {
    isLoadingWorkPay(true);
    final Either<Failure, WorkAndPayAgreement> result =
        await fetchWorkAndPayAgreementByDriverId(driverId);
    
    isLoadingWorkPay(false);
    result.fold(
      (Failure failure) {
        // If 404 or not found, it just means no agreement exists
        workAndPayAgreement.value = null;
      },
      (WorkAndPayAgreement agreement) {
        workAndPayAgreement.value = agreement;
      },
    );
  }

  void deleteTheDriver() async {
    if (driver.value == null) return;
    isLoading(true);
    final Either<Failure, Driver> result = await deleteDriver(driver.value!.id!);
    isLoading(false);
    result.fold(
      (Failure failure) {
        AppSnack.show(message: failure.message, status: SnackStatus.error);
      },
      (_) {
        AppSnack.show(message: 'Driver deleted successfully', status: SnackStatus.success);
        Get.back(result: true);
      },
    );
  }

  void navigateToUpdateDriver() async {
    if (driver.value == null) return;
    final dynamic result = await Get.toNamed(
      AppRoutes.addDriver,
      arguments: DriverArgument(driver.value!),
    );
    if (result != null) {
      if (result is Driver) {
        driver.value = result;
      } else {
        _refreshDriverData();
      }
    }
  }

  Future<void> _refreshDriverData() async {
    if (driver.value == null) return;
    isLoading(true);
    final result = await fetchDriver(driver.value!.id!);
    isLoading(false);
    result.fold(
      (failure) => AppSnack.show(message: failure.message, status: SnackStatus.error),
      (updatedDriver) {
        driver.value = updatedDriver;
      },
    );
  }

  void navigateToWorkAndPay() {
    if (workAndPayAgreement.value != null) {
      Get.toNamed(
        AppRoutes.workAndPay,
        arguments: WorkAndPayArguments(
          agreementId: workAndPayAgreement.value!.id,
          workAndPayAgreement: workAndPayAgreement.value,
        ),
      );
    } else {
      AppSnack.show(message: 'No Work & Pay agreement found for this driver', status: SnackStatus.info);
    }
  }
}
