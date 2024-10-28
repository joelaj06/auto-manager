import 'package:get/get.dart';

import 'company_controller.dart';

class CompanyBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompanyController>(() => CompanyController());
  }
}