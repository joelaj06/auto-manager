import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/theme/app_theme.dart';
import '../arguments/work_pay_arguments.dart';
import '../getx/work_and_pay_controller.dart';
import '../widgets/widgets.dart';
class WorkAndPayScreen extends GetView<WorkAndPayController> {
  const WorkAndPayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as WorkAndPayArguments;
    final cs = context.colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      floatingActionButton: Obx(() {
        final agreement = controller.currentAgreement.value;
        if (agreement == null || !agreement.isActive) return const SizedBox();
        return FloatingActionButton.extended(onPressed: () {
          _openRecordPaymentSheet(agreement.id, context);
        }, label: Text('Record Payment'));
        // return RecordPaymentFab(
        //   onTap: () => _openRecordPaymentSheet(agreement.id,context),
        //   isLoading: controller.isLoading.value,
        // );
      }),
     // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Obx(() {
        final isLoading = controller.isLoading.value;
        final agreement = controller.currentAgreement.value;
        final error = controller.error.value;

        return CustomScrollView(
          slivers: [
            _buildAppBar(context, cs, agreement?.agreementId),
            if (isLoading)
              const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              )
            else if (error != null)
              SliverFillRemaining(
                child: ErrorView(
                  message: error.message,
                  onRetry: () => controller.loadAgreementDetails(args.agreementId ?? ''),
                ),
              )
            else if (agreement == null)
                const SliverFillRemaining(child: SizedBox())
              else
                SliverList(
                  delegate: SliverChildListDelegate([
                    const SizedBox(height: 12),

                    // Widget 1 — Hero card
                    WorkPayHeroCard(agreement: agreement),
                    const SizedBox(height: 16),

                    // Widget 2 — Summary grid
                    WorkPaySummaryGrid(agreement: agreement),
                    const SizedBox(height: 16),

                    Divider(
                      height: 1,
                      thickness: 0.5,
                      indent: 16,
                      endIndent: 16,
                      color: cs.outlineVariant.withValues(alpha: 0.3),
                    ),
                    const SizedBox(height: 16),

                    // Widget 3 — Driver tile
                    WorkPayDriverTile(
                      driver: agreement.driver,
                      onTap: () {
                        // Navigate to driver detail — plug in your route
                        // Get.toNamed(Routes.driverDetail,
                        //   arguments: DriverArguments(driverId: agreement.driverId));
                      },
                    ),
                    const SizedBox(height: 16),

                    Divider(
                      height: 1,
                      thickness: 0.5,
                      indent: 16,
                      endIndent: 16,
                      color: cs.outlineVariant.withValues(alpha: 0.3),
                    ),
                    const SizedBox(height: 16),

                    // Widget 4 — Payment timeline
                    Obx(
                          () => WorkPayTimeline(
                        payments: controller.paymentHistory,
                        isLoading: controller.isLoadingPayments.value,
                        error: (controller.paymentsError.value?.message ?? '').isEmpty
                            ? null
                            : controller.paymentsError.value!.message,
                        onRetry: () =>
                            controller.loadPaymentHistory(args.agreementId ?? ''),
                      ),
                    ),

                    // Bottom padding for FAB clearance
                    const SizedBox(height: 96),
                  ]),
                ),
          ],
        );
      }),

      // Widget 5 — Record payment FAB

    );
  }

  SliverAppBar _buildAppBar(
      BuildContext context,
      ColorScheme cs,
      String? agreementId,
      ) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: cs.surface,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Get.back(),
      ),
      title: Text(
        'Work & Pay',
      ),
      // actions: [
      //   IconButton(
      //     icon: const Icon(Icons.more_vert),
      //     onPressed: () => _showOptionsSheet(context),
      //   ),
      // ],
    );
  }

  Future<void> _openRecordPaymentSheet(String agreementId,BuildContext context) async {
    final agreement = controller.currentAgreement.value;
    await RecordPaymentSheet.show(
      context,
      agreementId: agreementId,
      controller: controller,
      suggestedAmount: agreement?.installmentAmount ?? 0,
      onSubmit: ({
        required String agreementId,
        required double amount,
        required String method,
      }) => controller.recordPayment(),
    );
  }

  // void _showOptionsSheet(BuildContext context) {
  //   final cs = context.colorScheme;
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (_) => SafeArea(
  //       child: Padding(
  //         padding: const EdgeInsets.symmetric(vertical: 8),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             ListTile(
  //               leading: Icon(Icons.refresh, color: cs.onSurface),
  //               title: const Text('Refresh'),
  //               onTap: () {
  //                 Navigator.pop(context);
  //                 controller.refresh(_args.agreementId);
  //               },
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
