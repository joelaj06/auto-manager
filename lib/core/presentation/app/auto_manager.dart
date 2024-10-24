import 'package:automanager/core/presentation/theme/app_theme.dart';
import 'package:automanager/main_bindings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/utils.dart';
import '../routes/routes.dart';

class AutoManager extends StatelessWidget {
  const AutoManager({super.key});

  @override
  Widget build(BuildContext context) {

    Get.put<SharedPreferencesWrapper>(
      SharedPreferencesWrapper(),
    );

    final SharedPreferencesWrapper sharedPreferencesWrapper = Get.find();
    return FutureBuilder<bool?>(
        future:
            sharedPreferencesWrapper.getBool(SharedPrefsKeys.skipOnboarding),
        builder: (BuildContext context, AsyncSnapshot<bool?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while waiting
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            if (snapshot.data == true) {
              debugPrint('Data in shared prefs: Skip onboarding is true');
            } else {
              debugPrint('Data in shared prefs: Skip onboarding is false');
            }
          } else {
            debugPrint('No data in shared prefs');
          }
          return _buildGetMaterialApp(
              (snapshot.hasData && snapshot.data == true)
                  ? AppRoutes.login
                  : AppRoutes.onBoarding);
        });
  }

  Widget _buildGetMaterialApp(String initialRoute) {
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
