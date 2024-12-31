import 'package:automanager/core/presentation/theme/app_theme.dart';
import 'package:automanager/feature/auto_manager/presentation/expense/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/presentation/utils/utils.dart';
import '../../../../../core/presentation/widgets/app_button.dart';
import '../../../../../core/presentation/widgets/exception_indicators/exceptions.dart';
import '../../../../../core/utils/utils.dart';
import '../../../data/model/model.dart';
import '../../sales/widgets/modal_list_card.dart';

class ExpensesScreen extends GetView<ExpenseController> {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: UserPermissions.validator.canCreateExpense ? FloatingActionButton(
        onPressed: controller.navigateToAddExpenseScreen,
        child: const Icon(IconlyLight.plus),
      ) : null,
      appBar: AppBar(
        title: Obx(
          () => Text(
              'Expenses${controller.totalCount.value == 0 ? '' : '(${controller.totalCount.value})'}'),
        ),
        leading: IconButton(
          onPressed: () {
            controller.onDateRangeSelected(context);
          },
          icon: const Icon(
            IconlyLight.calendar,
          ),
        ),
        actions: <Widget>[
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
            child: _buildExpenseList(context),
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseList(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildTableHeader(context),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () {
              controller.endDate(DateTime.now());
              return Future<void>.sync(
                () => controller.pagingController.refresh(),
              );
            },
            child: PagedListView<int, Expense>(
                pagingController: controller.pagingController,
                builderDelegate: PagedChildBuilderDelegate<Expense>(
                  itemBuilder:
                      (BuildContext context, Expense expense, int index) {
                    return Slidable(
                      endActionPane: ActionPane(
                        motion: const DrawerMotion(),
                        children: <Widget>[
                          Visibility(
                            visible: UserPermissions.validator.canUpdateExpense,
                            child: SlidableAction(
                              backgroundColor: context.colorScheme.background,
                              //  foregroundColor: Colors.red,
                              icon: IconlyLight.edit,
                              label: 'Edit',
                              onPressed: (BuildContext context) {
                                controller.navigateToUpdateExpenseScreen(expense);
                              },
                            ),
                          ),
                          Visibility(
                            visible: UserPermissions.validator.canDeleteExpense,
                            child: SlidableAction(
                              backgroundColor: context.colorScheme.background,
                              foregroundColor: Colors.red,
                              icon: IconlyLight.delete,
                              label: 'Delete',
                              onPressed: (BuildContext context) async {
                                await AppDialogs.showDialogWithButtons(
                                  context,
                                  onConfirmPressed: () =>
                                      controller.deleteExpense(expense.id),
                                  content: const Text(
                                    'Are you sure you want to delete this expense?',
                                    textAlign: TextAlign.center,
                                  ),
                                  confirmText: 'Delete',
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      child: _buildExpensesListTile(context, index, expense),
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

  Widget _buildExpenseDetailModal(
    BuildContext context,
    Expense expense,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            ModalListCard(
                title: 'Date',
                value:
                    DataFormatter.formatDateToString(expense.createdAt ?? '')),
            ModalListCard(
                title: 'Expense Type', value: expense.category?.name ?? '--'),
            ModalListCard(
                title: 'Incurred By',
                value: '${expense.incurredBy?.firstName ?? ''} '
                    '${expense.incurredBy?.lastName ?? ''}'),
            ModalListCard(
              title: 'Vehicle',
              value:
                  ' ${expense.vehicle?.make ?? ''} ${expense.vehicle?.model ?? ''} ${expense.vehicle?.color ?? ''} '
                  '${expense.vehicle?.year ?? ''}',
            ),
            ModalListCard(
              title: 'Amount',
              value: DataFormatter.getLocalCurrencyFormatter(context)
                  .format(expense.amount),
            ),
            ModalListCard(
              title: 'Notes',
              value: expense.description ?? '',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpensesListTile(
      BuildContext context, int index, Expense expense) {
    return InkWell(
      onTap: () {
        showModalBottomSheet<dynamic>(
          context: context,
          builder: (BuildContext context) => SizedBox(
            child: _buildExpenseDetailModal(context, expense),
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
                          expense.expenseId,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(DataFormatter.formatDate(expense.createdAt ?? '')),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      expense.category?.name ?? '',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        expense.amount?.toStringAsFixed(2) ??
                            0.0.toStringAsFixed(2),
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
              child: Text('Date'),
            ),
            Expanded(
              child: Text('Expense Type'),
            ),
            Expanded(
              child: Center(
                child: Text('Amount(GHS)'),
              ),
            ),
            /* Expanded(
              child: Center(
                child: Text('Status'),
              ),
            ),*/
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
            GetBuilder<ExpenseController>(
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
                                          controller.onFilteredVehicleSelected(
                                            controller.expandableList.first
                                                .body[index].id,
                                          );
                                        },
                                        trailing: controller
                                                    .filteredVehicleId.value ==
                                                controller.expandableList.first
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
                                          '${controller.expandableList.first.body[index].model ?? ''} '
                                          '${controller.expandableList.first.body[index].make ?? ''}'
                                          ' ${controller.expandableList.first.body[index].color ?? ''} '
                                          '${controller.expandableList.first.body[index].year ?? ''}',
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
                                          controller.onFilteredCategorySelected(
                                            controller.expandableList.last
                                                .body[index].id,
                                          );
                                        },
                                        trailing: controller
                                                    .filteredCategoryId.value ==
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
                                          controller.expandableList.last
                                                  .body[index].name ??
                                              '',
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
                              isLoading: false,
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
