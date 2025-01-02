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
          MoreBindings(),
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
      binding: MoreBindings(),
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
      binding: DriverBindings(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.customers,
      page: () => const CustomerScreen(),
      binding: CustomerBindings(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.vehicle,
      page: () => const VehicleScreen(),
      binding: VehicleBindings(),
    ), GetPage<AppRoutes>(
      name: AppRoutes.addVehicle,
      page: () => const AddVehicleScreen(),
      binding: VehicleBindings(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.userAccounts,
      page: () => const UserAccountScreen(),
      binding: UserAccountBindings(),
    ), GetPage<AppRoutes>(
      name: AppRoutes.addUser,
      page: () => const AddUserScreen(),
      binding: UserAccountBindings(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.updateCompany,
      page: () => const UpdateCompanyScreen(),
      binding: CompanyBindings(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.addDriver,
      page: () => const AddDriverScreen(),
      binding: DriverBindings(),
    ),GetPage<AppRoutes>(
      name: AppRoutes.addCustomer,
      page: () => const AddCustomerScreen(),
      binding: CustomerBindings(),
    ),GetPage<AppRoutes>(
      name: AppRoutes.passwordReset,
      page: () => const PasswordResetScreen(),
      binding: LoginBindings(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.role,
      page: () => const RoleScreen(),
      binding: RoleBindings(),
    ),GetPage<AppRoutes>(
      name: AppRoutes.addRole,
      page: () => const AddRoleScreen(),
      binding: RoleBindings(),
    ),
  ];
}
