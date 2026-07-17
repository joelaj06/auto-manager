import '../../../data/model/response/driver/driver_model.dart';
import '../../../data/model/response/work_and_pay/work_and_pay_agreement_model.dart';

class WorkAndPayArguments {
  WorkAndPayArguments({
    this.agreementId,
    this.workAndPayAgreement,
    this.driverId,
    this.driver,
  });

  final String? agreementId;
  final WorkAndPayAgreement? workAndPayAgreement;
  final String? driverId;
  final Driver? driver;
}

