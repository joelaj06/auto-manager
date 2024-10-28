import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CompanyController extends GetxController {



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
    super.onInit();
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

  void saveCompany() {
    if (pageIndex.value != 2) {
      pageIndex.value += 1;
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
