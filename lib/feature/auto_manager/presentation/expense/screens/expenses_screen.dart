import 'package:automanager/core/presentation/theme/app_theme.dart';
import 'package:automanager/feature/auto_manager/presentation/expense/expense.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/presentation/utils/utils.dart';
import '../../../../../core/presentation/widgets/exception_indicators/exceptions.dart';
import '../../../../../core/utils/utils.dart';
import '../../../data/model/model.dart';

class ExpensesScreen extends GetView<ExpenseController> {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(IconlyLight.plus),
      ),
      appBar: AppBar(
        title: Text('Expenses'),
        leading: IconButton(
          onPressed: () {
            controller.onDateRangeSelected(context);
          },
          icon: Icon(
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
            onRefresh: () {
              controller.endDate(DateTime.now());
              return Future<void>.sync(
                  () => controller.pagingController.refresh());
            },
            child: PagedListView<int, Expense>(
                pagingController: controller.pagingController,
                builderDelegate: PagedChildBuilderDelegate<Expense>(
                  itemBuilder:
                      (BuildContext context, Expense expense, int index) {
                    return _buildExpensesListTile(context, index, expense);
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

  Widget _buildExpensesListTile(
      BuildContext context, int index, Expense expense) {
    return Padding(
      padding: AppPaddings.mH,
      child: Column(
        children: <Widget>[
          Padding(
            padding: AppPaddings.lV,
            child: Row(
              children: <Widget>[
                Expanded(
                  child:
                      Text(DataFormatter.formatDate(expense.createdAt ?? '')),
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
              child: Text('Category'),
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
}
