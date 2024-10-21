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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const OnboardingScreen(),
    );
  }
}
