import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../../../../core/core.dart';
import '../../../../../core/presentation/theme/app_theme.dart';
import '../../../../../core/utils/permissions.dart';
import '../../../data/model/model.dart';
import '../getx/driver_controller.dart';
import 'driver_detail_drawer.dart';

class WebDriverLayout extends StatefulWidget {
  const WebDriverLayout({super.key, required this.controller});

  final DriverController controller;

  @override
  State<WebDriverLayout> createState() => _WebDriverLayoutState();
}

class _WebDriverLayoutState extends State<WebDriverLayout> {
  DriverController get ctrl => widget.controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ctrl.getDriversWeb(1);
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
                  'Drivers${ctrl.totalCount.value == 0 ? '' : ' · ${ctrl.totalCount.value}'}',
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 300,
                child: TextField(
                  onChanged: (val) {
                    ctrl.onSearchFieldInputChanged(val);
                    ctrl.getDriversWeb(1, refresh: true);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search drivers...',
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
              if (UserPermissions.validator.canCreateDriver) ...[
                const SizedBox(width: 16),
                FilledButton.icon(
                  onPressed: ctrl.navigateToAddDriverWeb,
                  icon: const Icon(IconlyLight.plus, size: 16),
                  label: const Text('Add driver', style: TextStyle(fontSize: 13)),
                ),
              ],
            ],
          ),
        ),

        Expanded(
          child: Obx(() {
            final List<Driver> drivers = ctrl.currentPageDrivers;
            return AppDataTable<Driver>(
              columns: const <AppTableColumn>[
                AppTableColumn(key: 'name', label: 'Name', minWidth: 200),
                AppTableColumn(key: 'phone', label: 'Phone', minWidth: 150),
                AppTableColumn(key: 'email', label: 'Email', minWidth: 200),
                AppTableColumn(key: 'license', label: 'License No.', minWidth: 150),
                AppTableColumn(key: 'vehicle', label: 'Vehicle', minWidth: 180),
              ],
              rows: drivers.map((Driver driver) {
                return AppTableRow<Driver>(
                  data: driver,
                  cells: <String, Widget>{
                    'name': Text('${driver.firstName} ${driver.lastName}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                    'phone': Text(driver.phone ?? '--', style: const TextStyle(fontSize: 13)),
                    'email': Text(driver.email ?? '--', style: const TextStyle(fontSize: 13)),
                    'license': Text(driver.licenseNumber ?? '--', style: const TextStyle(fontSize: 13)),
                    'vehicle': Text(
                      driver.vehicle != null ? '${driver.vehicle?.make} ${driver.vehicle?.model}' : 'None',
                      style: const TextStyle(fontSize: 13),
                    ),
                  },
                );
              }).toList(),
              totalCount: ctrl.totalCount.value,
              rowsPerPage: 10,
              isLoading: ctrl.isWebLoading.value && drivers.isEmpty,
              error: ctrl.webError.value,
              onRetry: () => ctrl.getDriversWeb(1, refresh: true),
              onPageChanged: (int pageIndex) async {
                await ctrl.getDriversWeb(pageIndex + 1);
              },
              detailDrawerBuilder: (dynamic data, VoidCallback onClose) {
                return DriverDetailDrawer(
                  driver: data as Driver,
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
