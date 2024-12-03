import 'package:get/get.dart';

import '../../../domain/usecase/vehicle/vehicle.dart';
import 'vehicle_controller.dart';

class VehicleBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VehicleController>(() => VehicleController(
        fetchVehicles: FetchVehicles(
          autoManagerRepository: Get.find(),
        ),
        addVehicle: AddVehicle(
          autoManagerRepository: Get.find(),
        ),
        updateVehicle: UpdateVehicle(
          autoManagerRepository: Get.find(),
        ),
        deleteVehicle: DeleteVehicle(
          autoManagerRepository: Get.find(),
        )));
  }
}
