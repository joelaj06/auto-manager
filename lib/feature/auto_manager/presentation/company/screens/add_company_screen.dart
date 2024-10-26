import 'package:automanager/feature/auto_manager/presentation/company/company.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class AddCompanyScreen extends GetView<CompanyController> {
  const AddCompanyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Add Company'),
      ),
    );
  }
}
