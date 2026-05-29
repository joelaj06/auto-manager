import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../../../../core/core.dart';
import '../../../../../core/presentation/theme/app_theme.dart';
import '../../../../../core/utils/permissions.dart';
import '../../../data/model/model.dart';
import '../getx/vehicle_controller.dart';
import 'vehicle_detail_drawer.dart';

class WebVehicleLayout extends StatefulWidget {
  const WebVehicleLayout({super.key, required this.controller});

  final VehicleController controller;

  @override
  State<WebVehicleLayout> createState() => _WebVehicleLayoutState();
}

class _WebVehicleLayoutState extends State<WebVehicleLayout> {
  VehicleController get ctrl => widget.controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ctrl.getVehiclesWeb(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colorScheme;

    return Column(
      children: <Widget>[
        // Toolbar
        Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: colors.surface,
            border: Border(
              bottom: BorderSide(
                color: colors.outlineVariant.withValues(alpha: 0.5),
                width: 0.5,
              ),
            ),
          ),
          child: Row(
            children: <Widget>[
              Obx(
                () => Text(
                  'Vehicles${ctrl.totalCount.value == 0 ? '' : ' · ${ctrl.totalCount.value}'}',
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 300,
                child: TextField(
                  onChanged: (val) {
                    ctrl.onSearchFieldInputChanged(val);
                    ctrl.getVehiclesWeb(1, refresh: true);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search vehicles...',
                    hintStyle: TextStyle(fontSize: 13, color: colors.onSurfaceVariant),
                    prefixIcon: const Icon(IconlyLight.search, size: 18),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: colors.outlineVariant),
                    ),
                  ),
                ),
              ),
              if (UserPermissions.validator.canCreateVehicle) ...[
                const SizedBox(width: 16),
                FilledButton.icon(
                  onPressed: ctrl.navigateToAddVehicleWeb,
                  icon: const Icon(IconlyLight.plus, size: 16),
                  label: const Text('Add vehicle', style: TextStyle(fontSize: 13)),
                ),
              ],
            ],
          ),
        ),

        Expanded(
          child: Obx(() {
            final List<Vehicle> vehicles = ctrl.currentPageVehicles;
            return AppDataTable<Vehicle>(
              columns: const <AppTableColumn>[
                AppTableColumn(key: 'image', label: '', minWidth: 80),
                AppTableColumn(key: 'name', label: 'Vehicle', minWidth: 200),
                AppTableColumn(key: 'plate', label: 'Plate Number', minWidth: 150),
                AppTableColumn(key: 'year', label: 'Year', minWidth: 100),
                AppTableColumn(key: 'status', label: 'Status', minWidth: 120),
              ],
              rows: vehicles.map((Vehicle vehicle) {
                return AppTableRow<Vehicle>(
                  data: vehicle,
                  cells: <String, Widget>{
                    'image': Container(
                      width: 40,
                      height: 40,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: colors.surfaceContainerHighest,
                      ),
                      child: CachedNetworkImage(
                        imageUrl: vehicle.image ?? '',
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Image.asset(AssetImages.speedometer, fit: BoxFit.cover),
                        errorWidget: (context, url, error) => Image.asset(AssetImages.speedometer, fit: BoxFit.cover),
                      ),
                    ),
                    'name': Text('${vehicle.make} ${vehicle.model}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                    'plate': Text(vehicle.licensePlate ?? '--', style: const TextStyle(fontSize: 13)),
                    'year': Text('${vehicle.year ?? '--'}', style: const TextStyle(fontSize: 13)),
                    'status': Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: (vehicle.isRented ?? false) ? colors.errorContainer.withValues(alpha: 0.5) : Colors.green.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        (vehicle.isRented ?? false) ? 'Rented' : 'Available',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: (vehicle.isRented ?? false) ? colors.onErrorContainer : Colors.green[700],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  },
                );
              }).toList(),
              totalCount: ctrl.totalCount.value,
              rowsPerPage: 10,
              isLoading: ctrl.isWebLoading.value && vehicles.isEmpty,
              error: ctrl.webError.value,
              onRetry: () => ctrl.getVehiclesWeb(1, refresh: true),
              onPageChanged: (int pageIndex) async {
                await ctrl.getVehiclesWeb(pageIndex + 1);
              },
              detailDrawerBuilder: (dynamic data, VoidCallback onClose) {
                return VehicleDetailDrawer(
                  vehicle: data as Vehicle,
                  controller: ctrl,
                  onClose: onClose,
                );
              },
              drawerWidth: 320,
            );
          }),
        ),
      ],
    );
  }
}
