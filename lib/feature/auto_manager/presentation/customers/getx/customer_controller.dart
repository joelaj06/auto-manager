
import 'package:automanager/core/presentation/routes/app_routes.dart';
import 'package:automanager/core/usecase/usecase.dart';
import 'package:automanager/feature/auto_manager/data/model/model.dart';
import 'package:automanager/feature/auto_manager/presentation/customers/arguments/customer_argument.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';


import '../../../../../core/errors/failure.dart';
import '../../../../../core/presentation/utils/utils.dart';
import '../../../../../core/utils/utils.dart';
import '../../../domain/usecase/customer/customer.dart';

class CustomerController extends GetxController {
  CustomerController({
    required this.fetchCustomers,
    required this.addCustomer,
    required this.updateCustomer,
    required this.deleteCustomer,
  });

  final FetchCustomers fetchCustomers;
  final AddCustomer addCustomer;
  final UpdateCustomer updateCustomer;
  final DeleteCustomer deleteCustomer;

  RxInt totalCount = 0.obs;
  RxString query = ''.obs;
  RxBool isLoading = false.obs;
  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString phone = ''.obs;
  RxString address = ''.obs;
  RxString idNumber = ''.obs;
  RxString occupation = ''.obs;
  RxString business = ''.obs;
  Rx<DateTime> selectedDateOfBirth = DateTime.now().obs;
  Rx<TextEditingController> dobTextEditingController =
      TextEditingController().obs;

  //paging controller
  final PagingController<int, Customer> pagingController =
      PagingController<int, Customer>(firstPageKey: 1);

  @override
  void onInit() {
    pagingController.addPageRequestListener((int pageKey) {
      getCustomers(pageKey);
    });
    super.onInit();
  }

  void deleteTheCustomer(String customerId) async {
    isLoading(true);
    final Either<Failure, Customer> failureOrCustomer =
        await deleteCustomer(customerId);
    isLoading(false);
    failureOrCustomer.fold((Failure failure) {
      AppSnack.show(message: failure.message, status: SnackStatus.error);
    }, (Customer customer) {
      isLoading(false);
      pagingController.refresh();
    });
  }
  void updateTheCustomer(String customerId) async {
    final CustomerRequest customerRequest = CustomerRequest(
      id: customerId,
      name: name.value.isNotEmpty ? name.value : null,
      email: email.value.isNotEmpty ? email.value : null,
      phone: phone.value.isNotEmpty ? phone.value : null,
      address: address.value.isNotEmpty ? address.value : null,
      identificationNumber: idNumber.value.isNotEmpty ? idNumber.value : null,
      occupation: occupation.value.isNotEmpty ? occupation.value : null,
      business: business.value.isNotEmpty ? business.value : null,
      dateOfBirth: selectedDateOfBirth.value.toIso8601String(),
    );
    isLoading(true);
    final Either<Failure, Customer> failureOrCustomer =
        await updateCustomer(customerRequest);
    isLoading(false);
    failureOrCustomer.fold((Failure failure) {
      AppSnack.show(message: failure.message, status: SnackStatus.error);
    }, (Customer customer) {
      isLoading(false);
      pagingController.refresh();
      Get.back<dynamic>(result: customer);
    });
  }

  void addNewCustomer() async {
    final CustomerRequest customerRequest = CustomerRequest(
      name: name.value,
      email: email.value,
      phone: phone.value,
      address: address.value,
      identificationNumber: idNumber.value,
      occupation: occupation.value,
      business: business.value,
      dateOfBirth: selectedDateOfBirth.value.toIso8601String(),
    );
    isLoading(true);
    final Either<Failure, Customer> failureOrCustomer =
        await addCustomer(customerRequest);
    isLoading(false);
    failureOrCustomer.fold((Failure failure) {
      AppSnack.show(message: failure.message, status: SnackStatus.error);
    }, (Customer customer) {
      isLoading(false);
      pagingController.refresh();
      Get.back<dynamic>(result: customer);
    });
  }

  void navigateToUpdateCustomerScreen(Customer customer) async {
    final dynamic result = await Get.toNamed(
      AppRoutes.addCustomer,
      arguments: CustomerArgument(customer),
    );
    if (result != null) {
      AppSnack.show(
        message: 'Customer updated successfully',
        status: SnackStatus.success,
      );
    }
  }

  void navigateToAddCustomerScreen() async {
    final dynamic result = await Get.toNamed(AppRoutes.addCustomer);
    if (result != null) {
      AppSnack.show(
        message: 'Customer added successfully',
        status: SnackStatus.success,
      );
    }
  }

  void getCustomers(int pageKey) async {
    isLoading(true);
    final Either<Failure, ListPage<Customer>> failureOrCustomers =
        await fetchCustomers(PageParams(
      pageIndex: pageKey,
      pageSize: 10,
      query: query.value,
    ));

    failureOrCustomers.fold((Failure failure) {
      isLoading(false);
      pagingController.error = failure;
    }, (ListPage<Customer> newPage) {
      isLoading(false);

      //get meta data
      final Map<String, dynamic>? meta = newPage.metaData;
      if (meta != null) {
        totalCount(meta['totalCount']);
      }
      //check if the new page is the last page
      final int previouslyFetchedItemsCount =
          pagingController.itemList?.length ?? 0;

      final bool isLastPage = newPage.isLastPage(previouslyFetchedItemsCount);
      final List<Customer> newItems = newPage.itemList;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final int nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
    });
  }

  void clearFields() {
    name('');
    email('');
    phone('');
    address('');
    idNumber('');
    occupation('');
    business('');
    dobTextEditingController.value.text = '';
  }

  void getCustomerDataFromArgs(Customer customer) {
    dobTextEditingController.value.text =
        DataFormatter.formatDateToString(customer.dateOfBirth!);
  }

  void selectDateOfBirth(BuildContext context) async {
    final DateTime? res = await AppDatePicker.showOnlyDatePicker(context);
    if (res != null) {
      selectedDateOfBirth(res);
      dobTextEditingController.value.text =
          DataFormatter.formatDateToString(res.toIso8601String());
    }
  }

  void onNameInputChanged(String value) {
    name(value);
  }

  void onEmailInputChanged(String value) {
    email(value);
  }

  void onPhoneInputChanged(String value) {
    phone(value);
  }

  void onAddressInputChanged(String value) {
    address(value);
  }

  void onIdNumberInputChanged(String value) {
    idNumber(value);
  }

  void onOccupationInputChanged(String value) {
    occupation(value);
  }

  void onBusinessInputChanged(String value) {
    business(value);
  }

  void onSearchFieldInputChanged(String value) {
    query(value);
  }

  void onSearchQuerySubmitted() {
    pagingController.refresh();
  }

  String? validateField(String? value) {
    String? errorMessage;
    if (value!.isEmpty) {
      errorMessage = 'Field is required';
    }
    return errorMessage;
  }

  RxBool get customerFormIsValid => (validateField(name.value) == null &&
          validateField(phone.value) == null
  ).obs;
}
