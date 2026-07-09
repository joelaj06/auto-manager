import 'package:get/get.dart';

import '../../../domain/domain.dart';
import 'driver_detail_controller.dart';

class DriverDetailBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DriverDetailController>(
      () => DriverDetailController(
        fetchWorkAndPayAgreementByDriverId: FetchWorkAndPayAgreementByDriverId(
          autoManagerRepository: Get.find(),
        ),
        deleteDriver: DeleteDriver(autoManagerRepository: Get.find()),
        fetchDriver: FetchDriver(autoManagerRepository: Get.find()),
      ),
    );
  }
}
