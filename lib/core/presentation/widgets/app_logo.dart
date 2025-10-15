import 'package:automanager/core/core.dart';
import 'package:automanager/core/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';


class AppLogo extends StatelessWidget {
  const AppLogo({this.height, this.width, super.key});

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      web: Image.asset(
        context.isDarkMode
            ? AssetImages.logoWhite
            : AssetImages.logoBlack,
        height: height,
        width: width,
      ),
      mobile: Image.asset(
             (context.isDarkMode
                ? AssetImages.appLogoWhite
                : AssetImages.appLogoBlack),
        height: height,
        width: width,
      ),
    );
  }
}
