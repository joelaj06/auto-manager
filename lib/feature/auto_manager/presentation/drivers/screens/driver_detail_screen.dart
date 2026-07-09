import 'package:automanager/core/core.dart';
import 'package:automanager/core/presentation/theme/app_theme.dart';
import 'package:automanager/feature/auto_manager/data/model/response/driver/driver_model.dart';
import 'package:automanager/feature/auto_manager/data/model/response/work_and_pay/work_and_pay_agreement_model.dart';
import 'package:automanager/feature/auto_manager/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../getx/driver_detail_controller.dart';

class DriverDetailScreen extends GetView<DriverDetailController> {
  const DriverDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Details'),
        actions: [
          IconButton(
            onPressed: controller.navigateToUpdateDriver,
            icon: const Icon(IconlyLight.edit),
          ),
          IconButton(
            onPressed: () async {
              await AppDialogs.showDialogWithButtons(
                context,
                onConfirmPressed: controller.deleteTheDriver,
                content: const Text(
                  'Are you sure you want to delete this driver?',
                  textAlign: TextAlign.center,
                ),
                confirmText: 'Delete',
              );
            },
            icon: const Icon(IconlyLight.delete, color: Colors.red),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        final driver = controller.driver.value;
        if (driver == null) {
          return const Center(child: Text('Driver not found'));
        }

        return SingleChildScrollView(
          padding: AppPaddings.mA,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, driver),
              const AppSpacing(v: 24),
              _buildInfoSection(context, driver),
              const AppSpacing(v: 24),
              _buildWorkPaySection(context),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildHeader(BuildContext context, Driver driver) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: colorScheme.primaryContainer,
            child: Text(
              '${driver.firstName?[0] ?? ''}${driver.lastName?[0] ?? ''}'.toUpperCase(),
              style: textTheme.headlineMedium?.copyWith(
                color: colorScheme.onPrimaryContainer,
              ),
            ),
          ),
          const AppSpacing(v: 16),
          Text(
            '${driver.firstName} ${driver.lastName}',
            style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            driver.email ?? '',
            style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context, Driver driver) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    
    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: AppPaddings.mA,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'PERSONAL INFORMATION',
              style: textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
            const AppSpacing(v: 16),
            _DetailItem(label: 'Phone', value: driver.phone ?? '--'),
            const Divider(),
            _DetailItem(label: 'License Number', value: driver.licenseNumber ?? '--'),
            const Divider(),
            _DetailItem(
              label: 'License Expiry',
              value: driver.licenceExpiryDate != null
                  ? DataFormatter.formatDateToString(driver.licenceExpiryDate!)
                  : '--',
            ),
            const Divider(),
            _DetailItem(
              label: 'Vehicle',
              value: driver.vehicle != null
                  ? '${driver.vehicle?.make} ${driver.vehicle?.model} (${driver.vehicle?.licensePlate})'
                  : 'None Assigned',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkPaySection(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'WORK & PAY AGREEMENT',
          style: textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.primary,
          ),
        ),
        const AppSpacing(v: 12),
        Obx(() {
          if (controller.isLoadingWorkPay.value) {
            return const LinearProgressIndicator();
          }

          final agreement = controller.workAndPayAgreement.value;
          if (agreement == null) {
            return Card(
              elevation: 0,
              color: colorScheme.surfaceContainerLow,
              child: Padding(
                padding: AppPaddings.mA,
                child: Row(
                  children: [
                    const Icon(IconlyLight.info_square),
                    const AppSpacing(h: 12),
                    const Expanded(child: Text('No Work & Pay agreement found for this driver.')),
                  ],
                ),
              ),
            );
          }

          return InkWell(
            onTap: controller.navigateToWorkAndPay,
            child: Card(
              elevation: 0,
              color: colorScheme.primaryContainer.withValues(alpha: 0.3),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: AppPaddings.mA,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Agreement Active',
                            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Final Price: ${DataFormatter.getLocalCurrencyFormatter(context).format(agreement.totalSalePrice)}',
                            style: textTheme.bodyMedium,
                          ),
                          Text(
                            'Remaining: ${DataFormatter.getLocalCurrencyFormatter(context).format(agreement.balanceDue)}',
                            style: textTheme.bodySmall?.copyWith(color: colorScheme.primary),
                          ),
                        ],
                      ),
                    ),
                    const Icon(IconlyLight.arrow_right_2),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}

class _DetailItem extends StatelessWidget {
  const _DetailItem({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: textTheme.labelSmall?.copyWith(color: colorScheme.onSurfaceVariant),
          ),
          Text(
            value,
            style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
