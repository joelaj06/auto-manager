import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/theme/app_theme.dart';
import '../../../../../core/presentation/widgets/modal_header.dart';
import '../getx/sales_controller.dart';
import '../widgets/sales_form_fields.dart';
class WebAddSaleModal extends StatelessWidget {
  const WebAddSaleModal({required this.controller});

  final SalesController controller;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colorScheme;

    return Scaffold(
      // Transparent scaffold so the dimmed backdrop fills the screen
      backgroundColor: Colors.black.withValues(alpha: 0.45),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 460),
          child: Material(
            color: colors.surface,
            borderRadius: BorderRadius.circular(14),
            clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // ── Header ──────────────────────────────────────────────────
                ModalHeader(
                  title: 'New sale',
                  onClose: () => Get.back(),
                ),

                // ── Form body ────────────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
                  child: SaleFormFields(controller: controller),
                ),

                // ── Footer ───────────────────────────────────────────────────
                Obx(() => ModalFooter(
                    saveText: 'Save sale',
                    onSave: controller.saleFormIsValid.value &&
                        !controller.isLoading.value
                        ? controller.onSaleSaved
                        : null,
                    isLoading: controller.isLoading.value,
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