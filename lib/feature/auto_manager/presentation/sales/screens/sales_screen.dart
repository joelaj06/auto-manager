import 'package:automanager/core/core.dart';
import 'package:automanager/core/presentation/theme/app_theme.dart';
import 'package:automanager/feature/auto_manager/presentation/sales/getx/sales_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../data/model/response/sale/sales_model.dart';
import '../widgets/modal_list_card.dart';

class SalesScreen extends GetView<SalesController> {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: UserPermissions.validator.canCreateSale
          ? FloatingActionButton(
              onPressed: controller.navigateToAddSalesScreen,
              child: const Icon(IconlyLight.plus),
            )
          : null,
      appBar: AppBar(
        title: Obx(
          () => AnimatedBuilder(
            animation: controller.animation,
            builder: (BuildContext context, Widget? child) {
              return Opacity(
                opacity: controller.isSearching.value
                    ? controller.animation.value
                    : 1.0,
                child: Transform.translate(
                  offset: Offset(0.0, 5.0 * (1 - controller.animation.value)),
                  child: child,
                ),
              );
            },
            child: controller.isSearching.value
                ? _buildSearchField(context)
                : Obx(
                    () => Text(
                      'Sales ${controller.totalCount.value == 0 ? '' : '(${controller.totalCount.value})'}',
                    ),
                  ),
          ),
        ),
        leading: Obx(
          () => IconButton(
            onPressed: () {
              controller.isSearching.value
                  ? controller.toggleSearch()
                  : controller.onDateRangeSelected(context);
            },
            icon: Icon(
              controller.isSearching.value
                  ? Icons.arrow_back
                  : IconlyLight.calendar,
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              controller.toggleSearch();
            },
            icon: const Icon(IconlyLight.search),
          ),
          IconButton(
            onPressed: () {
              showModalBottomSheet<dynamic>(
                context: context,
                builder: (BuildContext context) => SizedBox(
                  child: _buildFilterModal(
                    context,
                  ),
                ),
              );
            },
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
                height: context.height * 0.09,
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

  Container _buildSearchField(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 4),
      decoration: BoxDecoration(
        color: context.colorScheme.background,
        borderRadius: BorderRadius.circular(5),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 6.0,
            spreadRadius: 0.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        autofocus: true,
        controller: controller.searchQueryTextEditingController.value,
        onFieldSubmitted: controller.onSearchQuerySubmitted,
        style: const TextStyle(
          fontSize: 18,
        ),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: controller.clearSearchField,
            icon: const Icon(
              Icons.cancel,
            ),
          ),
          border: InputBorder.none,
          hintText: 'Search...',
        ),
      ),
    );
  }

  Widget _buildSalesList(BuildContext context) {
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
            child: PagedListView<int, Sale>(
                pagingController: controller.pagingController,
                builderDelegate: PagedChildBuilderDelegate<Sale>(
                  itemBuilder: (BuildContext context, Sale sale, int index) {
                    return Slidable(
                      endActionPane: ActionPane(
                        motion: const DrawerMotion(),
                        children: <Widget>[
                          Visibility(
                            visible: UserPermissions.validator.canDeleteSale,
                            child: SlidableAction(
                              backgroundColor: context.colorScheme.background,
                              foregroundColor: Colors.red,
                              icon: IconlyLight.delete,
                              label: 'Delete',
                              onPressed: (BuildContext context) async {
                                await AppDialogs.showDialogWithButtons(
                                  context,
                                  onConfirmPressed: () =>
                                      controller.deleteASale(sale.id),
                                  content: const Text(
                                    'Are you sure you want to delete this sale?',
                                    textAlign: TextAlign.center,
                                  ),
                                  confirmText: 'Delete',
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      child: _buildSalesListTile(context, index, sale),
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
    Sale sale,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            ModalListCard(title: 'Sale ID', value: sale.saleId ?? '--'),
            ModalListCard(
                title: 'Date',
                value: DataFormatter.formatDateToString(sale.createdAt ?? '')),
            ModalListCard(
                title: 'Driver',
                value: '${sale.driver?.user.firstName ?? ''} '
                    '${sale.driver?.user.lastName ?? ''}'),
            ModalListCard(
              title: 'Vehicle',
              value:
                  ' ${sale.vehicle?.make ?? ''} ${sale.vehicle?.model ?? ''} ${sale.vehicle?.color ?? ''} '
                  '${sale.vehicle?.year ?? ''}',
            ),
            ModalListCard(
              title: 'Amount',
              value: DataFormatter.getLocalCurrencyFormatter(context)
                  .format(sale.amount),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSalesListTile(BuildContext context, int index, Sale sale) {
    return InkWell(
      onTap: () {
        showModalBottomSheet<dynamic>(
          context: context,
          builder: (BuildContext context) => SizedBox(
            child: _buildSaleDetailModal(context, sale),
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
                          '${sale.driver?.user.firstName ?? ''} ${sale.driver?.user.lastName ?? ''}',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '${sale.vehicle?.model ?? ''} ${sale.vehicle?.make ?? ''} ${sale.vehicle?.color ?? ''} '
                          '${sale.vehicle?.year ?? ''}',
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
                          style: const TextStyle(
                              color: Colors.green, fontSize: 12),
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

  //filter
  Widget _buildFilterModal(BuildContext context) {
    controller.loadDependencies();
    return SingleChildScrollView(
      child: Padding(
        padding: AppPaddings.mA,
        child: Column(
          children: <Widget>[
            const Align(
              alignment: Alignment.center,
              child:
                  Text('Filter', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            const AppSpacing(
              v: 20,
            ),
            GetBuilder<SalesController>(
                id: 'filter',
                builder: (_) {
                  return ExpansionPanelList(
                    expansionCallback: (int panelIndex, bool isExpanded) {
                      controller.onExpansionCallBack(panelIndex);
                    },
                    materialGapSize: 10,
                    expandedHeaderPadding: EdgeInsets.zero,
                    children: controller.expandableList.isEmpty
                        ? <ExpansionPanel>[]
                        : <ExpansionPanel>[
                            _buildExpansionPanel(
                              context,
                              isExpanded:
                                  controller.expandableList.first.isExpanded,
                              title:
                                  controller.expandableList.first.headerValue,
                              icon: controller.expandableList.first.icon,
                              body: Obx(
                                () => ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: controller
                                      .expandableList.first.body.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Obx(
                                      () => ListTile(
                                        onTap: () {
                                          controller.onFilteredDriverSelected(
                                              controller.expandableList.first
                                                  .body[index].id);
                                        },
                                        trailing:
                                            controller.filteredDriverId.value ==
                                                    controller.expandableList
                                                        .first.body[index].id
                                                ? const Icon(
                                                    Icons.check_circle,
                                                  )
                                                : null,
                                        title: Text(
                                          '${controller.expandableList.first.body[index].user.firstName} '
                                          '${controller.expandableList.first.body[index].user.lastName}',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const Divider();
                                  },
                                ),
                              ),
                              isLoading: controller.isDriversLoading.value,
                            ),
                            _buildExpansionPanel(
                              context,
                              isExpanded:
                                  controller.expandableList.last.isExpanded,
                              title: controller.expandableList.last.headerValue,
                              icon: controller.expandableList.last.icon,
                              body: Obx(
                                () => ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: controller
                                      .expandableList.last.body.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Obx(
                                      () => ListTile(
                                        onTap: () {
                                          controller.onFilteredVehicleSelected(
                                            controller.expandableList.last
                                                .body[index].id,
                                          );
                                        },
                                        trailing: controller
                                                    .filteredVehicleId.value ==
                                                controller.expandableList.last
                                                    .body[index].id
                                            ? const Icon(
                                                Icons.check_circle,
                                              )
                                            : null,
                                        visualDensity: const VisualDensity(
                                          vertical: -4,
                                          horizontal: -4,
                                        ),
                                        title: Text(
                                          '${controller.expandableList.last.body[index].model ?? ''} '
                                          '${controller.expandableList.last.body[index].make ?? ''}'
                                          ' ${controller.expandableList.last.body[index].color ?? ''} '
                                          '${controller.expandableList.last.body[index].year ?? ''}',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const Divider();
                                  },
                                ),
                              ),
                              isLoading: controller.isVehiclesLoading.value,
                            ),
                          ],
                  );
                }),
            const AppSpacing(
              v: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: OutlinedButton(
                    onPressed: controller.resetFilters,
                    child: const Text('Reset'),
                  ),
                ),
                const AppSpacing(
                  h: 10,
                ),
                Expanded(
                  child: AppButton(
                    padding: const EdgeInsets.all(12),
                    onPressed: () {
                      controller.pagingController.refresh();
                      Get.back();
                    },
                    text: 'Apply',
                    fontSize: 12,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  ExpansionPanel _buildExpansionPanel(
    BuildContext context, {
    required bool isExpanded,
    required String title,
    required IconData icon,
    required Widget body,
    required bool isLoading,
  }) {
    return ExpansionPanel(
      canTapOnHeader: true,
      isExpanded: isExpanded,
      backgroundColor: context.colorScheme.surface,
      headerBuilder: (BuildContext context, bool isExpanded) {
        return Padding(
          padding: AppPaddings.mA,
          child: Text.rich(
            TextSpan(
              children: <InlineSpan>[
                WidgetSpan(child: Icon(icon)),
                const WidgetSpan(child: AppSpacing(h: 10)),
                TextSpan(
                  text: title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onSurface),
                ),
              ],
            ),
          ),
        );
      },
      body: isLoading ? const Center(child: CircularProgressIndicator()) : body,
    );
  }
}
