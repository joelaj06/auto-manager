import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        child: Column(
          children: <Widget>[
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
