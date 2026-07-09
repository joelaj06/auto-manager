import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/nav/bottom_nav_icons.dart';
import '../../../../../core/presentation/nav/bottom_nav_tabs.dart';
import '../../../../../core/presentation/theme/app_theme.dart';
import '../../../../../core/presentation/utils/app_dialogs.dart';
import '../../dashboard/getx/dashboard_controller.dart';
import '../../more/getx/more_controller.dart';
import '../widgets/change_password_sheet.dart';
import '../widgets/logo_icon.dart';
import '../widgets/navigation_animation.dart';
import '../widgets/popup_row.dart';

// Responsive breakpoints
const double kTabletBreakpoint = 768.0;
const double kDesktopBreakpoint = 1100.0;

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

int _selectedIndex = 0;

class _BaseScreenState extends State<BaseScreen> {
  DateTime? currentBackPressTime;
  bool _sidebarExpanded = true;


  Future<bool> onWillPop() {
    final DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'Double tap to exit',
        backgroundColor: Colors.black.withValues(alpha: 0.5),
      );
      return Future<bool>.value(false);
    }
    return Future<bool>.value(true);
  }

  bool _isTabletOrWider(BuildContext context) {
    return MediaQuery.of(context).size.width >= kTabletBreakpoint;
  }

  bool _isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= kDesktopBreakpoint;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _sidebarExpanded = _isDesktop(context);
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    final bool isWide = _isTabletOrWider(context);

    return Scaffold(
      bottomNavigationBar: isWide ? null : _buildMobileBottomNavigationBar(),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, _) async {
          if (didPop) return;
          final NavigatorState navigator = Navigator.of(context);
          final bool willPop = await onWillPop();
          if (willPop) navigator.pop();
        },
        child: isWide
            ? _buildWideNavigationScreen(context)
            : _buildMobileNavigationScreen(),
      ),
    );
  }

  // ─── Wide layout: Sidebar + content ───────────────────────────────────────

  Widget _buildWideNavigationScreen(BuildContext context) {
   // final bool isDesktop = _isDesktop(context);

    return Row(
      children: <Widget>[
        _AppSidebar(
          selectedIndex: _selectedIndex,
          isExpanded: _sidebarExpanded,
          onToggleExpanded: () {
            setState(() => _sidebarExpanded = !_sidebarExpanded);
          },
          onDestinationSelected: (int index) {
            setState(() => _selectedIndex = index);
          },
        ),
        Expanded(
          child: NavigationAnimation(
            content: tabNavPages[_selectedIndex],
          ),
        ),
      ],
    );
  }

  // ─── Mobile layout ─────────────────────────────────────────────────────────

  Column _buildMobileNavigationScreen() {
    return Column(
      children: <Widget>[
        Expanded(
          child: NavigationAnimation(
            content: mobileNavPages[_selectedIndex > mobileNavPages.length
                ? 0
                : _selectedIndex],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: AnimatedBottomNavigationBar.builder(
        itemCount: mobileNavPages.length,
        tabBuilder: (int index, bool isActive) {
          return SizedBox(
            width: MediaQuery.of(context).size.width / mobileNavPages.length,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  mobileNavIcons[index],
                  size: isActive ? 26 : 24,
                  color: isActive
                      ? context.colorScheme.onSurface
                      : context.colorScheme.inverseSurface
                      .withValues(alpha: 0.8),
                ),
                FittedBox(
                  fit: BoxFit.fill,
                  child: Text(
                    mobileNavTexts[index],
                    style: context.caption.copyWith(
                      fontWeight:
                      isActive ? FontWeight.bold : FontWeight.w500,
                      color: isActive
                          ? context.colorScheme.onSurface
                          : context.colorScheme.inverseSurface
                          .withValues(alpha: 0.8),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        backgroundColor: context.colorScheme.surface,
        activeIndex: _selectedIndex,
        splashColor: context.colorScheme.primary,
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.none,
        onTap: (int index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}

// ─── Sidebar Widget ──────────────────────────────────────────────────────────

class _AppSidebar extends StatefulWidget {
  const _AppSidebar({
    required this.selectedIndex,
    required this.isExpanded,
    required this.onDestinationSelected,
    required this.onToggleExpanded,
  });

  final int selectedIndex;
  final bool isExpanded;
  final ValueChanged<int> onDestinationSelected;
  final VoidCallback onToggleExpanded;

  @override
  State<_AppSidebar> createState() => _AppSidebarState();
}

class _AppSidebarState extends State<_AppSidebar> {
  late DashboardController dashboardController;

  @override
  void initState() {
    super.initState();
    if(Get.isRegistered<DashboardController>()) {
      dashboardController = Get.find<DashboardController>();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      width: widget.isExpanded ? 220.0 : 72.0,
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(
          right: BorderSide(
            color: colors.outlineVariant.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // ── Logo / App icon ──
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              child: widget.isExpanded
                  ? Row(
                children: <Widget>[
                  LogoIcon(
                    logoUrl: dashboardController.company.value.logoUrl,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Obx(
                          () => Text(
                        dashboardController.company.value.name ??
                            'AutoForce Manager',
                        style: context.appBarTitle.copyWith(
                          fontWeight: FontWeight.w700,
                          color: colors.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  // ← toggle collapse button
                  IconButton(
                    onPressed: widget.onToggleExpanded,
                    tooltip: 'Collapse sidebar',
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    icon: Icon(
                      Icons.menu_open_rounded,
                      size: 20,
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ],
              )
                  : Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  LogoIcon(
                    logoUrl: dashboardController.company.value.logoUrl,
                  ),
                  const SizedBox(height: 8),
                  // ← toggle expand button when collapsed
                  IconButton(
                    onPressed: widget.onToggleExpanded,
                    tooltip: 'Expand sidebar',
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    icon: Icon(
                      Icons.menu_rounded,
                      size: 20,
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Nav items ──
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              itemCount: tabNavPages.length,
              itemBuilder: (BuildContext context, int index) {
                final bool isSelected = index == widget.selectedIndex;
                return _SidebarItem(
                  icon: tabNavIcons[index],
                  label: tabNavTexts[index],
                  isSelected: isSelected,
                  isExpanded: widget.isExpanded,
                  onTap: () => widget.onDestinationSelected(index),
                );
              },
            ),
          ),

          // ── Bottom profile section ──
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(12),
            child: _ProfileTile(isExpanded: widget.isExpanded,
            firstName: dashboardController.loginResponse.firstName,
            lastName: dashboardController.loginResponse.lastName,
              role: dashboardController.loginResponse.role?.name ?? 'User',
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

// ─── Individual sidebar nav item ─────────────────────────────────────────────

class _SidebarItem extends StatelessWidget {
  const _SidebarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.isExpanded,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final bool isExpanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colorScheme;

    final Color bgColor = isSelected
        ? colors.primaryContainer
        : Colors.transparent;
    final Color iconColor = isSelected
        ? colors.onPrimaryContainer
        : colors.onSurfaceVariant;
    final Color textColor = isSelected
        ? colors.onPrimaryContainer
        : colors.onSurfaceVariant;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: isExpanded ? 14 : 0,
              vertical: 12,
            ),
            child: isExpanded
                ? Row(
              children: <Widget>[
                Icon(icon, size: 20, color: iconColor),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w500,
                      color: textColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            )
                : Center(
              child: Tooltip(
                message: label,
                child: Icon(icon, size: 22, color: iconColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}



// ─── Profile tile at the bottom of sidebar ───────────────────────────────────

class _ProfileTile extends StatelessWidget {
  const _ProfileTile({
    required this.isExpanded,
    required this.firstName,
    required this.lastName,
    required this.role,
  });

  final bool isExpanded;
  final String firstName;
  final String lastName;
  final String role;

  void _showMorePopup(BuildContext context) {
    // MoreController is already injected via BaseScreen bindings
    final MoreController moreCtrl = Get.find<MoreController>();
    final ColorScheme colors = context.colorScheme;
    final RenderBox button = context.findRenderObject()! as RenderBox;
    final RenderBox overlay =
    Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;
    final Offset offset = button.localToGlobal(
      Offset.zero,
      ancestor: overlay,
    );

    showMenu<String>(
      context: context,
      // Anchor above the profile tile
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy - 160,
        offset.dx + button.size.width,
        offset.dy,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: colors.outlineVariant.withValues(alpha: 0.5),
          width: 0.5,
        ),
      ),
      elevation: 4,
      items: <PopupMenuEntry<String>>[
        // ── Theme toggle ──────────────────────────────────────────────
        PopupMenuItem<String>(
          value: 'theme',
          onTap: moreCtrl.toggleTheme,
          child: Obx(
                () => PopupRow(
              icon: moreCtrl.isDarkMode.value
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
              label: moreCtrl.isDarkMode.value ? 'Light mode' : 'Dark mode',
            ),
          ),
        ),

        const PopupMenuDivider(height: 1),

        // ── Change password ───────────────────────────────────────────
        PopupMenuItem<String>(
          value: 'password',
          onTap: () {
            // Small delay so the menu closes before the sheet opens
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _showChangePasswordSheet(context, moreCtrl);
            });
          },
          child: const PopupRow(
            icon: Icons.lock_outline_rounded,
            label: 'Change password',
          ),
        ),

        const PopupMenuDivider(height: 1),

        // ── Logout ────────────────────────────────────────────────────
        PopupMenuItem<String>(
          value: 'logout',
          onTap: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AppDialogs.showDialogWithButtons(
                context,
                onConfirmPressed: moreCtrl.logUserOut,
                content: const Text(
                  'Are you sure you want to logout?',
                  textAlign: TextAlign.center,
                ),
                confirmText: 'Logout',
              );
            });
          },
          child: PopupRow(
            icon: Icons.logout_rounded,
            label: 'Logout',
            color: colors.error,
          ),
        ),
      ],
    );
  }

  void _showChangePasswordSheet(
      BuildContext context, MoreController ctrl) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) =>
          ChangePasswordSheet(controller: ctrl),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colorScheme;

    final Widget avatar = CircleAvatar(
      radius: 16,
      backgroundColor: colors.primaryContainer,
      child: Icon(
        Icons.person_rounded,
        size: 18,
        color: colors.onPrimaryContainer,
      ),
    );

    if (!isExpanded) {
      // Collapsed: just the avatar, tap it to open popup
      return Center(
        child: GestureDetector(
          onTap: () => _showMorePopup(context),
          child: Tooltip(
            message: 'More options',
            child: avatar,
          ),
        ),
      );
    }

    return Row(
      children: <Widget>[
        avatar,
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                '$firstName $lastName',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: colors.onSurface,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                role,
                style: TextStyle(
                  fontSize: 11,
                  color: colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        // ── Three-dot trigger ──────────────────────────────────────────
        Builder(
          builder: (BuildContext btnContext) => IconButton(
            onPressed: () => _showMorePopup(btnContext),
            tooltip: 'More options',
            padding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            icon: Icon(
              Icons.more_horiz_rounded,
              size: 18,
              color: colors.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}