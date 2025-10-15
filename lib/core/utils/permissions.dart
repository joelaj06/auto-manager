class UserPermissions {
  const UserPermissions._();

  static Validator validator = Validator(<String>[]);

  /// Initialize the validator with user permissions
  static void initializeValidator(List<String> userPermissions) {
    validator = Validator(userPermissions);
  }

  static const Map<String, String> _values = <String, String>{
    'CREATE_ROLE': 'create:role',
    'VIEW_ROLE': 'view:role',
    'UPDATE_ROLE': 'update:role',
    'DELETE_ROLE': 'delete:role',
    'VIEW_ROLES': 'view:roles',
    'CREATE_PERMISSION': 'create:permission',
    'VIEW_PERMISSION': 'view:permission',
    'VIEW_PERMISSIONS': 'view:permissions',
    'UPDATE_PERMISSION': 'update:permission',
    'DELETE_PERMISSION': 'delete:permission',
    'CREATE_USER': 'create:user',
    'VIEW_USER': 'view:user',
    'UPDATE_USER': 'update:user',
    'DELETE_USER': 'delete:user',
    'VIEW_USERS': 'view:users',
    'CREATE_COMPANY': 'create:company',
    'VIEW_COMPANY': 'view:company',
    'UPDATE_COMPANY': 'update:company',
    'DELETE_COMPANY': 'delete:company',
    'VIEW_COMPANIES': 'view:companies',
    'CREATE_VEHICLE': 'create:vehicle',
    'VIEW_VEHICLE': 'view:vehicle',
    'UPDATE_VEHICLE': 'update:vehicle',
    'DELETE_VEHICLE': 'delete:vehicle',
    'VIEW_VEHICLES': 'view:vehicles',
    'CREATE_DRIVER': 'create:driver',
    'VIEW_DRIVER': 'view:driver',
    'UPDATE_DRIVER': 'update:driver',
    'DELETE_DRIVER': 'delete:driver',
    'VIEW_DRIVERS': 'view:drivers',
    'CREATE_SALE': 'create:sales',
    'VIEW_SALE': 'view:sale',
    'UPDATE_SALE': 'update:sale',
    'DELETE_SALE': 'delete:sale',
    'VIEW_SALES': 'view:sales',
    'VIEW_OTHERS_SALES': 'view:others-sales',
    'VIEW_SALES_FILTER_BY_DRIVER': 'view:sales-filter-by-driver',
    'VIEW_SALES_FILTER_BY_VEHICLE': 'view:sales-filter-by-vehicle',
    'CREATE_EXPENSE_CATEGORY': 'create:expense-category',
    'VIEW_EXPENSE_CATEGORY': 'view:expense-category',
    'UPDATE_EXPENSE_CATEGORY': 'update:expense-category',
    'DELETE_EXPENSE_CATEGORY': 'delete:expense-category',
    'VIEW_EXPENSE_CATEGORIES': 'view:expense-categories',
    'CREATE_EXPENSE': 'create:expense',
    'VIEW_EXPENSE': 'view:expense',
    'UPDATE_EXPENSE': 'update:expense',
    'DELETE_EXPENSE': 'delete:expense',
    'VIEW_EXPENSES': 'view:expenses',
    'VIEW_OTHERS_EXPENSES': 'view:others-expenses',
    'VIEW_EXPENSES_FILTER_BY_CATEGORY': 'view:expenses-filter-by-category',
    'VIEW_EXPENSES_FILTER_BY_DRIVER': 'view:expenses-filter-by-driver',
    'VIEW_EXPENSES_FILTER_BY_VEHICLE': 'view:expenses-filter-by-vehicle',
    'CREATE_RENTAL': 'create:rental',
    'VIEW_RENTAL': 'view:rental',
    'UPDATE_RENTAL': 'update:rental',
    'DELETE_RENTAL': 'delete:rental',
    'VIEW_RENTALS': 'view:rentals',
    'CREATE_RENTAL_EXTENSION': 'create:rental-extension',
    'VIEW_RENTAL_EXTENSION': 'view:rental-extension',
    'UPDATE_RENTAL_EXTENSION': 'update:rental-extension',
    'DELETE_RENTAL_EXTENSION': 'delete:rental-extension',
    'VIEW_RENTAL_EXTENSIONS': 'view:rental-extensions',
    'CREATE_CUSTOMER': 'create:customer',
    'VIEW_CUSTOMER': 'view:customer',
    'UPDATE_CUSTOMER': 'update:customer',
    'DELETE_CUSTOMER': 'delete:customer',
    'VIEW_CUSTOMERS': 'view:customers',
    'VIEW_DASHBOARD': 'view:dashboard',
    'VIEW_DASHBOARD_SALES': 'view:dashboard-sales',
    'VIEW_DASHBOARD_CUSTOMERS': 'view:dashboard-customers',
    'VIEW_DASHBOARD_DRIVERS': 'view:dashboard-drivers',
    'VIEW_DASHBOARD_VEHICLES': 'view:dashboard-vehicles',
    'VIEW_DASHBOARD_EXPENSES': 'view:dashboard-expenses',
    'VIEW_DASHBOARD_RENTALS': 'view:dashboard-rentals',
    'VIEW_DASHBOARD_REVENUE': 'view:dashboard-revenue',
    'VIEW_DASHBOARD_WEEKLY_SALES': 'view:dashboard-weekly-sales',
    'VIEW_DASHBOARD_SUMMARY': 'view:dashboard-summary',
  };

  // Getters for all permissions
  static String get createRole => _values['CREATE_ROLE']!;
  static String get viewRole => _values['VIEW_ROLE']!;
  static String get updateRole => _values['UPDATE_ROLE']!;
  static String get deleteRole => _values['DELETE_ROLE']!;
  static String get viewRoles => _values['VIEW_ROLES']!;
  static String get createPermission => _values['CREATE_PERMISSION']!;
  static String get viewPermission => _values['VIEW_PERMISSION']!;
  static String get viewPermissions => _values['VIEW_PERMISSIONS']!;
  static String get updatePermission => _values['UPDATE_PERMISSION']!;
  static String get deletePermission => _values['DELETE_PERMISSION']!;
  static String get createUser => _values['CREATE_USER']!;
  static String get viewUser => _values['VIEW_USER']!;
  static String get updateUser => _values['UPDATE_USER']!;
  static String get deleteUser => _values['DELETE_USER']!;
  static String get viewUsers => _values['VIEW_USERS']!;
  static String get createCompany => _values['CREATE_COMPANY']!;
  static String get viewCompany => _values['VIEW_COMPANY']!;
  static String get updateCompany => _values['UPDATE_COMPANY']!;
  static String get deleteCompany => _values['DELETE_COMPANY']!;
  static String get viewCompanies => _values['VIEW_COMPANIES']!;
  static String get createVehicle => _values['CREATE_VEHICLE']!;
  static String get viewVehicle => _values['VIEW_VEHICLE']!;
  static String get updateVehicle => _values['UPDATE_VEHICLE']!;
  static String get deleteVehicle => _values['DELETE_VEHICLE']!;
  static String get viewVehicles => _values['VIEW_VEHICLES']!;
  static String get createDriver => _values['CREATE_DRIVER']!;
  static String get viewDriver => _values['VIEW_DRIVER']!;
  static String get updateDriver => _values['UPDATE_DRIVER']!;
  static String get deleteDriver => _values['DELETE_DRIVER']!;
  static String get viewDrivers => _values['VIEW_DRIVERS']!;
  static String get createSale => _values['CREATE_SALE']!;
  static String get viewSale => _values['VIEW_SALE']!;
  static String get updateSale => _values['UPDATE_SALE']!;
  static String get deleteSale => _values['DELETE_SALE']!;
  static String get viewSales => _values['VIEW_SALES']!;
  static String get viewOthersSales => _values['VIEW_OTHERS_SALES']!;
  static String get viewSalesFilterByDriver => _values['VIEW_SALES_FILTER_BY_DRIVER']!;
  static String get viewSalesFilterByVehicle => _values['VIEW_SALES_FILTER_BY_VEHICLE']!;
  static String get createExpenseCategory => _values['CREATE_EXPENSE_CATEGORY']!;
  static String get viewExpenseCategory => _values['VIEW_EXPENSE_CATEGORY']!;
  static String get updateExpenseCategory => _values['UPDATE_EXPENSE_CATEGORY']!;
  static String get deleteExpenseCategory => _values['DELETE_EXPENSE_CATEGORY']!;
  static String get viewExpenseCategories => _values['VIEW_EXPENSE_CATEGORIES']!;
  static String get createExpense => _values['CREATE_EXPENSE']!;
  static String get viewExpense => _values['VIEW_EXPENSE']!;
  static String get updateExpense => _values['UPDATE_EXPENSE']!;
  static String get deleteExpense => _values['DELETE_EXPENSE']!;
  static String get viewExpenses => _values['VIEW_EXPENSES']!;
  static String get viewOthersExpenses => _values['VIEW_OTHERS_EXPENSES']!;
  static String get viewExpensesFilterByCategory => _values['VIEW_EXPENSES_FILTER_BY_CATEGORY']!;
  static String get viewExpensesFilterByDriver => _values['VIEW_EXPENSES_FILTER_BY_DRIVER']!;
  static String get viewExpensesFilterByVehicle => _values['VIEW_EXPENSES_FILTER_BY_VEHICLE']!;
  static String get createRental => _values['CREATE_RENTAL']!;
  static String get viewRental => _values['VIEW_RENTAL']!;
  static String get updateRental => _values['UPDATE_RENTAL']!;
  static String get deleteRental => _values['DELETE_RENTAL']!;
  static String get viewRentals => _values['VIEW_RENTALS']!;
  static String get createRentalExtension => _values['CREATE_RENTAL_EXTENSION']!;
  static String get viewRentalExtension => _values['VIEW_RENTAL_EXTENSION']!;
  static String get updateRentalExtension => _values['UPDATE_RENTAL_EXTENSION']!;
  static String get deleteRentalExtension => _values['DELETE_RENTAL_EXTENSION']!;
  static String get viewRentalExtensions => _values['VIEW_RENTAL_EXTENSIONS']!;
  static String get createCustomer => _values['CREATE_CUSTOMER']!;
  static String get viewCustomer => _values['VIEW_CUSTOMER']!;
  static String get updateCustomer => _values['UPDATE_CUSTOMER']!;
  static String get deleteCustomer => _values['DELETE_CUSTOMER']!;
  static String get viewCustomers => _values['VIEW_CUSTOMERS']!;
  static String get viewDashboard => _values['VIEW_DASHBOARD']!;
  static String get viewDashboardSales => _values['VIEW_DASHBOARD_SALES']!;
  static String get viewDashboardCustomers => _values['VIEW_DASHBOARD_CUSTOMERS']!;
  static String get viewDashboardDrivers => _values['VIEW_DASHBOARD_DRIVERS']!;
  static String get viewDashboardVehicles => _values['VIEW_DASHBOARD_VEHICLES']!;
  static String get viewDashboardExpenses => _values['VIEW_DASHBOARD_EXPENSES']!;
  static String get viewDashboardRentals => _values['VIEW_DASHBOARD_RENTALS']!;
  static String get viewDashboardRevenue => _values['VIEW_DASHBOARD_REVENUE']!;
  static String get viewDashboardWeeklySales => _values['VIEW_DASHBOARD_WEEKLY_SALES']!;
  static String get viewDashboardSummary => _values['VIEW_DASHBOARD_SUMMARY']!;



  //categorized permissions

 static final List<CategorizedPermissions> categorizedPermissions = <CategorizedPermissions>[
    CategorizedPermissions(
      title: 'Sale',
      permissionActions: <CategorizedPermissionActions>[
        CategorizedPermissionActions(action: 'Create', permission: createSale),
        CategorizedPermissionActions(action: 'View', permission: viewSale),
        CategorizedPermissionActions(action: 'Update', permission: updateSale),
        CategorizedPermissionActions(action: 'Delete', permission: deleteSale),
        CategorizedPermissionActions(action: 'View Others', permission: viewOthersSales),
      ],
    ),
    CategorizedPermissions(
      title: 'Role',
      permissionActions: <CategorizedPermissionActions>[
        CategorizedPermissionActions(action: 'Create', permission: createRole),
        CategorizedPermissionActions(action: 'View', permission: viewRole),
        CategorizedPermissionActions(action: 'Update', permission: updateRole),
        CategorizedPermissionActions(action: 'Delete', permission: deleteRole),
      ],
    ),
    CategorizedPermissions(
      title: 'Permission',
      permissionActions: <CategorizedPermissionActions>[
        CategorizedPermissionActions(action: 'Create', permission: createPermission),
        CategorizedPermissionActions(action: 'View', permission: viewPermission),
        CategorizedPermissionActions(action: 'Update', permission: updatePermission),
        CategorizedPermissionActions(action: 'Delete', permission: deletePermission),
      ],
    ),
    CategorizedPermissions(
      title: 'User',
      permissionActions: <CategorizedPermissionActions>[
        CategorizedPermissionActions(action: 'Create', permission: createUser),
        CategorizedPermissionActions(action: 'View', permission: viewUser),
        CategorizedPermissionActions(action: 'Update', permission: updateUser),
        CategorizedPermissionActions(action: 'Delete', permission: deleteUser),
      ],
    ),
    CategorizedPermissions(
      title: 'Company',
      permissionActions: <CategorizedPermissionActions>[
        CategorizedPermissionActions(action: 'Create', permission: createCompany),
        CategorizedPermissionActions(action: 'View', permission: viewCompany),
        CategorizedPermissionActions(action: 'Update', permission: updateCompany),
        CategorizedPermissionActions(action: 'Delete', permission: deleteCompany),
      ],
    ),
    CategorizedPermissions(
      title: 'Vehicle',
      permissionActions: <CategorizedPermissionActions>[
        CategorizedPermissionActions(action: 'Create', permission: createVehicle),
        CategorizedPermissionActions(action: 'View', permission: viewVehicle),
        CategorizedPermissionActions(action: 'Update', permission: updateVehicle),
        CategorizedPermissionActions(action: 'Delete', permission: deleteVehicle),
      ],
    ),
    CategorizedPermissions(
      title: 'Driver',
      permissionActions: <CategorizedPermissionActions>[
        CategorizedPermissionActions(action: 'Create', permission: createDriver),
        CategorizedPermissionActions(action: 'View', permission: viewDriver),
        CategorizedPermissionActions(action: 'Update', permission: updateDriver),
        CategorizedPermissionActions(action: 'Delete', permission: deleteDriver),
      ],
    ),
    CategorizedPermissions(
      title: 'Expense',
      permissionActions: <CategorizedPermissionActions>[
        CategorizedPermissionActions(action: 'Create', permission: createExpense),
        CategorizedPermissionActions(action: 'View', permission: viewExpense),
        CategorizedPermissionActions(action: 'Update', permission: updateExpense),
        CategorizedPermissionActions(action: 'Delete', permission: deleteExpense),
        CategorizedPermissionActions(action: 'View Others', permission: viewOthersExpenses),
      ],
    ),
    CategorizedPermissions(
      title: 'Rental',
      permissionActions: <CategorizedPermissionActions>[
        CategorizedPermissionActions(action: 'Create', permission: createRental),
        CategorizedPermissionActions(action: 'View', permission: viewRental),
        CategorizedPermissionActions(action: 'Update', permission: updateRental),
        CategorizedPermissionActions(action: 'Delete', permission: deleteRental),
        CategorizedPermissionActions(action: 'Extend', permission: createRentalExtension),
        CategorizedPermissionActions(action: 'Delete Extension', permission: deleteRentalExtension),
      ],
    ),
    CategorizedPermissions(
      title: 'Customer',
      permissionActions: <CategorizedPermissionActions>[
        CategorizedPermissionActions(action: 'Create', permission: createCustomer),
        CategorizedPermissionActions(action: 'View', permission: viewCustomer),
        CategorizedPermissionActions(action: 'Update', permission: updateCustomer),
        CategorizedPermissionActions(action: 'Delete', permission: deleteCustomer),
      ],
    ),
    CategorizedPermissions(
      title: 'Dashboard',
      permissionActions: <CategorizedPermissionActions>[
        CategorizedPermissionActions(action: 'View', permission: viewDashboard),
      /*  CategorizedPermissionActions(action: 'View Sales', permission: viewDashboardSales),
        CategorizedPermissionActions(action: 'View Customers', permission: viewDashboardCustomers),
        CategorizedPermissionActions(action: 'View Drivers', permission: viewDashboardDrivers),
        CategorizedPermissionActions(action: 'View Vehicles', permission: viewDashboardVehicles),
        CategorizedPermissionActions(action: 'View Expenses', permission: viewDashboardExpenses),
        CategorizedPermissionActions(action: 'View Rentals', permission: viewDashboardRentals),
        CategorizedPermissionActions(action: 'View Revenue', permission: viewDashboardRevenue),*/
      ],
    ),
  ];



}

class CategorizedPermissions{

  CategorizedPermissions({required this.title, required this.permissionActions});
  String title;
  List<CategorizedPermissionActions> permissionActions;
}


class CategorizedPermissionActions{

  CategorizedPermissionActions({required this.action, required this.permission});
  String action;
  String permission;
}

class Validator {

  Validator(this._userPermissions);
  final List<String> _userPermissions;

  bool can(String permission) {
    return _userPermissions.contains(permission);
  }

  // Role Permissions
  bool get canCreateRole => can(UserPermissions.createRole);
  bool get canViewRole => can(UserPermissions.viewRole);
  bool get canUpdateRole => can(UserPermissions.updateRole);
  bool get canDeleteRole => can(UserPermissions.deleteRole);
  bool get canViewRoles => can(UserPermissions.viewRoles);

  // Permission Management
  bool get canCreatePermission => can(UserPermissions.createPermission);
  bool get canViewPermission => can(UserPermissions.viewPermission);
  bool get canUpdatePermission => can(UserPermissions.updatePermission);
  bool get canDeletePermission => can(UserPermissions.deletePermission);
  bool get canViewPermissions => can(UserPermissions.viewPermissions);

  // User Permissions
  bool get canCreateUser => can(UserPermissions.createUser);
  bool get canViewUser => can(UserPermissions.viewUser);
  bool get canUpdateUser => can(UserPermissions.updateUser);
  bool get canDeleteUser => can(UserPermissions.deleteUser);
  bool get canViewUsers => can(UserPermissions.viewUsers);

  // Company Permissions
  bool get canCreateCompany => can(UserPermissions.createCompany);
  bool get canViewCompany => can(UserPermissions.viewCompany);
  bool get canUpdateCompany => can(UserPermissions.updateCompany);
  bool get canDeleteCompany => can(UserPermissions.deleteCompany);
  bool get canViewCompanies => can(UserPermissions.viewCompanies);

  // Vehicle Permissions
  bool get canCreateVehicle => can(UserPermissions.createVehicle);
  bool get canViewVehicle => can(UserPermissions.viewVehicle);
  bool get canUpdateVehicle => can(UserPermissions.updateVehicle);
  bool get canDeleteVehicle => can(UserPermissions.deleteVehicle);
  bool get canViewVehicles => can(UserPermissions.viewVehicles);

  // Driver Permissions
  bool get canCreateDriver => can(UserPermissions.createDriver);
  bool get canViewDriver => can(UserPermissions.viewDriver);
  bool get canUpdateDriver => can(UserPermissions.updateDriver);
  bool get canDeleteDriver => can(UserPermissions.deleteDriver);
  bool get canViewDrivers => can(UserPermissions.viewDrivers);

  // Sales Permissions
  bool get canCreateSale => can(UserPermissions.createSale);
  bool get canViewSale => can(UserPermissions.viewSale);
  bool get canUpdateSale => can(UserPermissions.updateSale);
  bool get canDeleteSale => can(UserPermissions.deleteSale);
  bool get canViewSales => can(UserPermissions.viewSales);
  bool get canViewOtherSales => can(UserPermissions.viewOthersSales);

  // Expense Permissions
  bool get canCreateExpense => can(UserPermissions.createExpense);
  bool get canViewExpense => can(UserPermissions.viewExpense);
  bool get canUpdateExpense => can(UserPermissions.updateExpense);
  bool get canDeleteExpense => can(UserPermissions.deleteExpense);
  bool get canViewExpenses => can(UserPermissions.viewExpenses);
  bool get canViewOtherExpenses => can(UserPermissions.viewOthersExpenses);

  // Rental Permissions
  bool get canCreateRental => can(UserPermissions.createRental);
  bool get canViewRental => can(UserPermissions.viewRental);
  bool get canUpdateRental => can(UserPermissions.updateRental);
  bool get canDeleteRental => can(UserPermissions.deleteRental);
  bool get canViewRentals => can(UserPermissions.viewRentals);
  bool get canCreateRentalExtension => can(UserPermissions.createRentalExtension);
  bool get canDeleteRentalExtension => can(UserPermissions.createRentalExtension);

  // Customer Permissions
  bool get canCreateCustomer => can(UserPermissions.createCustomer);
  bool get canViewCustomer => can(UserPermissions.viewCustomer);
  bool get canUpdateCustomer => can(UserPermissions.updateCustomer);
  bool get canDeleteCustomer => can(UserPermissions.deleteCustomer);
  bool get canViewCustomers => can(UserPermissions.viewCustomers);

  // Dashboard Permissions
  bool get canViewDashboard => can(UserPermissions.viewDashboard);
  bool get canViewDashboardSales => can(UserPermissions.viewDashboardSales);
  bool get canViewDashboardCustomers => can(UserPermissions.viewDashboardCustomers);
  bool get canViewDashboardDrivers => can(UserPermissions.viewDashboardDrivers);
  bool get canViewDashboardVehicles => can(UserPermissions.viewDashboardVehicles);
  bool get canViewDashboardExpenses => can(UserPermissions.viewDashboardExpenses);
  bool get canViewDashboardRentals => can(UserPermissions.viewDashboardRentals);
  bool get canViewDashboardRevenue => can(UserPermissions.viewDashboardRevenue);
  bool get canViewDashboardWeeklySales =>
      can(UserPermissions.viewDashboardWeeklySales);
  bool get canViewDashboardSummary => can(UserPermissions.viewDashboardSummary);




}

