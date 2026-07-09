import 'package:automanager/core/core.dart';
import 'package:automanager/feature/auto_manager/data/data.dart';
import 'package:automanager/feature/auto_manager/presentation/work_pay/arguments/work_pay_arguments.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/usecase/work_pay/work_pay.dart';

class WorkAndPayController extends GetxController {
  WorkAndPayController({
    required this.initiateWorkAndPayAgreement,
    required this.recordWorkAndPayPayment,
    required this.fetchWorkAndPayAgreement,
    required this.fetchWorkAndPayPayments,
  });

  final InitiateWorkAndPayAgreement initiateWorkAndPayAgreement;
  final RecordWorkAndPayPayment recordWorkAndPayPayment;
  final FetchWorkAndPayAgreement fetchWorkAndPayAgreement;
  final FetchWorkAndPayPayments fetchWorkAndPayPayments;

  // Reactive variables
  RxBool isLoading = false.obs;
  RxBool isLoadingPayments = false.obs;
  Rx<WorkAndPayAgreement?> currentAgreement = Rx<WorkAndPayAgreement?>(null);
  RxList<WorkAndPayPayment> paymentHistory = <WorkAndPayPayment>[].obs;
  Rxn<Failure> error = Rxn<Failure>();
  Rxn<Failure> paymentsError = Rxn<Failure>();

  // Form controllers
  late Rx<TextEditingController> driverIdController =
      TextEditingController().obs;
  late Rx<TextEditingController> vehicleIdController =
      TextEditingController().obs;
  late Rx<TextEditingController> originalPriceController =
      TextEditingController().obs;
  late Rx<TextEditingController> multiplierController =
      TextEditingController().obs;
  late Rx<TextEditingController> durationController =
      TextEditingController().obs;
  late Rx<TextEditingController> frequencyController =
      TextEditingController().obs;

  // Payment form controllers
  late Rx<TextEditingController> agreementIdController =
      TextEditingController().obs;
  late Rx<TextEditingController> paymentAmountController =
      TextEditingController().obs;
  late Rx<TextEditingController> paymentMethodController =
      TextEditingController().obs;


  @override
  void onReady() {
    final args = Get.arguments as WorkAndPayArguments;
    if(args.agreementId != null) loadAgreementDetails(args.agreementId!);
    super.onReady();
  }

  @override
  void onClose() {
    driverIdController.value.dispose();
    vehicleIdController.value.dispose();
    originalPriceController.value.dispose();
    multiplierController.value.dispose();
    durationController.value.dispose();
    frequencyController.value.dispose();
    agreementIdController.value.dispose();
    paymentAmountController.value.dispose();
    paymentMethodController.value.dispose();
    super.onClose();
  }

  /// Initiate a new Work & Pay agreement
  Future<void> initiateAgreement() async {
    if (!_validateAgreementForm()) return;

    isLoading(true);
    error(null);

    final request = InitiateWorkAndPayRequest(
      driverId: driverIdController.value.text,
      vehicleId: vehicleIdController.value.text,
      originalPrice:
          double.tryParse(originalPriceController.value.text) ?? 0.0,
      multiplier: double.tryParse(multiplierController.value.text) ?? 1.0,
      finalPrice: _calculateFinalPrice(),
      durationYears: int.tryParse(durationController.value.text) ?? 1,
      frequency: frequencyController.value.text,
    );

    final Either<Failure, WorkAndPayAgreement> result =
        await initiateWorkAndPayAgreement(request);

    result.fold(
      (Failure failure) {
        isLoading(false);
        error(failure);
        AppSnack.show(
          message: failure.message,
          status: SnackStatus.error,
        );
      },
      (WorkAndPayAgreement agreement) {
        isLoading(false);
        currentAgreement(agreement);
        _clearAgreementForm();
        AppSnack.show(
          message: 'Work & Pay agreement created successfully',
          status: SnackStatus.success,
        );
        Get.back<dynamic>(result: agreement);
      },
    );
  }

  /// Record a payment for an agreement
  Future<bool> recordPayment() async {
    if (!_validatePaymentForm()) {
      return false;
    }

    isLoadingPayments(true);
    paymentsError(null);

    final RecordWorkAndPayPaymentRequest request = RecordWorkAndPayPaymentRequest(
      agreementId: agreementIdController.value.text,
      amount: double.tryParse(paymentAmountController.value.text) ?? 0.0,
      method: paymentMethodController.value.text,
    );

    final Either<Failure, WorkAndPayPayment> result =
        await recordWorkAndPayPayment(request);

    return result.fold(
      (Failure failure) {
        isLoadingPayments(false);
        paymentsError(failure);
        AppSnack.show(
          message: failure.message,
          status: SnackStatus.error,
        );
        return false;
      },
      (WorkAndPayPayment payment) {
        isLoadingPayments(false);
        loadPaymentHistory(payment.workAndPayAgreementId);
        _clearPaymentForm();
        AppSnack.show(
          message: 'Payment recorded successfully',
          status: SnackStatus.success,
        );
        return true;
      },
    );
  }

  /// Fetch work & pay agreement details
  Future<void> loadAgreementDetails(String agreementId) async {
    isLoading(true);
    error(null);

    final Either<Failure, WorkAndPayAgreement> result =
        await fetchWorkAndPayAgreement(agreementId);

    result.fold(
      (Failure failure) {
        isLoading(false);
        error(failure);
        AppSnack.show(
          message: failure.message,
          status: SnackStatus.error,
        );
      },
      (WorkAndPayAgreement agreement) {
        currentAgreement(agreement);
        agreementIdController.value.text = agreement.id;
        loadPaymentHistory(agreement.id);
      },
    );
  }

  /// Fetch payment history for an agreement
  Future<void> loadPaymentHistory(String agreementId) async {
    final Either<Failure, List<WorkAndPayPayment>> result =
        await fetchWorkAndPayPayments(agreementId);

    result.fold(
      (Failure failure) {
        isLoading(false);
        AppSnack.show(
          message: failure.message,
          status: SnackStatus.error,
        );
      },
      (List<WorkAndPayPayment> payments) {
        isLoading(false);
        paymentHistory(payments);
      },
    );
  }

  // Helper methods
  bool _validateAgreementForm() {
    if (driverIdController.value.text.isEmpty ||
        vehicleIdController.value.text.isEmpty ||
        originalPriceController.value.text.isEmpty ||
        durationController.value.text.isEmpty ||
        frequencyController.value.text.isEmpty) {
      AppSnack.show(
        message: 'Please fill all required fields',
        status: SnackStatus.error,
      );
      return false;
    }
    return true;
  }

  bool _validatePaymentForm() {
    if (agreementIdController.value.text.isEmpty ||
        paymentAmountController.value.text.isEmpty ||
        paymentMethodController.value.text.isEmpty) {
      AppSnack.show(
        message: 'Please fill all required fields',
        status: SnackStatus.error,
      );
      return false;
    }
    return true;
  }

  double _calculateFinalPrice() {
    final double originalPrice =
        double.tryParse(originalPriceController.value.text) ?? 0.0;
    final double multiplier =
        double.tryParse(multiplierController.value.text) ?? 1.0;
    return originalPrice * multiplier;
  }

  void _clearAgreementForm() {
    driverIdController.value.clear();
    vehicleIdController.value.clear();
    originalPriceController.value.clear();
    multiplierController.value.clear();
    durationController.value.clear();
    frequencyController.value.clear();
  }

  void _clearPaymentForm() {
    paymentAmountController.value.clear();
    paymentMethodController.value.clear();
  }

  void onDriverIdChanged(String value) {
    // Handle driver ID changes if needed
  }

  void onVehicleIdChanged(String value) {
    // Handle vehicle ID changes if needed
  }

  void onOriginalPriceChanged(String value) {
    // Recalculate final price if needed
  }

  void onMultiplierChanged(String value) {
    // Recalculate final price if needed
  }

  void onDurationChanged(String value) {
    // Handle duration changes if needed
  }

  void onFrequencyChanged(String value) {
    // Handle frequency changes if needed
  }

  void onPaymentAmountChanged(String value) {
    // Handle payment amount changes if needed
  }

  void onPaymentMethodChanged(String value) {
    // Handle payment method changes if needed
  }
}

