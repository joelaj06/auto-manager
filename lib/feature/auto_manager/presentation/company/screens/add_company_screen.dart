import 'package:automanager/core/core.dart';
import 'package:automanager/feature/auto_manager/presentation/company/company.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCompanyScreen extends GetView<CompanyController> {
  const AddCompanyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.loadUserData();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Business Setup',
        ),
      ),
      bottomNavigationBar: Obx(
        () => Visibility(
          visible: controller.pageIndex.value < 3,
          child: _buildBottomNavigationBar(),
        ),
      ),
      body: Column(
        children: <Widget>[
          const AppSpacing(v: 10),
          Obx(() => Text('Step ${(controller.pageIndex.value + 1)}/4')),
          SizedBox(
            height: 10,
            width: context.width,
            child: Padding(
              padding: AppPaddings.mH,
              child: Obx(
                () => TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 300),
                  tween: Tween<double>(
                    begin: 0.0,
                    end: (controller.pageIndex.value + 1) / 4,
                  ),
                  builder: (BuildContext context, double value, Widget? child) {
                    return LinearProgressIndicator(
                      semanticsLabel: 'stepper',
                      value: value,
                      minHeight: 20,
                      borderRadius: BorderRadius.circular(20),
                    );
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: AppPaddings.mA.add(AppPaddings.mT),
              child: PageView(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  _buildBasicInfoPage(context),
                  _buildContactPage(context),
                  _buildBusinessRegistrationPage(context),
                  _buildSuccessPage(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessPage(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(
          AssetImages.success,
        ),
        const AppSpacing(v: 10),
        Text(
          '🎉 Congratulations!',
          style: context.textTheme.headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const AppSpacing(v: 10),
        Text(
          'Your business setup is complete. You\'re all set to get started.'
              '\n Explore the features and manage your business with ease.',
          style: context.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const AppSpacing(v: 20),
        AppButton(
          onPressed: controller.navigateToLoginScreen,
          text: 'Continue',
          // fontSize: 18,
        ),
      ],
    );
  }

  Widget _buildBusinessRegistrationPage(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Registration Info (Optional)',
          style: context.textTheme.headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const AppSpacing(v: 10),
        AppTextInputField(
          labelText: 'Business Registration Number',
          onChanged: controller.onRegistrationNumberInputChanged,
          validator: controller.validateField,
          initialValue: controller.registrationNumber.value,
        ),
        const AppSpacing(
          v: 10,
        ),
        AppTextInputField(
          labelText: 'Tax Identification Number',
          onChanged: controller.onTaxIdentificationNumberInputChanged,
          validator: controller.validateField,
          initialValue: controller.taxIdentificationNumber.value,
        )
      ],
    );
  }

  Widget _buildContactPage(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Text(
            'Contact Information',
            style: context.textTheme.headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const AppSpacing(v: 10),
          AppTextInputField(
            labelText: 'Company Email',
            onChanged: controller.onEmailInputChanged,
            validator: controller.validateEmail,
            textInputType: TextInputType.emailAddress,
            initialValue: controller.email.value,
          ),
          const AppSpacing(
            v: 10,
          ),
          AppTextInputField(
            labelText: 'Company Phone Number',
            onChanged: controller.onPhoneInputChanged,
            validator: controller.validateField,
            textInputType: TextInputType.phone,
            initialValue: controller.phone.value,
          ),
          const AppSpacing(
            v: 10,
          ),
          AppTextInputField(
            labelText: 'Country',
            onChanged: controller.onCountryInputChanged,
            validator: controller.validateField,
            initialValue: controller.country.value,
          ),
          const AppSpacing(
            v: 10,
          ),
          AppTextInputField(
            labelText: 'Company Street Address',
            onChanged: controller.onStreetInputChanged,
            validator: controller.validateField,
            textInputType: TextInputType.streetAddress,
            initialValue: controller.street.value,
          ),
          const AppSpacing(
            v: 10,
          ),
          AppTextInputField(
            labelText: 'City',
            onChanged: controller.onCityInputChanged,
            validator: controller.validateField,
            initialValue: controller.city.value,
          ),
          const AppSpacing(
            v: 10,
          ),
          AppTextInputField(
            labelText: 'Postal Code',
            onChanged: controller.onPostalCodeInputChanged,
            validator: controller.validateField,
            initialValue: controller.postalCode.value,
            textInputType: TextInputType.number,
          ),
          const AppSpacing(
            v: 10,
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfoPage(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Text(
            'Basic Information',
            style: context.textTheme.headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const AppSpacing(v: 10),
          AppTextInputField(
            labelText: 'Company Name',
            initialValue: controller.companyName.value,
            onChanged: controller.onCompanyNameInputChanged,
            validator: controller.validateField,
          ),
          const AppSpacing(
            v: 10,
          ),
          AppSelectField<String>(
            labelText: 'Company Type',
            onChanged: (String title) {
              controller.onCompanyTypeInputChanged(title);
            },
            value: controller.companyType.value,
            options: controller.companyTypes,
            titleBuilder: (_, String title) =>
                StringUtils.capitalizeFirst(title),
            validator: controller.validateField,
          ),
          const AppSpacing(
            v: 10,
          ),
          AppSelectField<String>(
            labelText: 'Industry',
            onChanged: (String title) {
              controller.onIndustryInputChanged(title);
            },
            value: controller.industry.value,
            options: controller.industries,
            titleBuilder: (_, String title) =>
                StringUtils.capitalizeFirst(title),
            validator: controller.validateField,
          ),
          const AppSpacing(
            v: 10,
          ),
          AppTextInputField(
            labelText: 'Company Motto',
            initialValue: controller.motto.value,
            onChanged: controller.onMottoInputChanged,
            validator: controller.validateField,
          ),
          const AppSpacing(
            v: 10,
          ),
          AppTextInputField(
            labelText: 'Description',
            initialValue: controller.description.value,
            onChanged: controller.onDescriptionInputChanged,
            validator: controller.validateField,
            maxLines: 5,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return SizedBox(
      height: 70,
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Visibility(
              visible: controller.pageIndex.value != 0 &&
                  controller.pageIndex.value != 3,
              child: IconButton(
                onPressed: controller.navigateToPreviousPage,
                icon: const Icon(Icons.arrow_back),
              ),
            ),
            Expanded(
              child: Padding(
                padding: AppPaddings.mH,
                child: AppButton(
                  enabled: controller.isLoading.value ||
                          controller.pageIndex.value == 0
                      ? controller.companyBasicFormIsValid
                      : controller.pageIndex.value == 1
                          ? controller.companyAddressFormIsValid
                          : controller.pageIndex.value == 2
                              ? true
                              : false,
                  onPressed: controller.saveCompany,
                  text: controller.pageIndex.value == 2 ? 'Continue' : 'Next',
                  // fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
