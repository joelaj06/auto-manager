import 'package:automanager/feature/auto_manager/domain/usecase/work_pay/work_pay.dart';
import 'package:automanager/feature/auto_manager/presentation/work_pay/getx/work_and_pay_controller.dart';
import 'package:get/get.dart';

class WorkAndPayBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<WorkAndPayController>(
      WorkAndPayController(
        initiateWorkAndPayAgreement: InitiateWorkAndPayAgreement(
          autoManagerRepository: Get.find(),
        ),

        recordWorkAndPayPayment: RecordWorkAndPayPayment(
          autoManagerRepository: Get.find(),
        ),

        fetchWorkAndPayAgreement: FetchWorkAndPayAgreement(
          autoManagerRepository: Get.find(),
        ),

        fetchWorkAndPayPayments: FetchWorkAndPayPayments(
          autoManagerRepository: Get.find(),
        ),
      ),
    );
  }
}
