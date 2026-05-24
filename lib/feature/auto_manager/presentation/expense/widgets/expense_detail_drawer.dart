import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../../core/presentation/theme/app_theme.dart';
import '../../../../../core/presentation/utils/app_dialogs.dart';
import '../../../../../core/utils/data_formatter.dart';
import '../../../../../core/utils/permissions.dart';
import '../../../data/model/model.dart';
import '../getx/expense_controller.dart';

class ExpenseDetailDrawer extends StatelessWidget {
  const ExpenseDetailDrawer({
    super.key,
    required this.expense,
    required this.controller,
    required this.onClose,
  });

  final Expense expense;
  final ExpenseController controller;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colorScheme;
    final String incurredByInitials = _initials(
      expense.incurredBy?.firstName,
      expense.incurredBy?.lastName,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: colors.outlineVariant.withValues(alpha: 0.5),
                width: 0.5,
              ),
            ),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  expense.expenseId ?? '--',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 18),
                onPressed: onClose,
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
              ),
            ],
          ),
        ),

        // Incurred by avatar
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // CircleAvatar(
              //   radius: 22,
              //   backgroundColor: colors.primaryContainer,
              //   child: Text(
              //     incurredByInitials,
              //     style: TextStyle(
              //       fontSize: 13,
              //       fontWeight: FontWeight.w600,
              //       color: colors.onPrimaryContainer,
              //     ),
              //   ),
              // ),
              // const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Text(
                    //   '${expense.incurredBy?.firstName ?? ''} ${expense.incurredBy?.lastName ?? ''}',
                    //   style: const TextStyle(
                    //       fontSize: 13, fontWeight: FontWeight.w600),
                    //   overflow: TextOverflow.ellipsis,
                    // ),
                    Text(
                      DataFormatter.formatDateToString(expense.createdAt ?? ''),
                      style: TextStyle(
                        fontSize: 11,
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Tooltip(
                message: 'Edit expense',
                child: IconButton(
                  onPressed:( ) {
                    controller.navigateToUpdateExpenseWeb(expense);
                  },
                  icon: Icon(IconlyLight.edit_square),
                ),
              ),
            ],
          ),
        ),

        const Divider(height: 1),

        // Fields
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _DrawerField(
                  label: 'Expense ID',
                  value: expense.expenseId ?? '--',
                ),
                _DrawerField(
                  label: 'Date',
                  value: DataFormatter.formatDateToString(
                    expense.createdAt ?? '',
                  ),
                ),
                _DrawerField(
                  label: 'Expense Type',
                  value: expense.category?.name ?? '--',
                ),
                _DrawerField(
                  label: 'Vehicle',
                  value:
                      '${expense.vehicle?.make ?? ''} ${expense.vehicle?.model ?? ''} '
                      '${expense.vehicle?.color ?? ''} ${expense.vehicle?.year ?? ''}',
                ),
                _DrawerField(
                  label: 'Amount',
                  value: DataFormatter.getLocalCurrencyFormatter(
                    context,
                  ).format(expense.amount),
                  valueStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: colors.primary,
                  ),
                ),
                if (expense.description?.isNotEmpty == true)
                  _DrawerField(
                    label: 'Notes',
                    value: expense.description ?? '',
                  ),
              ],
            ),
          ),
        ),

        // Delete action
        if (UserPermissions.validator.canDeleteExpense)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: InkWell(
              onTap: () async {
                await AppDialogs.showDialogWithButtons(
                  context,
                  onConfirmPressed: () {
                    controller.deleteTheExpense(expense.id);
                    onClose();
                  },
                  content: const Text(
                    'Are you sure you want to delete this expense?',
                    textAlign: TextAlign.center,
                  ),
                  confirmText: 'Delete',
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: colors.error),
                  color: colors.error.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(IconlyLight.delete, size: 15, color: colors.error),
                    const SizedBox(width: 10),
                    Text(
                      'Delete expense',
                      style: TextStyle(fontSize: 13, color: colors.error),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  String _initials(String? first, String? last) {
    final String f = (first?.isNotEmpty == true) ? first![0] : '';
    final String l = (last?.isNotEmpty == true) ? last![0] : '';
    return '$f$l'.toUpperCase();
  }
}

class _DrawerField extends StatelessWidget {
  const _DrawerField({
    required this.label,
    this.value,
    this.valueStyle,
    this.child,
  });

  final String label;
  final String? value;
  final TextStyle? valueStyle;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              letterSpacing: 0.6,
              fontWeight: FontWeight.w500,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          child ??
              Text(
                value ?? '--',
                style:
                    valueStyle ??
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
        ],
      ),
    );
  }
}
