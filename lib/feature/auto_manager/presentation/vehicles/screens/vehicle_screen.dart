import 'package:automanager/core/presentation/theme/app_theme.dart';
import 'package:automanager/feature/auto_manager/presentation/presentation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/presentation/utils/utils.dart';
import '../../../../../core/presentation/widgets/widgets.dart';
import '../../../data/model/response/vehicle/vehicle_model.dart';

class VehicleScreen extends GetView<VehicleController> {
  const VehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
              'Vehicles${controller.totalCount.value == 0 ? '' : '(${controller.totalCount.value})'}'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.navigateToAddVehicleScreen,
        child: const Icon(IconlyLight.plus),
      ),
      body: Column(
        children: <Widget>[
          _buildDriverSearchField(context),
          Expanded(
            child: _buildDriversList(context),
          ),
        ],
      ),
    );
  }

  Widget _buildDriverSearchField(BuildContext context) {
    return Padding(
      padding: AppPaddings.mA,
      child: AppTextInputField(
        onChanged: controller.onSearchFieldInputChanged,
        hintText: 'Search Vehicle',
        textInputAction: TextInputAction.search,
        onFieldSubmitted: (_) {
          controller.onSearchQuerySubmitted(); // Call your search function
        },
        suffixIcon: GestureDetector(
          onTap: () {
            controller.onSearchQuerySubmitted();
          },
          child: const Icon(
            IconlyLight.search,
          ),
        ),
      ),
    );
  }

  Widget _buildDriversList(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return Future<void>.sync(() => controller.pagingController.refresh());
      },
      child: PagedListView<int, Vehicle>(
          pagingController: controller.pagingController,
          builderDelegate: PagedChildBuilderDelegate<Vehicle>(
            itemBuilder: (BuildContext context, Vehicle vehicle, int index) {
              return Slidable(
                endActionPane: ActionPane(
                  motion: const DrawerMotion(),
                  children: <Widget>[
                    SlidableAction(
                      backgroundColor: context.colorScheme.background,
                      icon: IconlyLight.edit,
                      label: 'Edit',
                      onPressed: (BuildContext context) {
                        controller.navigateToUpdateVehicleScreen(vehicle);
                      },
                    ),
                    SlidableAction(
                      backgroundColor: context.colorScheme.background,
                      foregroundColor: Colors.red,
                      icon: IconlyLight.delete,
                      label: 'Delete',
                      onPressed: (BuildContext context) async {

                        await AppDialogs.showDialogWithButtons(
                          context,
                          onConfirmPressed: () =>
                              controller.deleteTheVehicle(vehicle.id!),
                          content: const Text(
                            'Are you sure you want to delete this vehicle?',
                            textAlign: TextAlign.center,
                          ),
                          confirmText: 'Delete',
                        );
                      },
                    ),
                  ],
                ),
                child: _buildVehiclesListTile(context, index, vehicle),
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
          shrinkWrap: true,
      ),
    );
  }

  Widget _buildVehiclesListTile(
      BuildContext context, int index, Vehicle vehicle) {
    return Padding(
      padding: AppPaddings.mH,
      child: Column(
        children: <Widget>[
          ListTile(
            onTap: () {
              showModalBottomSheet<dynamic>(
                context: context,
                builder: (BuildContext context) => SizedBox(
                  child: _buildVehicleDetailModal(context, vehicle),
                ),
              );
            },
            title: Text(
              '${vehicle.make ?? ''} ${vehicle.model ?? ''} ${vehicle.color ?? ''}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Chip(
                      label: Text(vehicle.licensePlate ?? ''),
                      labelPadding: EdgeInsets.zero,
                      visualDensity: const VisualDensity(
                        vertical: -4,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text('${vehicle.year ?? 'year'}'),
                  ],
                ),
                const AppSpacing(v: 5),
                Container(
                  padding: AppPaddings.sA,
                  decoration: BoxDecoration(
                    color: vehicle.rentalStatus == true
                        ? Colors.deepOrange
                        : Colors.green.shade900,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    vehicle.rentalStatus == true ? 'Rented' : 'Available',
                    style: const TextStyle(fontSize: 12,
                    color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            trailing: CachedNetworkImage(
                imageUrl: vehicle.image ?? '',
                placeholder: (BuildContext context, String url) =>
                    Image.asset(AssetImages.speedometer),
                errorWidget:
                    (BuildContext context, String url, dynamic error) =>
                        const Icon(Icons.error),
                imageBuilder: (BuildContext context,
                        ImageProvider<Object> imageProvider) =>
                    Container(
                      width: 100.0,
                      //  height: 100.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: AppBorderRadius.card,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )),
          ),
          const Divider(),
        ],
      ),
    );
  }

  Widget _buildVehicleDetailModal(
    BuildContext context,
    Vehicle vehicle,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            ModalListCard(title: 'Make', value: vehicle.make ?? '--'),
            ModalListCard(
              title: 'Model',
              value: vehicle.model ?? '--',
            ),
            ModalListCard(
              title: 'Year',
              value: '${vehicle.year ?? '--'}',
            ),
            ModalListCard(
              title: 'Color',
              value: vehicle.color ?? '--',
            ),
            ModalListCard(
              title: 'Plate Number',
              value: vehicle.licensePlate ?? '--',
            ),
            ModalListCard(
              title: 'Status',
              value: vehicle.rentalStatus == true ? 'Rented' : 'Available',
            ),
          ],
        ),
      ),
    );
  }
}
