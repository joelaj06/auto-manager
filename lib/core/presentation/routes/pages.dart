import 'package:automanager/feature/authentication/presentation/presentation.dart';
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
  ];
}
