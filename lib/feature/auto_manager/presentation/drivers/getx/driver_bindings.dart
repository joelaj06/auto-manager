import 'package:automanager/feature/auto_manager/domain/domain.dart';
import 'package:get/get.dart';

import 'driver_controller.dart';

class DriverBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DriverController>(() => DriverController(
          fetchDrivers: FetchDrivers(
            autoManagerRepository: Get.find(),
          ),
          updateDriver: UpdateUser(
            autoManagerRepository: Get.find(),
          ),
          deleteDriver: DeleteDriver(
            autoManagerRepository: Get.find(),
          ),
          addDriver: AddDriver(
            autoManagerRepository: Get.find(),
          ),
          fetchVehicles: FetchVehicles(
            autoManagerRepository: Get.find(),
          ),
        ));
  }
}
