import 'package:automanager/core/presentation/widgets/app_select_field.dart';
import 'package:automanager/core/presentation/widgets/app_text_input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/theme/app_theme.dart';
import '../../../../../core/presentation/utils/utils.dart';
import '../getx/work_and_pay_controller.dart';

class RecordPaymentSheet extends StatefulWidget {
  const RecordPaymentSheet({
    super.key,
    required this.agreementId,
    required this.suggestedAmount,
    required this.onSubmit,
    required this.controller,
  });
  final String agreementId;
  final double suggestedAmount;
  final  Function({
    required String agreementId,
    required double amount,
    required String method,
  }) onSubmit;
  final WorkAndPayController controller;

  static Future<bool?> show(
    BuildContext context, {
    required String agreementId,
    required double suggestedAmount,
    required WorkAndPayController controller,
    required  Function({
      required String agreementId,
      required double amount,
      required String method,
    }) onSubmit,
  }) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => RecordPaymentSheet(
        agreementId: agreementId,
        suggestedAmount: suggestedAmount,
        onSubmit: onSubmit,
        controller: controller,
      ),
    );
  }

  @override
  State<RecordPaymentSheet> createState() => _RecordPaymentSheetState();
}

class _RecordPaymentSheetState extends State<RecordPaymentSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;

  static const List<String> _methods = <String>[
    'cash',
    'momo',
    'bank transfer',
    'cheque'
  ];

  @override
  void initState() {
    super.initState();
    widget.controller.agreementIdController.value.text = widget.agreementId;
    widget.controller.paymentAmountController.value.text =
        widget.suggestedAmount.toStringAsFixed(2);
    widget.controller.paymentMethodController.value.text = _methods.first;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final double? amount =
        double.tryParse(widget.controller.paymentAmountController.value.text.trim());
    if (amount == null) {
      return;
    }

    setState(() => _isSubmitting = true);
    final bool success = await widget.onSubmit(
      agreementId: widget.agreementId,
      amount: amount,
      method: widget.controller.paymentMethodController.value.text,
    );
    if (mounted) {
      setState(() => _isSubmitting = false);
      if (success) {
        Navigator.of(context).pop(true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = context.colorScheme;
    final double bottomPadding = MediaQuery.viewInsetsOf(context).bottom;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 12, 20, bottomPadding + 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: cs.outlineVariant,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Record payment',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 20),
                AppTextInputField(
                  controller: widget.controller.paymentAmountController.value,
                  labelText: 'Amount (GH₵)',
                  hintText: '0.00',
                  textInputType:
                      const TextInputType.numberWithOptions(decimal: true),
                  validator: (String? v) {
                    if (v == null || v.isEmpty) {
                      return 'Enter an amount';
                    }
                    if (double.tryParse(v) == null) {
                      return 'Invalid number';
                    }
                    if (double.parse(v) <= 0) {
                      return 'Must be greater than 0';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                AppSelectField<String>(
                  labelText: 'Payment method',
                  options: _methods,
                  value: widget.controller.paymentMethodController.value.text,
                  titleBuilder: (BuildContext context, String method) =>
                      method.toTitleCase(),
                  onChanged: (String method) {
                    widget.controller.paymentMethodController.value.text = method;
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _isSubmitting ? null : _submit,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: _isSubmitting
                        ? SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: cs.onPrimary,
                            ),
                          )
                        : const Text('Record payment'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
