import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/presentation.dart';
import '../../../../../core/presentation/theme/app_theme.dart';
import '../arguments/customer_argument.dart';
import '../getx/customer_controller.dart';
import '../widgets/customer_form_fields.dart';

class AddCustomerScreen extends GetView<CustomerController> {
  const AddCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomerArgument? args = Get.arguments as CustomerArgument?;

    controller.clearFields();
    if (args != null) {
      controller.getCustomerDataFromArgs(args.customer);
    }

    final bool isWide = MediaQuery.of(context).size.width >= 768;

    return isWide
        ? _WebAddCustomerModal(controller: controller, args: args)
        : _MobileAddCustomerScreen(controller: controller, args: args);
  }
}

class _MobileAddCustomerScreen extends StatelessWidget {
  const _MobileAddCustomerScreen({required this.controller, this.args});

  final CustomerController controller;
  final CustomerArgument? args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(args != null ? 'Update Customer' : 'New Customer'),
      ),
      bottomNavigationBar: _buildBottomBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPaddings.mA,
          child: CustomerFormFields(controller: controller),
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Padding(
      padding: AppPaddings.mA,
      child: SizedBox(
        height: 70,
        child: Obx(
          () => AppButton(
            text: args != null ? 'Update' : 'Save',
            onPressed: () {
              args != null
                  ? controller.updateTheCustomer(args!.customer.id)
                  : controller.addNewCustomer();
            },
            enabled: controller.customerFormIsValid.value && !controller.isLoading.value,
            loading: controller.isLoading.value,
          ),
        ),
      ),
    );
  }
}

class _WebAddCustomerModal extends StatelessWidget {
  const _WebAddCustomerModal({required this.controller, this.args});

  final CustomerController controller;
  final CustomerArgument? args;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colorScheme;

    return Scaffold(
      backgroundColor: Colors.black.withValues(alpha: 0.45),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Material(
            color: colors.surface,
            borderRadius: BorderRadius.circular(14),
            clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ModalHeader(
                  title: args != null ? 'Update Customer' : 'New Customer',
                  onClose: () => Get.back(),
                ),
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
                    child: CustomerFormFields(controller: controller),
                  ),
                ),
                Obx(
                  () => ModalFooter(
                    onSave: controller.customerFormIsValid.value && !controller.isLoading.value
                        ? () {
                            if (args != null) {
                              controller.updateTheCustomer(args!.customer.id);
                            } else {
                              controller.addNewCustomer();
                            }
                          }
                        : null,
                    isLoading: controller.isLoading.value,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
