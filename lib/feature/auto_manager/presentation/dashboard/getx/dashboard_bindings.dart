import 'package:automanager/feature/auto_manager/presentation/dashboard/getx/dashboard_controller.dart';
import 'package:get/get.dart';
class DashboardBindings extends Bindings {
  @override
  void dependencies() {
   Get.lazyPut<DashboardController>(() => DashboardController());
  }

}