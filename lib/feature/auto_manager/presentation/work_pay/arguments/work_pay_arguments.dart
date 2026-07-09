import '../../../data/model/response/work_and_pay/work_and_pay_agreement_model.dart';

class WorkAndPayArguments {
  WorkAndPayArguments({
    this.agreementId,
    this.workAndPayAgreement,
  });

  final String? agreementId;
  final WorkAndPayAgreement? workAndPayAgreement;
}

