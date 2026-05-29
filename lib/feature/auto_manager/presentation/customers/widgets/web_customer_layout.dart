import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../../../../core/core.dart';
import '../../../../../core/presentation/theme/app_theme.dart';
import '../../../../../core/utils/permissions.dart';
import '../../../data/model/model.dart';
import '../getx/customer_controller.dart';
import 'customer_detail_drawer.dart';

class WebCustomerLayout extends StatefulWidget {
  const WebCustomerLayout({super.key, required this.controller});

  final CustomerController controller;

  @override
  State<WebCustomerLayout> createState() => _WebCustomerLayoutState();
}

class _WebCustomerLayoutState extends State<WebCustomerLayout> {
  CustomerController get ctrl => widget.controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ctrl.getCustomersWeb(1);
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
                  'Customers${ctrl.totalCount.value == 0 ? '' : ' · ${ctrl.totalCount.value}'}',
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 300,
                child: TextField(
                  onChanged: (val) {
                    ctrl.onSearchFieldInputChanged(val);
                    ctrl.getCustomersWeb(1, refresh: true);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search customers...',
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
              if (UserPermissions.validator.canCreateCustomer) ...[
                const SizedBox(width: 16),
                FilledButton.icon(
                  onPressed: ctrl.navigateToAddCustomerWeb,
                  icon: const Icon(IconlyLight.plus, size: 16),
                  label: const Text('Add customer', style: TextStyle(fontSize: 13)),
                ),
              ],
            ],
          ),
        ),

        Expanded(
          child: Obx(() {
            final List<Customer> customers = ctrl.currentPageCustomers;
            return AppDataTable<Customer>(
              columns: const <AppTableColumn>[
                AppTableColumn(key: 'name', label: 'Name', minWidth: 200),
                AppTableColumn(key: 'phone', label: 'Phone', minWidth: 150),
                AppTableColumn(key: 'email', label: 'Email', minWidth: 200),
                AppTableColumn(key: 'address', label: 'Address', minWidth: 200),
              ],
              rows: customers.map((Customer customer) {
                return AppTableRow<Customer>(
                  data: customer,
                  cells: <String, Widget>{
                    'name': Text(customer.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                    'phone': Text(customer.phone ?? '--', style: const TextStyle(fontSize: 13)),
                    'email': Text(customer.email ?? '--', style: const TextStyle(fontSize: 13)),
                    'address': Text(customer.address ?? '--', style: const TextStyle(fontSize: 13), overflow: TextOverflow.ellipsis),
                  },
                );
              }).toList(),
              totalCount: ctrl.totalCount.value,
              rowsPerPage: 10,
              isLoading: ctrl.isWebLoading.value && customers.isEmpty,
              error: ctrl.webError.value,
              onRetry: () => ctrl.getCustomersWeb(1, refresh: true),
              onPageChanged: (int pageIndex) async {
                await ctrl.getCustomersWeb(pageIndex + 1);
              },
              detailDrawerBuilder: (dynamic data, VoidCallback onClose) {
                return CustomerDetailDrawer(
                  customer: data as Customer,
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
