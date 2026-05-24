import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/core.dart';
import '../../../data/model/model.dart';
import '../getx/expense_controller.dart';
import '../widgets/expense_detail_drawer.dart';
import '../widgets/expense_filter.dart';
import '../widgets/expense_web_toolbar.dart';

class WebExpenseLayout extends StatefulWidget {
  const WebExpenseLayout({super.key, required this.controller});

  final ExpenseController controller;

  @override
  State<WebExpenseLayout> createState() => _WebExpenseLayoutState();
}

class _WebExpenseLayoutState extends State<WebExpenseLayout> {
  Expense? _selectedExpense;

  ExpenseController get ctrl => widget.controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ctrl.getAllExpensesWeb(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ExpenseWebToolbar(
          controller: ctrl,
          onFilterTap: () => _showWebFilterSheet(context),
        ),
        Expanded(
          child: Obx(() {
            final List<Expense> expenses = ctrl.currentPageExpenses;
            final bool isLoading =
                ctrl.isWebLoading.value && expenses.isEmpty;
            final bool isError =
                ctrl.webError.value != null && expenses.isEmpty;
            final bool hasData = expenses.isNotEmpty;

            return AppDataTable<Expense>(
              columns: <AppTableColumn>[
                AppTableColumn(
                  key: 'date',
                  label: 'Date',
                  minWidth: 120,
                ),
                AppTableColumn(
                  key: 'category',
                  label: 'Expense Type',
                  minWidth: 140,
                ),
                AppTableColumn(
                  key: 'vehicle',
                  label: 'Vehicle',
                  minWidth: 160,
                ),
                AppTableColumn(
                  key: 'amount',
                  label: 'Amount (GHS)',
                  minWidth: 110,
                  alignment: Alignment.centerRight,
                ),
              ],
              rows: hasData
                  ? expenses.map((Expense expense) {
                      return AppTableRow<Expense>(
                        cells: <String, Widget>{
                          'date': Text(
                            DataFormatter.formatDate(
                              expense.createdAt ?? '',
                            ),
                            style: const TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                          'category': Text(
                            expense.category?.name ?? '',
                            style: const TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                          'vehicle': Text(
                            '${expense.vehicle?.make ?? ''} ${expense.vehicle?.model ?? ''} '
                            '${expense.vehicle?.color ?? ''} ${expense.vehicle?.year ?? ''}',
                            style: const TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          ),
                          'amount': Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                            (expense.amount ?? 0).toStringAsFixed(2),
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                        },
                        data: expense,
                      );
                    }).toList()
                  : <AppTableRow<Expense>>[],
              totalCount: ctrl.totalCount.value,
              rowsPerPage: 10,
              isLoading: isLoading,
              error: ctrl.webError.value,
              onRetry: () => ctrl.getAllExpenses(1),
              onPageChanged: (int pageIndex) async {
                await ctrl.getAllExpenses(pageIndex + 1);
              },
              detailDrawerBuilder: (dynamic data, VoidCallback onClose) {
                final expense = data;
                return ExpenseDetailDrawer(
                  expense: expense as Expense,
                  controller: ctrl,
                  onClose: onClose,
                );
              },
              drawerWidth: 280,
              onRowTap: (data) {
                setState(() => _selectedExpense = data);
              },
            );
          }),
        ),
      ],
    );
  }

  void _showWebFilterSheet(BuildContext context) {
    showModalBottomSheet<dynamic>(
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxWidth: 480,
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      builder: (_) => ExpenseFilter(controller: ctrl),
    );
  }
}

