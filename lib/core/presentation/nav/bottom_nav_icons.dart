import 'package:flutter/cupertino.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/permissions.dart';

List<IconData> mobileNavIcons = <IconData>[
  if (UserPermissions.validator.canViewDashboard) Iconsax.chart,
  Iconsax.moneys,
  Iconsax.wallet_minus,
  if (UserPermissions.validator.canViewRentals) Iconsax.key,
  Iconsax.menu,
];

List<String> mobileNavTexts = <String>[
  if (UserPermissions.validator.canViewDashboard) 'Dashboard',
  'Sales',
  'Expenses',
  if (UserPermissions.validator.canViewRentals) 'Rentals',
  'More',
];