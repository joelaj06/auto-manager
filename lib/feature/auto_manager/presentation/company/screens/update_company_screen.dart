import 'package:automanager/core/presentation/theme/app_theme.dart';
import 'package:automanager/feature/auto_manager/presentation/company/company.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../../../../core/presentation/utils/utils.dart';
import '../../../../../core/presentation/widgets/widgets.dart';
import '../../../../../core/utils/utils.dart';
import '../../profile/widgets/image_modal_list_card.dart';

class UpdateCompanyScreen extends GetView<CompanyController> {
  const UpdateCompanyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Business'),
      ),
      bottomNavigationBar: _buildBottomBar(context),
      body: Padding(
        padding: AppPaddings.mA,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildCompanyLogo(context),
              AppTextInputField(
                  labelText: 'Company Name',
                  onChanged: controller.onCompanyNameInputChanged,
                  controller: controller.companyNameTextEditingController
                  //  initialValue: controller.user.value.firstName,
                  ),
              AppTextInputField(
                labelText: 'Email',
                onChanged: controller.onEmailInputChanged,
                controller: controller.emailTextEditingController,
              ),
              AppTextInputField(
                labelText: 'Phone',
                onChanged: controller.onPhoneInputChanged,
                controller: controller.phoneTextEditingController,
                textInputType: TextInputType.phone,
              ),
              AppTextInputField(
                labelText: 'Motto',
                onChanged: controller.onMottoInputChanged,
                controller: controller.companyMottoTextEditingController,
                textInputType: TextInputType.text,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompanyLogo(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: context.colorScheme.primary,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Obx(
              () => Container(
                height: 180,
                width: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: controller.logo.value.isEmpty
                    ? Image.asset(
                        AssetImages.speedometer,
                        fit: BoxFit.cover,
                      )
                    : controller.logo.value.contains('http')
                        ? CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: controller.logo.value,
                            placeholder: (BuildContext context, String url) =>
                                Image.asset(AssetImages.speedometer),
                            errorWidget: (BuildContext context, String url,
                                    dynamic error) =>
                                const Icon(Icons.error),
                          )
                        : Image.memory(
                            fit: BoxFit.cover,
                            Base64Convertor().base64toImage(
                              controller.logo.value,
                            ),
                          ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 5,
          right: 5,
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

  Widget _buildBottomBar(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Obx(
        () => AppButton(
          enabled: !controller.isLoading.value &&
              !controller.isLoadingCompanyData.value,
          text: controller.isLoading.value
              ? 'Updating...'
              : controller.isLoadingCompanyData.value
                  ? 'Loading Data...'
                  : 'Update',
          onPressed: () {
            controller.updateTheCompany();
          },
        ),
      ),
    );
  }
}
