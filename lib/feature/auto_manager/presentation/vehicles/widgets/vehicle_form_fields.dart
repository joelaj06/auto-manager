import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/presentation/presentation.dart';
import '../../../../../core/presentation/theme/app_theme.dart';
import '../getx/vehicle_controller.dart';

class VehicleFormFields extends StatelessWidget {
  const VehicleFormFields({required this.controller, super.key});

  final VehicleController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Obx(
          () => GestureDetector(
            onTap: controller.addImage,
            child: Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: context.colorScheme.outlineVariant),
                image: controller.image.value.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(controller.image.value),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: controller.image.value.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_a_photo_outlined,
                            color: context.colorScheme.onSurfaceVariant),
                        const SizedBox(height: 8),
                        Text('Add Vehicle Image',
                            style: TextStyle(
                                fontSize: 12,
                                color: context.colorScheme.onSurfaceVariant)),
                      ],
                    )
                  : Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: controller.removeProfileImage,
                        icon: const Icon(Icons.cancel, color: Colors.red),
                      ),
                    ),
            ),
          ),
        ),
        const AppSpacing(v: 16),
        Row(
          children: [
            Expanded(
              child: AppTextInputField(
                labelText: 'Make',
                onChanged: controller.onMakeInputChanged,
                initialValue: controller.make.value,
                validator: controller.validateField,
              ),
            ),
            const AppSpacing(h: 12),
            Expanded(
              child: AppTextInputField(
                labelText: 'Model',
                onChanged: controller.onModelInputChanged,
                initialValue: controller.model.value,
                validator: controller.validateField,
              ),
            ),
          ],
        ),
        const AppSpacing(v: 12),
        Row(
          children: [
            Expanded(
              child: AppTextInputField(
                labelText: 'Year',
                onChanged: controller.onYearInputChanged,
                initialValue: controller.year.value,
                validator: controller.validateField,
                textInputType: TextInputType.number,
              ),
            ),
            const AppSpacing(h: 12),
            Expanded(
              child: AppTextInputField(
                labelText: 'Color',
                onChanged: controller.onColorInputChanged,
                initialValue: controller.color.value,
                validator: controller.validateField,
              ),
            ),
          ],
        ),
        const AppSpacing(v: 12),
        AppTextInputField(
          labelText: 'License Plate',
          onChanged: controller.onPlateNumberInputChanged,
          initialValue: controller.plateNumber.value,
          validator: controller.validateField,
        ),
        const AppSpacing(v: 12),
        Obx(
          () => SwitchListTile(
            title: const Text('Available for Rent', style: TextStyle(fontSize: 14)),
            value: controller.isVehicleReleased.value,
            onChanged: controller.toggleVehicleRelease,
          ),
        ),
      ],
    );
  }
}
