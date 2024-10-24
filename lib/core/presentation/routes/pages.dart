import 'package:automanager/feature/authentication/presentation/presentation.dart';
import 'package:automanager/feature/auto_manager/presentation/base/screens/base_screen.dart';
import 'package:get/get.dart';
import '../../../feature/auto_manager/presentation/presentation.dart';
import 'app_routes.dart';

class Pages {
  static final List<GetPage<AppRoutes>> pages = <GetPage<AppRoutes>>[
    GetPage<AppRoutes>(
      name: AppRoutes.onBoarding,
      page: () => const OnboardingScreen(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: LoginBindings(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.base,
      page: () => const BaseScreen(),
    ),
  ];
}
