import 'package:flutter/cupertino.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';


List<IconData> mobileNavIcons = <IconData>[
  //if (UserPermissions.validator.canViewDashboard)
    Iconsax.chart,
  Iconsax.moneys,
  Iconsax.wallet_minus,
 // if (UserPermissions.validator.canViewRentals)
    Iconsax.key,
  Iconsax.menu,
];

List<String> mobileNavTexts = <String>[
 // if (UserPermissions.validator.canViewDashboard)
  'Dashboard',
  'Sales',
  'Expenses',
 // if (UserPermissions.validator.canViewRentals)
    'Rentals',
  'More',
];List<IconData> tabNavIcons = <IconData>[
  //if (UserPermissions.validator.canViewDashboard)
    Iconsax.chart,
  Iconsax.moneys,
  Iconsax.wallet_minus,
 // if (UserPermissions.validator.canViewRentals)
    Iconsax.key,
  IconlyLight.user_1,
  IconlyLight.discovery,
  Ionicons.speedometer,
  IconlyLight.user,
  IconlyLight.work,
  IconlyLight.lock,
];

List<String> tabNavTexts = <String>[
 // if (UserPermissions.validator.canViewDashboard)
  'Dashboard',
  'Sales',
  'Expenses',
 // if (UserPermissions.validator.canViewRentals)
    'Rentals',
  'Customers',
  'Drivers',
  'Vehicles',
  'Users',
  'Company',
  'Roles'
];