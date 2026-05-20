
import 'package:automanager/feature/auto_manager/presentation/sales/widgets/sales_filter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';


import '../../../../../core/core.dart';
import '../../../../../core/presentation/theme/app_theme.dart';
import '../../../../../core/utils/permissions.dart';
import '../../../data/model/response/sale/sales_model.dart';
import '../getx/sales_controller.dart';
import '../widgets/modal_list_card.dart';
import 'web_sales_layout.dart';

class SalesScreen extends GetView<SalesController> {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isWide = MediaQuery.of(context).size.width >= 768;

    return Scaffold(
      floatingActionButton: isWide
          ? null // FAB replaced by toolbar button on web
          : (UserPermissions.validator.canCreateSale
          ? FloatingActionButton(
        onPressed: controller.navigateToAddSalesScreen,
        child: const Icon(IconlyLight.plus),
      )
          : null),
      appBar: isWide ? null : _buildMobileAppBar(context),
      body: isWide
          ? WebSalesLayout(controller: controller)
          : _buildMobileBody(context),
    );
  }

  // ── Mobile AppBar ──────────────────────────────────────────────────────────

  AppBar _buildMobileAppBar(BuildContext context) {
    return AppBar(
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
          onPressed: controller.toggleSearch,
          icon: const Icon(IconlyLight.search),
        ),
        IconButton(
          onPressed: () => _showFilterModal(context),
          icon: const Icon(IconlyLight.filter),
        ),
      ],
    );
  }

  // ── Mobile body ────────────────────────────────────────────────────────────

  Widget _buildMobileBody(BuildContext context) {
    return Column(
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
        Expanded(child: _buildMobileSalesList(context)),
      ],
    );
  }

  // ── Shared helpers (mobile) ────────────────────────────────────────────────

  Widget _buildSearchField(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 4),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(5),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.5),
            blurRadius: 6.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        autofocus: true,
        controller: controller.searchQueryTextEditingController.value,
        onFieldSubmitted: controller.onSearchQuerySubmitted,
        style: const TextStyle(fontSize: 18),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: controller.clearSearchField,
            icon: const Icon(Icons.cancel),
          ),
          border: InputBorder.none,
          hintText: 'Search...',
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
            DataFormatter.getLocalCurrencyFormatter(context)
                .format(controller.totalAmount.value),
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Chip(
          backgroundColor: context.colorScheme.surface,
          labelStyle: context.caption.copyWith(
            color: context.colorScheme.onSurface,
          ),
          label: Obx(() => Text(controller.dateText.value)),
        ),
      ],
    );
  }

  Widget _buildMobileSalesList(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildMobileTableHeader(context),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () {
              controller.endDate(DateTime.now());
              return Future<void>.sync(
                      () => controller.pagingController.refresh());
            },
            child: PagingListener<int, Sale>(
              controller: controller.pagingController,
              builder: (BuildContext context, PagingState<int, Sale> state,
                  VoidCallback fetchNextPage) {
                return PagedListView<int, Sale>(
                  fetchNextPage: fetchNextPage,
                  state: state,
                  builderDelegate: PagedChildBuilderDelegate<Sale>(
                    itemBuilder:
                        (BuildContext context, Sale sale, int index) =>
                        Slidable(
                          endActionPane: ActionPane(
                            motion: const DrawerMotion(),
                            children: <Widget>[
                              if (UserPermissions.validator.canDeleteSale)
                                SlidableAction(
                                  backgroundColor: context.colorScheme.surface,
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
                            ],
                          ),
                          child: _buildMobileSalesTile(context, index, sale),
                        ),
                    firstPageErrorIndicatorBuilder: (BuildContext context) =>
                        ErrorIndicator(
                          error: controller.pagingController.value.error as Failure,
                          onTryAgain: () => controller.pagingController.refresh(),
                        ),
                    noItemsFoundIndicatorBuilder: (BuildContext context) =>
                    const EmptyListIndicator(),
                    newPageProgressIndicatorBuilder: (BuildContext context) =>
                    const Center(
                        child: CircularProgressIndicator.adaptive()),
                    firstPageProgressIndicatorBuilder: (BuildContext context) =>
                    const Center(
                        child: CircularProgressIndicator.adaptive()),
                  ),
                  shrinkWrap: true,
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileTableHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: context.colorScheme.outlineVariant,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          children: const <Widget>[
            Expanded(child: Text('ID')),
            Expanded(child: Center(child: Text('Driver'))),
            Expanded(
              child: Center(
                child: Text('Amount(GHS)',
                    overflow: TextOverflow.ellipsis, maxLines: 1),
              ),
            ),
            Expanded(child: Center(child: Text('Status'))),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileSalesTile(BuildContext context, int index, Sale sale) {
    return InkWell(
      onTap: () => showModalBottomSheet<dynamic>(
        context: context,
        builder: (BuildContext context) =>
            SizedBox(child: _buildSaleDetailModal(context, sale)),
      ),
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
                        Text(sale.saleId,
                            style: context.sub2.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 12)),
                        Text(DataFormatter.formatDate(sale.createdAt ?? ''),
                            style: context.caption),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(
                          '${sale.driver?.firstName ?? ''} ${sale.driver?.user?.lastName ?? ''}',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '${sale.vehicle?.model ?? ''} ${sale.vehicle?.make ?? ''} '
                              '${sale.vehicle?.color ?? ''} ${sale.vehicle?.year ?? ''}',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Center(
                        child: Text(sale.amount.toStringAsFixed(2))),
                  ),
                  Expanded(
                    child: Center(
                      child: Container(
                        padding: AppPaddings.mH.add(AppPaddings.sV),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.2),
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
            const Divider(height: 2),
          ],
        ),
      ),
    );
  }

  Widget _buildSaleDetailModal(BuildContext context, Sale sale) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            ModalListCard(title: 'Sale ID', value: sale.saleId ?? '--'),
            ModalListCard(
              title: 'Date',
              value: DataFormatter.formatDateToString(sale.createdAt ?? ''),
            ),
            ModalListCard(
              title: 'Driver',
              value:
              '${sale.driver?.firstName ?? ''} ${sale.driver?.lastName ?? ''}',
            ),
            ModalListCard(
              title: 'Vehicle',
              value:
              '${sale.vehicle?.make ?? ''} ${sale.vehicle?.model ?? ''} '
                  '${sale.vehicle?.color ?? ''} ${sale.vehicle?.year ?? ''}',
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

  void _showFilterModal(BuildContext context) {
    showModalBottomSheet<dynamic>(
      context: context,
      builder: (BuildContext context) =>
          SizedBox(child: _buildFilterModal(context)),
    );
  }

  Widget _buildFilterModal(BuildContext context) {
    controller.loadDependencies();
    return SalesFilter(controller: controller);
  }

}
