import 'package:automanager/core/presentation/theme/app_theme.dart';
import 'package:automanager/main_bindings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/routes.dart';

class AutoManager extends StatelessWidget {
  const AutoManager({super.key, required this.initialRoute});

  final String initialRoute;

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Auto Manager',
      themeMode: ThemeMode.light,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      initialRoute: initialRoute,
      getPages: Pages.pages,
      initialBinding: MainBindings(),
    );
  }
}
