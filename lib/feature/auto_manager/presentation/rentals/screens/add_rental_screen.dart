import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../arguments/add_rental_argument.dart';
import '../getx/rental_controller.dart';
import 'mobile_add_rental_screen.dart';
import 'web_add_rental_screen.dart';

class AddRentalScreen extends GetView<RentalController> {
  const AddRentalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.fetchAllVehicles();
    final AddRentalArgument? args = Get.arguments as AddRentalArgument?;

    controller.clearFields();
    if (args != null) {
      controller.getRentalDataFromArgs(args.rental);
    }

    final bool isWide = MediaQuery.of(context).size.width >= 768;

    return isWide
        ? WebAddRentalModal(controller: controller, args: args)
        : MobileAddRentalScreen(controller: controller, args: args);
  }
}
