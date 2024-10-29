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
    ),GetPage<AppRoutes>(
      name: AppRoutes.signup,
      page: () => const SignUpScreen(),
      binding: SignUpBindings(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.base,
      page: () => const BaseScreen(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.addCompany,
      page: () => const AddCompanyScreen(),
      binding: CompanyBindings(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.dashboard,
      page: () => const DashboardScreen(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.sales,
      page: () => const SalesScreen(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.expenses,
      page: () => const ExpensesScreen(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.rentals,
      page: () => const RentalScreen(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.more,
      page: () => const MoreScreen(),
    ),
  ];
}
