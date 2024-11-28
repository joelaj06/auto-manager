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
    GetPage<AppRoutes>(
      name: AppRoutes.signup,
      page: () => const SignUpScreen(),
      binding: SignUpBindings(),
    ),
    GetPage<AppRoutes>(
        name: AppRoutes.base,
        page: () => const BaseScreen(),
        bindings: <Bindings>[
          DashboardBindings(),
          SalesBindings(),
          ExpenseBindings(),
          RentalBindings(),
        ]),
    GetPage<AppRoutes>(
      name: AppRoutes.addCompany,
      page: () => const AddCompanyScreen(),
      binding: CompanyBindings(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.dashboard,
      page: () => const DashboardScreen(),
      binding: DashboardBindings(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.sales,
      page: () => const SalesScreen(),
      binding: SalesBindings(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.expenses,
      page: () => const ExpensesScreen(),
      binding: ExpenseBindings(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.rentals,
      page: () => const RentalScreen(),
      binding: RentalBindings(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.more,
      page: () => const MoreScreen(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.addSale,
      page: () => const AddSaleScreen(),
      binding: SalesBindings(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.addExpense,
      page: () => const AddExpenseScreen(),
      binding: ExpenseBindings(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.addRental,
      page: () => const AddRentalScreen(),
      binding: RentalBindings(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.profile,
      page: () => const ProfileScreen(),
      binding: ProfileBindings(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.drivers,
      page: () => const DriversScreen(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.customers,
      page: () => const CustomerScreen(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.vehicle,
      page: () => const VehicleScreen(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.userAccounts,
      page: () => const UserAccountScreen(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.updateCompany,
      page: () => const UpdateCompanyScreen(),
      binding: CompanyBindings(),
    ),
  ];
}
