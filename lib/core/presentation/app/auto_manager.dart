import 'package:automanager/core/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/routes.dart';


class AutoManager extends StatelessWidget {
  const AutoManager({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Auto Manager',
      themeMode: ThemeMode.system,
      theme:  AppTheme.light,
      darkTheme:  AppTheme.dark,
      initialRoute: AppRoutes.onBoarding,
      getPages: Pages.pages,
    );
  }
}
