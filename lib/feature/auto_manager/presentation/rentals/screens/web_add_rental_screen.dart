import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/theme/app_theme.dart';
import '../../../../../core/presentation/widgets/modal_header.dart';
import '../arguments/add_rental_argument.dart';
import '../getx/rental_controller.dart';
import '../widgets/rental_form_fields.dart';

class WebAddRentalModal extends StatelessWidget {
  const WebAddRentalModal({
    super.key,
    required this.controller,
    this.args,
  });

  final RentalController controller;
  final AddRentalArgument? args;

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
                  title: args != null ? 'Update Rental' : 'New Rental',
                  onClose: () => Get.back(),
                ),
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
                    child: RentalFormFields(controller: controller, args: args),
                  ),
                ),
                Obx(
                  () => ModalFooter(
                    onSave: controller.rentalFormIsValid.value &&
                            !controller.isLoading.value
                        ? () {
                            if (args != null) {
                              controller.updateTheRental(args!.rental);
                            } else {
                              controller.addNewRental();
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
