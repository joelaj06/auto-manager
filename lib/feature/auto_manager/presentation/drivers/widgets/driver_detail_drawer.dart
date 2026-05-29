import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../../core/presentation/theme/app_theme.dart';
import '../../../../../core/presentation/utils/app_dialogs.dart';
import '../../../../../core/presentation/utils/string_utils.dart';
import '../../../../../core/utils/data_formatter.dart';
import '../../../../../core/utils/permissions.dart';
import '../../../data/model/model.dart';
import '../getx/driver_controller.dart';

class DriverDetailDrawer extends StatelessWidget {
  const DriverDetailDrawer({
    super.key,
    required this.driver,
    required this.controller,
    required this.onClose,
  });

  final Driver driver;
  final DriverController controller;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: colors.outlineVariant.withValues(alpha: 0.5),
                width: 0.5,
              ),
            ),
          ),
          child: Row(
            children: <Widget>[
              const Expanded(
                child: Text(
                  'Driver Details',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 18),
                onPressed: onClose,
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
              ),
            ],
          ),
        ),

        // Profile section
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 24,
                backgroundColor: colors.primaryContainer,
                child: Text(
                  '${driver.firstName[0]}${driver.lastName[0]}'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: colors.onPrimaryContainer,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${driver.firstName} ${driver.lastName}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      driver.phone ?? '--',
                      style: TextStyle(
                        fontSize: 12,
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              if (UserPermissions.validator.canUpdateDriver)
                IconButton(
                  onPressed: () => controller.navigateToUpdateDriverWeb(driver),
                  icon: const Icon(IconlyLight.edit_square, size: 20),
                ),
            ],
          ),
        ),

        const Divider(height: 1),

        // Details
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _DrawerField(label: 'Email', value: driver.email),
                _DrawerField(label: 'License Number', value: driver.licenseNumber),
                _DrawerField(
                  label: 'License Expiry',
                  value: driver.licenceExpiryDate != null
                      ? DataFormatter.formatDateToString(driver.licenceExpiryDate!)
                      : '--',
                ),
                _DrawerField(
                  label: 'Assigned Vehicle',
                  value: driver.vehicle != null
                      ? '${driver.vehicle?.make} ${driver.vehicle?.model} (${driver.vehicle?.licensePlate})'
                      : 'None',
                ),
                _DrawerField(
                  label: 'Status',
                  value: (driver.user?.status ?? 'active').toTitleCase(),
                ),
                _DrawerField(
                  label: 'Joined On',
                  value: DataFormatter.formatDate(driver.createdAt ?? ''),
                ),
              ],
            ),
          ),
        ),

        // Delete action
        if (UserPermissions.validator.canDeleteDriver)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: InkWell(
              onTap: () async {
                await AppDialogs.showDialogWithButtons(
                  context,
                  onConfirmPressed: () {
                    controller.deleteTheDriver(driver);
                    onClose();
                  },
                  content: const Text(
                    'Are you sure you want to delete this driver?',
                    textAlign: TextAlign.center,
                  ),
                  confirmText: 'Delete',
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: colors.error),
                  color: colors.error.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(IconlyLight.delete, size: 15, color: colors.error),
                    const SizedBox(width: 10),
                    Text(
                      'Delete driver',
                      style: TextStyle(fontSize: 13, color: colors.error),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _DrawerField extends StatelessWidget {
  const _DrawerField({required this.label, this.value});

  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              letterSpacing: 0.6,
              fontWeight: FontWeight.w500,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value != null && value!.isNotEmpty ? value! : '--',
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
