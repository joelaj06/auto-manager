import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../../core/presentation/theme/app_theme.dart';
import '../../../../../core/presentation/utils/app_dialogs.dart';
import '../../../../../core/presentation/utils/app_image_assets.dart';
import '../../../../../core/utils/data_formatter.dart';
import '../../../../../core/utils/permissions.dart';
import '../../../data/model/model.dart';
import '../getx/vehicle_controller.dart';

class VehicleDetailDrawer extends StatelessWidget {
  const VehicleDetailDrawer({
    super.key,
    required this.vehicle,
    required this.controller,
    required this.onClose,
  });

  final Vehicle vehicle;
  final VehicleController controller;
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
                  'Vehicle Details',
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

        // Image section
        if (vehicle.image != null && vehicle.image!.isNotEmpty)
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(vehicle.image!),
                fit: BoxFit.cover,
              ),
            ),
          )
        else
          Container(
            height: 180,
            width: double.infinity,
            color: colors.surfaceContainerHighest,
            child: Icon(Icons.directions_car_outlined, size: 48, color: colors.onSurfaceVariant),
          ),

        // Info section
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${vehicle.make} ${vehicle.model}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      vehicle.licensePlate ?? '--',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: colors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              if (UserPermissions.validator.canUpdateVehicle)
                IconButton(
                  onPressed: () => controller.navigateToUpdateVehicleWeb(vehicle),
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
                _DrawerField(label: 'Year', value: vehicle.year.toString()),
                _DrawerField(label: 'Color', value: vehicle.color),
                _DrawerField(
                  label: 'Status',
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: (vehicle.isRented ?? false) ? colors.errorContainer : Colors.green.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      (vehicle.isRented ?? false) ? 'Rented' : 'Available',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: (vehicle.isRented ?? false) ? colors.onErrorContainer : Colors.green[700],
                      ),
                    ),
                  ),
                ),
                _DrawerField(
                  label: 'Added On',
                  value: DataFormatter.formatDate(vehicle.createdAt ?? ''),
                ),
              ],
            ),
          ),
        ),

        // Delete action
        if (UserPermissions.validator.canDeleteVehicle)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: InkWell(
              onTap: () async {
                await AppDialogs.showDialogWithButtons(
                  context,
                  onConfirmPressed: () {
                    controller.deleteTheVehicle(vehicle.id!);
                    onClose();
                  },
                  content: const Text(
                    'Are you sure you want to delete this vehicle?',
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
                      'Delete vehicle',
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
  const _DrawerField({required this.label, this.value, this.child});

  final String label;
  final String? value;
  final Widget? child;

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
          child ??
              Text(
                value != null && value!.isNotEmpty ? value! : '--',
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
        ],
      ),
    );
  }
}
