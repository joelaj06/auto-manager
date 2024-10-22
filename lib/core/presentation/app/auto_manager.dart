import 'package:automanager/core/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../feature/auto_manager/presentation/onboarding/screens/onboarding_screen.dart';

class AutoManager extends StatelessWidget {
  const AutoManager({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AutoManager',
      themeMode: ThemeMode.light,
      theme:  AppTheme.light,
      darkTheme:  AppTheme.dark,
      home: const OnboardingScreen(),
    );
  }
}
