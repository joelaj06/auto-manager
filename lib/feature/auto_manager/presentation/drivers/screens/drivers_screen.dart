import 'package:automanager/core/core.dart';
import 'package:automanager/core/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/presentation/widgets/exception_indicators/exceptions.dart';
import '../../../data/model/response/driver/driver_model.dart';
import '../../sales/widgets/modal_list_card.dart';
import '../getx/driver_controller.dart';

class DriversScreen extends GetView<DriverController> {
  const DriversScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
              'Drivers${controller.totalCount.value == 0 ? '' : '(${controller.totalCount.value})'}'),
        ),
      ),
      body: SizedBox(
        child: _buildDriversList(context),
      ),
    );
  }

  Widget _buildDriversList(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return Future<void>.sync(() => controller.pagingController.refresh());
      },
      child: PagedListView<int, Driver>(
          pagingController: controller.pagingController,
          builderDelegate: PagedChildBuilderDelegate<Driver>(
            itemBuilder: (BuildContext context, Driver driver, int index) {
              return Slidable(
                endActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  children: <Widget>[
                    SlidableAction(
                      backgroundColor: context.colorScheme.background,
                      icon: IconlyLight.edit,
                      label: 'Edit',
                      onPressed: (BuildContext context) {
                        controller.navigateToUpdateDriverScreen(driver);
                      },
                    ),
                    SlidableAction(
                      backgroundColor: context.colorScheme.background,
                      foregroundColor: Colors.red,
                      icon: IconlyLight.delete,
                      label: 'Delete',
                      onPressed: (BuildContext context) {
                        controller.deleteTheDriver(driver);
                      },
                    ),
                  ],
                ),
                child: _buildRentalsListTile(context, index, driver),
              );
            },
            firstPageErrorIndicatorBuilder: (BuildContext context) =>
                ErrorIndicator(
              error: controller.pagingController.value.error as Failure,
              onTryAgain: () => controller.pagingController.refresh(),
            ),
            noItemsFoundIndicatorBuilder: (BuildContext context) =>
                const EmptyListIndicator(),
            newPageProgressIndicatorBuilder: (BuildContext context) =>
                const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            firstPageProgressIndicatorBuilder: (BuildContext context) =>
                const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
          shrinkWrap: true),
    );
  }

  Widget _buildRentalsListTile(BuildContext context, int index, Driver driver) {
    return Padding(
      padding: AppPaddings.mH,
      child: Column(
        children: <Widget>[
          ListTile(
            onTap: () {
              showModalBottomSheet<dynamic>(
                context: context,
                builder: (BuildContext context) => SizedBox(
                  child: _buildDriverDetailModal(context, driver),
                ),
              );
            },
            title: Text(
              '${driver.user.firstName} ${driver.user.lastName}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(driver.user.email ?? 'No Email'),
                Text(
                  driver.user.phone ?? 'No Phone',
                ),
              ],
            ),
            leading: const Icon(IconlyLight.profile),
          ),
          const Divider(),
        ],
      ),
    );
  }

  Widget _buildDriverDetailModal(
    BuildContext context,
    Driver driver,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            ModalListCard(
                title: 'First Name', value: driver.user.firstName ?? '--'),
            ModalListCard(
                title: 'Last Name', value: driver.user.lastName ?? '--'),
            ModalListCard(
              title: 'Email',
              value: driver.user.email ?? '--',
            ),
            ModalListCard(
              title: 'Phone',
              value: driver.user.phone ?? '--',
            ),
            ModalListCard(
              title: 'License',
              value: driver.licenseNumber ?? '--',
            ),
            ModalListCard(
              title: 'License Expiry',
              value: DataFormatter.formatDateToString(
                  driver.licenceExpiryDate ?? '--'),
            ),
            ModalListCard(
              title: 'Vehicle',
              value:
                  '${driver.vehicle?.make ?? ''} ${driver.vehicle?.model ?? ''} ${driver.vehicle?.color ?? ''} '
                  '${driver.vehicle?.year ?? ''}',
            ),
          ],
        ),
      ),
    );
  }
}
