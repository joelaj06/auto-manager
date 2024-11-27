import 'package:automanager/core/core.dart';
import 'package:automanager/core/presentation/theme/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import '../../../../../core/presentation/utils/app_padding.dart';
import '../../../../../core/presentation/widgets/widgets.dart';
import '../getx/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      bottomNavigationBar: _buildBottomBar(context),
      body: Padding(
        padding: AppPaddings.mA,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildUserProfile(context),
              AppTextInputField(
                  labelText: 'First Name',
                  onChanged: controller.onFirstNameInputChanged,
                  controller: controller.firstNameTextEditingController
                  //  initialValue: controller.user.value.firstName,
                  ),
              AppTextInputField(
                labelText: 'Last Name',
                onChanged: controller.onLastNameInputChanged,
                controller: controller.lastNameTextEditingController,
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserProfile(BuildContext context) {
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
            child: Obx(() => Container(
              height: 180,
              width: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
              ),
                child: controller.imgUrl.value.isEmpty
                    ? Image.asset(
                        AssetImages.speedometer,
                        fit: BoxFit.cover,
                      )
                    : controller.imgUrl.value.contains('http')
                        ? CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: controller.imgUrl.value,
                            placeholder: (BuildContext context, String url) =>
                                Image.asset(AssetImages.speedometer),
                            errorWidget: (BuildContext context, String url,
                                    dynamic error) =>
                                const Icon(Icons.error),
                          )
                        : Image.memory(
                            fit: BoxFit.cover,
                            Base64Convertor().base64toImage(
                              controller.imgUrl.value,
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
        _buildModalListCard(
          onTap: () {
            controller.addImage();
            Navigator.pop(context);
          },
          title: 'Upload Image',
          icon: IconlyBold.paper_upload,
        ),
        _buildModalListCard(
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

  Widget _buildModalListCard(
      {required VoidCallback onTap,
      required String title,
      required IconData icon}) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Icon(icon),
              ],
            ),
            const AppSpacing(
              v: 8,
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Obx(
        () => AppButton(
          enabled: !controller.isLoading.value &&
              !controller.isLoadingUserData.value,
          text: controller.isLoading.value
              ? 'Updating...'
              : controller.isLoadingUserData.value
                  ? 'Loading Data...'
                  : 'Update',
          onPressed: () {
            controller.updateProfile();
          },
        ),
      ),
    );
  }
}
