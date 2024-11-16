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
      ),
    );
  }
}
