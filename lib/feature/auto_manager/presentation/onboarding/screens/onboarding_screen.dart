import 'package:automanager/core/presentation/theme/app_theme.dart';
import 'package:automanager/core/presentation/utils/app_padding.dart';
import 'package:automanager/core/presentation/widgets/animated_column.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/utils/app_image_assets.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.arrow_forward),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: context.height,
            width: context.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AssetImages.blackBmw),
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
                  Colors.black.withOpacity(0.8), // Darker at the bottom
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding:
                  AppPaddings.lA.add(AppPaddings.lB.add(AppPaddings.bodyB)),
              // Add padding if needed
              child: AppAnimatedColumn(
                duration: const Duration(seconds: 2),
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Streamlined Vehicle and Rental Management',
                    style: context.h3.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Effortlessly manage your fleet, drivers, and rentals all '
                    'in one place',
                    style: context.h6.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
