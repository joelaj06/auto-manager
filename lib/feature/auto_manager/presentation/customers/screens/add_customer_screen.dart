import 'package:automanager/feature/auto_manager/presentation/customers/customers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/utils/utils.dart';
import '../../../../../core/presentation/widgets/widgets.dart';

class AddCustomerScreen extends GetView<CustomerController> {
  const AddCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomerArgument? args = Get.arguments as CustomerArgument?;

    controller.clearFields();

    if (args != null) {
      controller.getCustomerDataFromArgs(args.customer);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Customer'),
      ),
      bottomNavigationBar: _buildBottomBar(context, arg: args),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPaddings.mA,
          child: Column(
            children: <Widget>[
              AppTextInputField(
                labelText: 'Name',
                onChanged: controller.onNameInputChanged,
                validator: controller.validateField,
                initialValue: args != null ? args.customer.name : '',
              ),
              const AppSpacing(v: 10),
              AppTextInputField(
                labelText: 'Email',
                onChanged: controller.onEmailInputChanged,
                initialValue: args != null ? args.customer.email : '',
              ),
              const AppSpacing(v: 10),
              AppTextInputField(
                labelText: 'address',
                initialValue: args != null ? args.customer.address : '',
              ),
              const AppSpacing(v: 10),
              AppTextInputField(
                labelText: 'Phone',
                onChanged: controller.onPhoneInputChanged,
                textInputType: TextInputType.phone,
                validator: controller.validateField,
                initialValue: args != null ? args.customer.phone : '',
              ),
              const AppSpacing(v: 10),
              AppTextInputField(
                labelText: 'ID Number',
                onChanged: controller.onIdNumberInputChanged,
                initialValue:
                    args != null ? args.customer.identificationNumber : '',
              ),
              const AppSpacing(v: 10),
              AppTextInputField(
                labelText: 'Occupation',
                onChanged: controller.onOccupationInputChanged,
                initialValue: args != null ? args.customer.occupation : '',
              ),
              const AppSpacing(v: 10),
              AppTextInputField(
                labelText: 'Business',
                onChanged: controller.onBusinessInputChanged,
                initialValue: args != null ? args.customer.business : '',
              ),
              const AppSpacing(v: 10),
              Obx(
                () => AppTextInputField(
                  controller: controller.dobTextEditingController.value,
                  labelText: 'Date Of Birth',
                  validator: (String? value) => null,
                  textInputType: TextInputType.datetime,
                  hintText: controller.dobTextEditingController.value.text,
                  readOnly: true,
                  onTap: () {
                    controller.selectDateOfBirth(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context,
      {required CustomerArgument? arg}) {
    return Padding(
      padding: AppPaddings.mA,
      child: SizedBox(
        height: 70,
        child: Obx(
          () => AppButton(
            text: arg != null ? 'Update' : 'Save',
            onPressed: () {
              arg != null
                  ? controller.updateTheCustomer(arg.customer.id!)
                  : controller.addNewCustomer();
            },
            enabled: arg != null
                ? !controller.isLoading.value
                : controller.customerFormIsValid.value &&
                    !controller.isLoading.value,
          ),
        ),
      ),
    );
  }
}
