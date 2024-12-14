import 'package:automanager/feature/auto_manager/domain/domain.dart';
import 'package:automanager/feature/auto_manager/presentation/rentals/getx/rental_controller.dart';
import 'package:get/get.dart';

class RentalBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RentalController>(
      () => RentalController(
        fetchRentals: FetchRentals(
          autoManagerRepository: Get.find(),
        ),
        addRental: AddRental(
          autoManagerRepository: Get.find(),
        ),
        updateRental: UpdateRental(
          autoManagerRepository: Get.find(),
        ),
        deleteRental: DeleteRental(
          autoManagerRepository: Get.find(),
        ),
        fetchCustomers: FetchCustomers(
          autoManagerRepository: Get.find(),
        ),
        fetchVehicles: FetchVehicles(
          autoManagerRepository: Get.find(),
        ),
        extendRental: ExtendRental(
          autoManagerRepository: Get.find(),
        ),
        removeExtension: RemoveExtension(
          autoManagerRepository: Get.find(),
        ),
      ),
    );
  }
}
