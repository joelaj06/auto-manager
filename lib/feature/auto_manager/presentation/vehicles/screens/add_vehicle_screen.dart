import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/presentation.dart';
import '../../../../../core/presentation/theme/app_theme.dart';
import '../arguments/vehicle_argument.dart';
import '../getx/vehicle_controller.dart';
import '../widgets/vehicle_form_fields.dart';

class AddVehicleScreen extends GetView<VehicleController> {
  const AddVehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final VehicleArgument? args = Get.arguments as VehicleArgument?;

    final bool isWide = MediaQuery.of(context).size.width >= 768;

    return isWide
        ? _WebAddVehicleModal(controller: controller, args: args)
        : _MobileAddVehicleScreen(controller: controller, args: args);
  }
}

class _MobileAddVehicleScreen extends StatelessWidget {
  const _MobileAddVehicleScreen({required this.controller, this.args});

  final VehicleController controller;
  final VehicleArgument? args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(args != null ? 'Update Vehicle' : 'New Vehicle'),
      ),
      bottomNavigationBar: _buildBottomBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPaddings.mA,
          child: VehicleFormFields(controller: controller),
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
                  ? controller.updateTheVehicle(args!.vehicle.id!)
                  : controller.addNewVehicle();
            },
            enabled: controller.customerFormIsValid.value && !controller.isLoading.value,
            loading: controller.isLoading.value,
          ),
        ),
      ),
    );
  }
}

class _WebAddVehicleModal extends StatelessWidget {
  const _WebAddVehicleModal({required this.controller, this.args});

  final VehicleController controller;
  final VehicleArgument? args;

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
                  title: args != null ? 'Update Vehicle' : 'New Vehicle',
                  onClose: () => Get.back(),
                ),
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
                    child: VehicleFormFields(controller: controller),
                  ),
                ),
                Obx(
                  () => ModalFooter(
                    onSave: controller.customerFormIsValid.value && !controller.isLoading.value
                        ? () {
                            if (args != null) {
                              controller.updateTheVehicle(args!.vehicle.id!);
                            } else {
                              controller.addNewVehicle();
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
