import 'package:automanager/feature/authentication/domain/domain.dart';
import 'package:automanager/feature/auto_manager/domain/domain.dart';
import 'package:get/get.dart';

import 'company_controller.dart';

class CompanyBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompanyController>(() => CompanyController(
      addCompany: AddCompany(
        autoManagerRepository: Get.find(),
      ), loadUserSignupData: LoadUserSignupData(
      authRepository: Get.find()
    )
    ));
  }
}