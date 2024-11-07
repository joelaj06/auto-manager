import 'package:automanager/core/core.dart';
import 'package:automanager/core/presentation/theme/app_theme.dart';
import 'package:automanager/feature/auto_manager/presentation/sales/getx/sales_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../data/model/response/sale/sales_model.dart';

class SalesScreen extends GetView<SalesController> {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales(10)'),
        leading: IconButton(
          onPressed: () {
            controller.onDateRangeSelected(context);
          },
          icon: const Icon(IconlyLight.calendar),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(IconlyLight.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(IconlyLight.filter),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: AppPaddings.mH,
              child: SizedBox(
                height: context.height * 0.08,
                child: _buildTotalAmountCard(context),
              ),
            ),
          ),
          Expanded(
            child: _buildSalesList(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSalesList(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildTableHeader(context),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () =>
                Future<void>.sync(() => controller.pagingController.refresh()),
            child: PagedListView<int, Sale>(
                pagingController: controller.pagingController,
                builderDelegate: PagedChildBuilderDelegate<Sale>(
                  itemBuilder: (BuildContext context, Sale sale, int index) {
                    return _buildSalesListTile(context, index, sale);
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

  Widget _buildSalesListTile(BuildContext context, int index, Sale sale) {
    return Padding(
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
                        sale.saleId,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(DataFormatter.formatDate(sale.createdAt ?? '')),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(
                        '${sale.driver.user.firstName} ${sale.driver.user.lastName}',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '${sale.vehicle.model ?? ''} ${sale.vehicle.make ?? ''} ${sale.vehicle.color ?? ''} '
                        '${sale.vehicle.year ?? ''}',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      sale.amount.toStringAsFixed(2),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      padding: AppPaddings.mH.add(AppPaddings.sV),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.2),
                        borderRadius: AppBorderRadius.largeAll,
                      ),
                      child: Text(
                        (sale.status ?? 'pending').toTitleCase(),
                        style:
                            const TextStyle(color: Colors.green, fontSize: 12),
                      ),
                    ),
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
                child: Text('Driver'),
              ),
            ),
            Expanded(
              child: Center(
                child: Text('Amount(GHS)'),
              ),
            ),
            Expanded(
              child: Center(
                child: Text('Status'),
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
        Text(
          'GHS 125,484.00',
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
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
