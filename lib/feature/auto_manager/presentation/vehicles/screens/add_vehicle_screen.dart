import 'package:automanager/core/presentation/theme/app_theme.dart';
import 'package:automanager/feature/auto_manager/presentation/presentation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../../../../core/presentation/utils/utils.dart';
import '../../../../../core/presentation/widgets/widgets.dart';
import '../../../../../core/utils/utils.dart';

class AddVehicleScreen extends GetView<VehicleController> {
  const AddVehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final VehicleArgument? args = Get.arguments;
    controller.clearFields();

    if (args != null) {
      controller.getVehicleDataFromArgs(args.vehicle);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          args != null ? 'Edit Vehicle' : 'New Vehicle',
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context, arg: args),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPaddings.mA,
          child: Column(
            children: <Widget>[
              _buildVehicleImage(context),
              const AppSpacing(v: 10),
              AppTextInputField(
                labelText: 'Make',
                onChanged: controller.onMakeInputChanged,
                validator: controller.validateField,
                initialValue: args != null ? args.vehicle.make : '',
              ),
              const AppSpacing(v: 10),
              AppTextInputField(
                labelText: 'Model',
                onChanged: controller.onModelInputChanged,
                validator: controller.validateField,
                initialValue: args != null ? args.vehicle.model : '',
              ),
              const AppSpacing(v: 10),
              AppTextInputField(
                labelText: 'Year',
                onChanged: controller.onYearInputChanged,
                textInputType: TextInputType.number,
                validator: controller.validateField,
                initialValue: args != null ? args.vehicle.year.toString() : '',
              ),
              const AppSpacing(v: 10),
              AppTextInputField(
                labelText: 'Color',
                onChanged: controller.onColorInputChanged,
                validator: controller.validateField,
                initialValue: args != null ? args.vehicle.color : '',
              ),
              const AppSpacing(v: 10),
              AppTextInputField(
                labelText: 'Plate Number',
                onChanged: controller.onPlateNumberInputChanged,
                validator: controller.validateField,
                initialValue: args != null ? args.vehicle.licensePlate : '',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVehicleImage(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: context.colorScheme.primary,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Obx(
              () => Container(
                height: 180,
                width: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: controller.image.value.isEmpty
                    ? Image.asset(
                        AssetImages.speedometer,
                        fit: BoxFit.cover,
                      )
                    : controller.image.value.contains('http')
                        ? CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: controller.image.value,
                            placeholder: (BuildContext context, String url) =>
                                Image.asset(AssetImages.speedometer),
                            errorWidget: (BuildContext context, String url,
                                    dynamic error) =>
                                const Icon(Icons.error),
                          )
                        : Image.memory(
                            fit: BoxFit.cover,
                            Base64Convertor().base64toImage(
                              controller.image.value,
                            ),
                          ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 5,
          right: 4,
          child: CircleAvatar(
            backgroundColor: context.colorScheme.primary,
            child: IconButton(
              color: context.colorScheme.onPrimary,
              onPressed: () {
                showModalBottomSheet<dynamic>(
                  context: context,
                  builder: (BuildContext context) => SizedBox(
                    height: 150,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: AppPaddings.mA,
                        child: _buildImageOptions(context),
                      ),
                    ),
                  ),
                );
              },
              icon: const Icon(IconlyLight.camera),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageOptions(BuildContext context) {
    return Column(
      children: <Widget>[
        const Align(
          alignment: Alignment.center,
          child: Text(
            'Choose an option',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ),
        const AppSpacing(
          v: 10,
        ),
        ImageModalListCard(
          onTap: () {
            controller.addImage();
            Navigator.pop(context);
          },
          title: 'Upload Image',
          icon: IconlyBold.paper_upload,
        ),
        ImageModalListCard(
          onTap: () {
            controller.removeProfileImage();
            Navigator.pop(context);
          },
          title: 'Remove',
          icon: IconlyBold.delete,
        ),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context,
      {required VehicleArgument? arg}) {
    return Padding(
      padding: AppPaddings.mA,
      child: SizedBox(
        height: 70,
        child: Obx(
          () => AppButton(
            text: arg != null ? 'Update' : 'Save',
            onPressed: () {
              arg != null
                  ? controller.updateTheVehicle(arg.vehicle.id!)
                  : controller.addNewVehicle();
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
