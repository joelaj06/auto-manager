import 'package:automanager/core/core.dart';
import 'package:flutter/cupertino.dart';

import '../../../feature/auto_manager/presentation/presentation.dart';

List<Widget> mobileNavPages = <Widget>[
 if (UserPermissions.validator.canViewDashboard) const DashboardScreen(),
  const SalesScreen(),
  const ExpensesScreen(),
  if (UserPermissions.validator.canViewRentals) const RentalScreen(),
  const MoreScreen(),
];