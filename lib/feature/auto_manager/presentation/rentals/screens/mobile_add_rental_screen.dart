import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/utils/utils.dart';
import '../../../../../core/presentation/widgets/widgets.dart';
import '../arguments/add_rental_argument.dart';
import '../getx/rental_controller.dart';
import '../widgets/rental_form_fields.dart';

class MobileAddRentalScreen extends StatelessWidget {
  const MobileAddRentalScreen({
    super.key,
    required this.controller,
    this.args,
  });

  final RentalController controller;
  final AddRentalArgument? args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(args != null ? 'Update Rental' : 'New Rental'),
      ),
      bottomNavigationBar: _buildBottomBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPaddings.mA,
          child: RentalFormFields(controller: controller, args: args),
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
            text: controller.isLoading.value
                ? 'Loading...'
                : args != null
                    ? 'Update'
                    : 'Save',
            onPressed: () {
              args != null
                  ? controller.updateTheRental(args!.rental)
                  : controller.addNewRental();
            },
            enabled: controller.rentalFormIsValid.value &&
                !controller.isLoading.value,
          ),
        ),
      ),
    );
  }
}
