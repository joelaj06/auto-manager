import 'package:automanager/feature/authentication/domain/domain.dart';
import 'package:automanager/feature/auto_manager/domain/domain.dart';
import 'package:automanager/feature/auto_manager/presentation/dashboard/getx/dashboard_controller.dart';
import 'package:get/get.dart';

class DashboardBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
      () => DashboardController(
        fetchDashboardSummaryData: FetchDashboardSummaryData(
          autoManagerRepository: Get.find(),
        ),
        fetchMonthlySales: FetchMonthlySales(
          autoManagerRepository: Get.find(),
        ),
        loadUser: LoadUser(authRepository: Get.find()),
        fetchCompany: FetchCompany(autoManagerRepository: Get.find()),
      ),
    );
  }
}
