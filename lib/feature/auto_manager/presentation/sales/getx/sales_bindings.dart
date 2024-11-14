import 'package:automanager/feature/auto_manager/domain/domain.dart';
import 'package:automanager/feature/auto_manager/presentation/sales/getx/sales_controller.dart';
import 'package:get/get.dart';

class SalesBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalesController>(
      () => SalesController(
          fetchSales: FetchSales(
            autoManagerRepository: Get.find(),
          ),
          fetchVehicles: FetchVehicles(
            autoManagerRepository: Get.find(),
          ),
          fetchDrivers: FetchDrivers(
            autoManagerRepository: Get.find(),
          ),
          addSale: AddSale(
            autoManagerRepository: Get.find(),
          ), deleteSale: DeleteSale(
            autoManagerRepository: Get.find(),
      )),
    );
  }
}
