import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/nav/bottom_nav_icons.dart';
import '../../../../../core/presentation/nav/bottom_nav_tabs.dart';
import '../../../../../core/presentation/theme/app_theme.dart';
import '../../../../../core/presentation/widgets/app_logo.dart';
import '../../dashboard/getx/dashboard_controller.dart';
import '../widgets/logo_icon.dart';
import '../widgets/navigation_animation.dart';

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
    final bool isDesktop = _isDesktop(context);

    return Row(
      children: <Widget>[
        _AppSidebar(
          selectedIndex: _selectedIndex,
          isExpanded: isDesktop,
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
            content: mobileNavPages[_selectedIndex],
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
  });

  final int selectedIndex;
  final bool isExpanded;
  final ValueChanged<int> onDestinationSelected;

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
                vertical: 20,
              ),
              child: widget.isExpanded
                  ? Row(
                children: <Widget>[
                  LogoIcon(logoUrl: dashboardController.company.value.logoUrl,),
                  const SizedBox(width: 12),
                  Obx(() => Text(
                      dashboardController.company.value.name ?? 'AutoForce Manager',
                      style: context.appBarTitle.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colors.onSurface,
                      ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )
                  : Center(child: LogoIcon(logoUrl: dashboardController.company.value.logoUrl,)),
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
            lastName: dashboardController.loginResponse.lastName,),
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
  const _ProfileTile({required this.isExpanded,
  required this.firstName,required this.lastName});

  final bool isExpanded;
  final String firstName;
  final String lastName;

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
      return Center(child: avatar);
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
                'Admin',
                style: TextStyle(
                  fontSize: 11,
                  color: colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        Icon(
          Icons.more_horiz_rounded,
          size: 18,
          color: colors.onSurfaceVariant,
        ),
      ],
    );
  }
}