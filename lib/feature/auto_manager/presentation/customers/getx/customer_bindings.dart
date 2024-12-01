import 'package:automanager/feature/auto_manager/domain/domain.dart';
import 'package:get/get.dart';

import 'customer_controller.dart';

class CustomerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerController>(() => CustomerController(
          fetchCustomers: FetchCustomers(
            autoManagerRepository: Get.find(),
          ),
          addCustomer: AddCustomer(
            autoManagerRepository: Get.find(),
          ),
          updateCustomer: UpdateCustomer(
            autoManagerRepository: Get.find(),
          ),
          deleteCustomer: DeleteCustomer(
            autoManagerRepository: Get.find(),
          ),
        ));
  }
}
