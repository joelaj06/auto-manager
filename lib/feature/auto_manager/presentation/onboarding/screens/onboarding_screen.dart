import 'package:automanager/core/presentation/theme/app_theme.dart';
import 'package:automanager/core/presentation/utils/app_padding.dart';
import 'package:automanager/core/presentation/utils/app_spacing.dart';
import 'package:automanager/core/presentation/widgets/animated_column.dart';
import 'package:automanager/core/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/routes/routes.dart';
import '../../../../../core/presentation/utils/app_image_assets.dart';
import '../../../../../core/utils/utils.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late AssetImage bgImage;

  final SharedPreferencesWrapper _sharedPreferencesWrapper = Get.find();


  @override
  void initState() {
    bgImage = const AssetImage(AssetImages.openDoorCar);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(bgImage, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: context.height,
            width: context.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: bgImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: context.height,
            width: context.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.transparent, // Top part transparent
                  Colors.black.withOpacity(0.9), // Darker at the bottom
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: AppPaddings.lA.add(AppPaddings.lB),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  AppAnimatedColumn(
                    duration: const Duration(seconds: 2),
                    children: <Widget>[
                      Text(
                        'Streamlined Vehicle and Rental Management',
                        style: context.h3.copyWith(color: Colors.white),
                      ),
                      const AppSpacing(v: 10),
                      Text(
                        'Effortlessly manage your fleet, drivers, and rentals all '
                        'in one place',
                        style: context.h6.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                  const AppSpacing(v: 20),
                  AppButton(
                      onPressed: navigateToLoginScreen,
                      text: 'Continue'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void navigateToLoginScreen() async {
    final bool skipOnboarding = await _sharedPreferencesWrapper.setBool(
        SharedPrefsKeys.skipOnboarding, true);
    if (skipOnboarding) {
      await Get.toNamed(AppRoutes.login);
    }
  }
}
