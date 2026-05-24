import 'package:automanager/feature/auto_manager/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/utils/utils.dart';
import '../../../../../core/presentation/widgets/widgets.dart';
import '../../../data/model/model.dart';
import 'mobile_add_sales_screen.dart';
import 'web_add_sales_screen.dart';

class AddSaleScreen extends GetView<SalesController> {
  const AddSaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.loadDependencies();
    final bool isWide = MediaQuery.of(context).size.width >= 768;

    return isWide
        ? WebAddSaleModal(controller: controller)
        : MobileAddSaleScreen(controller: controller);
  }

}
