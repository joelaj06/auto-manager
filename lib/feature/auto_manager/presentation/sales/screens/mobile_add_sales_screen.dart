import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/presentation/utils/app_padding.dart';
import '../../../../../core/presentation/widgets/app_button.dart';
import '../getx/sales_controller.dart';
import '../widgets/sales_form_fields.dart';

class MobileAddSaleScreen extends StatelessWidget {
  const MobileAddSaleScreen({required this.controller});

  final SalesController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      appBar: AppBar(
        title: const Text('New Sale'),
      ),
      bottomNavigationBar: _buildBottomBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: AppPaddings.mH,
            child: SaleFormFields(controller: controller),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Obx(
            () => AppButton(
          text: controller.isLoading.value ? 'Loading...' : 'Save',
          onPressed: controller.onSaleSaved,
          enabled: controller.saleFormIsValid.value &&
              !controller.isLoading.value,
        ),
      ),
    );
  }
}
