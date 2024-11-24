import 'package:automanager/core/presentation/theme/app_theme.dart';
import 'package:automanager/feature/auto_manager/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/presentation/utils/utils.dart';
import '../../../../../core/presentation/widgets/exception_indicators/exceptions.dart';
import '../../../../../core/utils/utils.dart';
import '../../../data/model/model.dart';

class RentalScreen extends GetView<RentalController> {
  const RentalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: controller.navigateToAddRentalScreen,
        child: const Icon(IconlyLight.plus),
      ),
      appBar: AppBar(
        title: Obx(
          () => Text(
              'Rentals${controller.totalCount.value == 0 ? '' : '(${controller.totalCount.value})'}'),
        ),
        leading: IconButton(
          onPressed: () {
            controller.onDateRangeSelected(context);
          },
          icon: const Icon(
            IconlyLight.calendar,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: AppPaddings.mH,
              child: SizedBox(
                height: context.height * 0.09,
                child: _buildTotalAmountCard(context),
              ),
            ),
          ),
          Expanded(
            child: _buildRentalList(context),
          ),
        ],
      ),
    );
  }

  Widget _buildRentalList(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildTableHeader(context),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () {
              controller.endDate(DateTime.now());
              return Future<void>.sync(
                  () => controller.pagingController.refresh());
            },
            child: PagedListView<int, Rental>(
                pagingController: controller.pagingController,
                builderDelegate: PagedChildBuilderDelegate<Rental>(
                  itemBuilder:
                      (BuildContext context, Rental rental, int index) {
                    return Slidable(
                      endActionPane: ActionPane(
                        motion: const DrawerMotion(),
                        children: <Widget>[
                          SlidableAction(
                            backgroundColor: context.colorScheme.background,
                            icon: IconlyLight.edit,
                            label: 'Edit',
                            onPressed: (BuildContext context) {
                              controller.navigateToUpdateRentalScreen(rental);
                            },
                          ),
                          SlidableAction(
                            backgroundColor: context.colorScheme.background,
                            foregroundColor: Colors.red,
                            icon: IconlyLight.delete,
                            label: 'Delete',
                            onPressed: (BuildContext context) {
                              controller.deleteTheRental(rental);
                            },
                          ),
                        ],
                      ),
                      child: _buildRentalsListTile(context, index, rental),
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
          ),
        ),
      ],
    );
  }

  Widget _buildSaleDetailModal(
    BuildContext context,
    Rental rental,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            ModalListCard(title: 'Rental ID', value: rental.rentalCode ?? '--'),
            ModalListCard(
                title: 'Date',
                value: DataFormatter.formatDateToString(rental.date ?? '')),
            ModalListCard(
              title: 'Customer',
              value: rental.renter?.name ?? '--',
            ),
            ModalListCard(
              title: 'Days',
              value: controller.getNumberOfDays(
                  DateTime.parse(rental.startDate!),
                  DateTime.parse(rental.endDate!)),
            ),
            ModalListCard(
              title: 'Amount Paid',
              value: DataFormatter.getLocalCurrencyFormatter(context)
                  .format(rental.amountPaid ?? 0),
            ),
            ModalListCard(
              title: 'Total Amount',
              value: DataFormatter.getLocalCurrencyFormatter(context)
                  .format(rental.totalAmount ?? 0),
            ),
            ModalListCard(
              title: 'Balance',
              value: DataFormatter.getLocalCurrencyFormatter(context)
                  .format(rental.balance ?? 0),
            ),
            ModalListCard(
              title: 'Vehicle',
              value:
                  ' ${rental.vehicle?.make ?? ''} ${rental.vehicle?.model ?? ''} ${rental.vehicle?.color ?? ''} '
                  '${rental.vehicle?.year ?? ''}',
            ),
            ModalListCard(
                title: 'Created By',
                value: '${rental.createdBy?.firstName ?? ''} '
                    '${rental.createdBy?.lastName ?? ''}'),
            ModalListCard(
              title: 'Extended',
              value: (rental.extensions ?? <RentalExtension>[]).isNotEmpty
                  ? 'Yes'
                  : 'No',
            ),
            ModalListCard(
              title: 'Purpose',
              value: rental.purpose ?? '--',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRentalsListTile(BuildContext context, int index, Rental rental) {
    return InkWell(
      onTap: () {
        showModalBottomSheet<dynamic>(
          context: context,
          builder: (BuildContext context) => SizedBox(
            child: _buildSaleDetailModal(context, rental),
          ),
        );
      },
      child: Padding(
        padding: AppPaddings.mH,
        child: Column(
          children: <Widget>[
            Padding(
              padding: AppPaddings.lV,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          rental.rentalCode,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(DataFormatter.formatDate(rental.date ?? '')),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(
                          '${rental.vehicle?.model ?? ''} ${rental.vehicle?.make ?? ''} ${rental.vehicle?.color ?? ''} '
                          '${rental.vehicle?.year ?? ''}',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        rental.renter?.name ?? '',
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          (rental.totalAmount ?? 0).toStringAsFixed(2),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          (rental.amountPaid ?? 0).toStringAsFixed(2),
                          style: TextStyle(
                            color: (rental.balance ?? 0) < 0
                                ? Colors.red
                                : Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: context.colorScheme.outlineVariant,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text('ID'),
            ),
            Expanded(
              child: Center(
                child: Text('Vehicle'),
              ),
            ),
            Expanded(
              child: Center(
                child: Text('Customer'),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text('Total/Paid'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalAmountCard(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Obx(
          () => Text(
            DataFormatter.getLocalCurrencyFormatter(context).format(
              controller.totalAmount.value,
            ),
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Chip(
          backgroundColor: context.colorScheme.background,
          label: Obx(
            () => Text(
              controller.dateText.value,
            ),
          ),
        ),
      ],
    );
  }
}
