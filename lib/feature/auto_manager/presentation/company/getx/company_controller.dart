import 'package:automanager/core/presentation/utils/utils.dart';
import 'package:automanager/feature/authentication/domain/domain.dart';
import 'package:automanager/feature/auto_manager/data/data.dart';
import 'package:automanager/feature/auto_manager/domain/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/presentation/routes/app_routes.dart';
import '../../../../authentication/data/models/models.dart';

class CompanyController extends GetxController {
  CompanyController(
      {required this.addCompany, required this.loadUserSignupData});

  final AddCompany addCompany;
  final LoadUserSignupData loadUserSignupData;

  //reactive variables
  final RxInt pageIndex = 0.obs;
  final RxString companyName = ''.obs;
  final RxString companyType = ''.obs;
  final RxString industry = ''.obs;
  RxString description = ''.obs;
  RxString website = ''.obs;
  final RxBool isLoading = false.obs;
  final RxString logo = ''.obs;
  final RxString street = ''.obs;
  final RxString city = ''.obs;
  final RxString state = ''.obs;
  final RxString postalCode = ''.obs;
  final RxString country = ''.obs;
  final RxString phone = ''.obs;
  final RxString email = ''.obs;
  final RxString registrationNumber = ''.obs;
  final RxString taxIdentificationNumber = ''.obs;
  final RxString motto = ''.obs;
  final Rx<UserRegistration> registrationResponse =
      UserRegistration.empty().obs;

  final List<String> industries = <String>[
    'Automotive',
    'Technology',
    'Finance',
    'Healthcare',
    'Retail',
    'Education',
    'Manufacturing',
    'Construction',
    'Real Estate',
  ];

  final List<String> companyTypes = <String>[
    'LLC',
    'Corporation',
    'Sole Proprietorship',
    'Partnership',
    'Nonprofit',
    'Cooperative',
  ];

  PageController pageController = PageController(initialPage: 0);

  @override
  void onInit() {
    companyType(companyTypes.first);
    industry(industries.first);
    loadUserData();
    super.onInit();
  }

  void addNewCompany() async {
    isLoading(true);
    final Address address = Address(
      state: state.value.trim(),
      city: city.value.trim(),
      street: street.value.trim(),
      postalCode: postalCode.value.trim(),
      country: country.value.trim(),
    );

    final Company companyRequest = Company(
        name: companyName.value.trim(),
        companyType: companyType.value.trim(),
        industry: industry.value.trim(),
        description: description.value.trim(),
        website: website.value.trim(),
        logoUrl: logo.value,
        address: address,
        phone: phone.value.trim(),
        email: email.value.trim(),
        registrationNumber: registrationNumber.value.trim(),
        taxIdentificationNumber: taxIdentificationNumber.value.trim(),
        motto: motto.value.trim(),
        id: null,
        ownerId: registrationResponse.value.data?.userId ?? '',
        createdBy: registrationResponse.value.data?.userId ?? '',
        isActive: true,
        isVerified: false,
        subscriptionPlan: 'basic');

    final Either<Failure, Company> failureOrCompany =
        await addCompany(companyRequest);
    failureOrCompany.fold(
      (Failure failure) {
        isLoading(false);
        AppSnack.show(message: failure.message, status: SnackStatus.error);
      },
      (Company company) {
        isLoading(false);
        AppSnack.show(
            message: 'Company Successfully Created',
            status: SnackStatus.success);
        navigatePages(3);
      },
    );
  }

  void loadUserData() async {
    // ignore: unawaited_futures
    isLoading(true);
    final Either<Failure, UserRegistration> failureOrUser =
        await loadUserSignupData(null);
    failureOrUser.fold(
      (Failure failure) {
        isLoading(false);
      },
      (UserRegistration userRes) {
        isLoading(false);
        registrationResponse(userRes);
      },
    );
  }

  void navigateToLoginScreen() {
    Get.offAllNamed(AppRoutes.login);
  }


  void saveCompany() {
    if (pageIndex.value < 2) {
      pageIndex.value += 1;
      navigatePages(pageIndex.value);
    } else {
      addNewCompany();
    }
  }

  void onCompanyNameInputChanged(String? value) {
    companyName(value);
  }

  void onCompanyTypeInputChanged(String? value) {
    companyType(value);
  }

  void onIndustryInputChanged(String? value) {
    industry(value);
  }

  void onDescriptionInputChanged(String? value) {
    description(value);
  }

  void onWebsiteInputChanged(String? value) {
    website(value);
  }

  void onLogoInputChanged(String? value) {
    logo(value);
  }

  void onStreetInputChanged(String? value) {
    street(value);
  }

  void onCityInputChanged(String? value) {
    city(value);
  }

  void onStateInputChanged(String? value) {
    state(value);
  }

  void onPostalCodeInputChanged(String? value) {
    postalCode(value);
  }

  void onCountryInputChanged(String? value) {
    country(value);
  }

  void onPhoneInputChanged(String? value) {
    phone(value);
  }

  void onEmailInputChanged(String? value) {
    email(value);
  }

  void onRegistrationNumberInputChanged(String? value) {
    registrationNumber(value);
  }

  void onTaxIdentificationNumberInputChanged(String? value) {
    taxIdentificationNumber(value);
  }

  void onMottoInputChanged(String? value) {
    motto(value);
  }

  String? validateEmail(String? email) {
    String? errorMessage;
    // Check if email is empty
    if (email == null || email.isEmpty) {
      errorMessage = 'Please enter an email address';
    }

    // Regular expression for validating an email address
    final RegExp emailPattern = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    // Check if email is valid using regex
    if (!emailPattern.hasMatch(email!)) {
      errorMessage = 'Please enter a valid email address';
    }

    return errorMessage;
  }

  String? validateField(String? value) {
    String? errorMessage;
    if (value!.isEmpty) {
      errorMessage = 'Field is required';
    }
    return errorMessage;
  }

  void navigateToPreviousPage() {
    if (pageIndex.value != 0) {
      pageIndex.value -= 1;
      navigatePages(pageIndex.value);
    }
  }

  void onPageChanged(int index) {
    pageIndex(index);
  }

  void navigatePages(int value) {
    pageController.animateToPage(value,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  bool get companyBasicFormIsValid =>
      validateField(companyName.value) == null &&
      validateField(companyType.value) == null &&
      validateField(industry.value) == null &&
      validateField(description.value) == null &&
      validateField(motto.value) == null;

  bool get companyAddressFormIsValid =>
      validateField(street.value) == null &&
      validateField(city.value) == null &&
      validateField(postalCode.value) == null &&
      validateField(country.value) == null &&
      validateField(phone.value) == null &&
      validateEmail(email.value) == null;

  bool get companyRegistrationFormIsValid =>
      validateField(registrationNumber.value) == null &&
      validateField(taxIdentificationNumber.value) == null;
}
