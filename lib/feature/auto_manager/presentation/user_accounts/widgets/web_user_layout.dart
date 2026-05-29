import 'package:automanager/feature/authentication/data/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../../../../core/core.dart';
import '../../../../../core/presentation/theme/app_theme.dart';
import '../../../../../core/utils/permissions.dart';
import '../getx/user_account_controller.dart';
import 'user_detail_drawer.dart';

class WebUserLayout extends StatefulWidget {
  const WebUserLayout({super.key, required this.controller});

  final UserAccountController controller;

  @override
  State<WebUserLayout> createState() => _WebUserLayoutState();
}

class _WebUserLayoutState extends State<WebUserLayout> {
  UserAccountController get ctrl => widget.controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ctrl.getUsersWeb(1);
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
                  'Users${ctrl.totalCount.value == 0 ? '' : ' · ${ctrl.totalCount.value}'}',
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 300,
                child: TextField(
                  onChanged: (val) {
                    ctrl.onSearchFieldInputChanged(val);
                    ctrl.getUsersWeb(1, refresh: true);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search users...',
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
              if (UserPermissions.validator.canCreateUser) ...[
                const SizedBox(width: 16),
                FilledButton.icon(
                  onPressed: ctrl.navigateToAddUserScreen,
                  icon: const Icon(IconlyLight.plus, size: 16),
                  label: const Text('Add user', style: TextStyle(fontSize: 13)),
                ),
              ],
            ],
          ),
        ),

        Expanded(
          child: Obx(() {
            final List<User> users = ctrl.currentPageUsers;
            return AppDataTable<User>(
              columns: const <AppTableColumn>[
                AppTableColumn(key: 'name', label: 'Name', minWidth: 200),
                AppTableColumn(key: 'email', label: 'Email', minWidth: 200),
                AppTableColumn(key: 'role', label: 'Role', minWidth: 150),
                AppTableColumn(key: 'status', label: 'Status', minWidth: 120),
              ],
              rows: users.map((User user) {
                return AppTableRow<User>(
                  data: user,
                  cells: <String, Widget>{
                    'name': Text('${user.firstName} ${user.lastName}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                    'email': Text(user.email ?? '--', style: const TextStyle(fontSize: 13)),
                    'role': Text(user.role?.name ?? '--', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.blue)),
                    'status': Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: (user.status == 'active') ? Colors.green.withValues(alpha: 0.15) : colors.errorContainer.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        (user.status ?? 'active').toTitleCase(),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: (user.status == 'active') ? Colors.green[700] : colors.onErrorContainer,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  },
                );
              }).toList(),
              totalCount: ctrl.totalCount.value,
              rowsPerPage: 10,
              isLoading: ctrl.isWebLoading.value && users.isEmpty,
              error: ctrl.webError.value,
              onRetry: () => ctrl.getUsersWeb(1, refresh: true),
              onPageChanged: (int pageIndex) async {
                await ctrl.getUsersWeb(pageIndex + 1);
              },
              detailDrawerBuilder: (dynamic data, VoidCallback onClose) {
                return UserDetailDrawer(
                  user: data as User,
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
