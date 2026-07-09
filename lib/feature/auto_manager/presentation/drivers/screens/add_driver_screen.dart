import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/presentation.dart';
import '../../../../../core/presentation/theme/app_theme.dart';
import '../arguments/driver_argument.dart';
import '../getx/driver_controller.dart';
import '../widgets/driver_form_fields.dart';

class AddDriverScreen extends GetView<DriverController> {
  const AddDriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DriverArgument? args = Get.arguments as DriverArgument?;

    final bool isWide = MediaQuery.of(context).size.width >= 768;

    return isWide
        ? _WebAddDriverModal(controller: controller, args: args)
        : _MobileAddDriverScreen(controller: controller, args: args);
  }
}

class _MobileAddDriverScreen extends StatelessWidget {
  const _MobileAddDriverScreen({required this.controller, this.args});

  final DriverController controller;
  final DriverArgument? args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(args != null ? 'Update Driver' : 'New Driver'),
      ),
      bottomNavigationBar: _buildBottomBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPaddings.mA,
          child: DriverFormFields(controller: controller),
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
            text: controller.isLoading.value ? 'Loading...' : args != null ? 'Update' : 'Save',
            onPressed: () {
              args != null
                  ? controller.updateTheDriver(args!.driver.id!)
                  : controller.addADriver();
            },
            enabled: controller.driverFormIsValid.value && !controller.isLoading.value,
            loading: controller.isLoading.value,
          ),
        ),
      ),
    );
  }
}

class _WebAddDriverModal extends StatelessWidget {
  const _WebAddDriverModal({required this.controller, this.args});

  final DriverController controller;
  final DriverArgument? args;

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
                  title: args != null ? 'Update Driver' : 'New Driver',
                  onClose: () => Get.back(),
                ),
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
                    child: DriverFormFields(controller: controller),
                  ),
                ),
                Obx(
                  () => ModalFooter(
                    onSave: controller.driverFormIsValid.value && !controller.isLoading.value
                        ? () {
                            if (args != null) {
                              controller.updateTheDriver(args!.driver.id!);
                            } else {
                              controller.addADriver();
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
