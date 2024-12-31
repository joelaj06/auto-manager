import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:automanager/core/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../core/presentation/nav/nav.dart';
import '../widgets/navigation_animation.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

int _selectedIndex = 0;

class _BaseScreenState extends State<BaseScreen> {
  DateTime? currentBackPressTime;

  final List<Widget> navBarItemList = <Widget>[];

  Future<bool> onWillPop() {
    final DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'Double tap to exit',
        backgroundColor: Colors.black.withOpacity(0.5),
      );
      return Future<bool>.value(false);
    }
    return Future<bool>.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildMobileBottomNavigationBar(),
      body: Builder(builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          onPopInvoked: (bool didPop) async {
            if (didPop) {
              return;
            }
            final NavigatorState navigator = Navigator.of(context);
            final bool willPop = await onWillPop();
            if (willPop) {
              navigator.pop();
            }
          },
          child: _buildMobileNavigationScreen(),
        );
      }),
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
                  isActive ? mobileNavIcons[index] : mobileNavIcons[index],
                  size: isActive ? 26 : 24,
                  color: isActive
                      ? context.colorScheme.onSurface
                      : context.colorScheme.inverseSurface.withOpacity(0.8),
                ),
                FittedBox(
                  fit: BoxFit.fill,
                  child: Text(
                    mobileNavTexts[index],
                    style: context.caption.copyWith(
                      fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                      color:
                          isActive?  context.colorScheme.onSurface
                        : context.colorScheme.inverseSurface.withOpacity(0.8)
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        backgroundColor: context.colorScheme.background,
        activeIndex: _selectedIndex,
        splashColor: context.colorScheme.primary,
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.none,
        onTap: (int index) => setState(
          () => _selectedIndex = index,
        ),
      ),
    );
  }

  Column _buildMobileNavigationScreen() {
    return Column(
      children: <Widget>[
        //const ConnectivityStatus(),
        Expanded(
          child: NavigationAnimation(
            content: mobileNavPages[_selectedIndex],
          ),
        ),
      ],
    );
  }
}
