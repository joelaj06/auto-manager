import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../../../../core/presentation/theme/app_theme.dart';
import '../../../../../core/utils/data_formatter.dart';
import '../../../../../core/utils/permissions.dart';
import '../getx/expense_controller.dart';

class ExpenseWebToolbar extends StatelessWidget {
  const ExpenseWebToolbar({
    super.key,
    required this.controller,
    required this.onFilterTap,
  });

  final ExpenseController controller;
  final VoidCallback onFilterTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colorScheme;

    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(
          bottom: BorderSide(
            color: colors.outlineVariant.withValues(alpha: 0.5),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          // Title + count
          Obx(
            () => Text(
              'Expenses${controller.totalCount.value == 0 ? '' : ' · ${controller.totalCount.value}'}',
              style: const TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(width: 24),

          // Total amount chip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: colors.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Obx(() => Text(
              DataFormatter.getLocalCurrencyFormatter(context)
                  .format(controller.totalAmount.value),
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: colors.onSurfaceVariant),
            ),
            ),
          ),

          const SizedBox(width: 8),

          // Date chip
          Obx(
            () => GestureDetector(
              onTap: () => controller.onDateRangeSelected(context),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: colors.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(IconlyLight.calendar,
                        size: 13, color: colors.onSurfaceVariant),
                    const SizedBox(width: 4),
                    Text(
                      controller.dateText.value,
                      style: TextStyle(
                          fontSize: 12, color: colors.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const Spacer(),

          // Filter
          _ToolbarIconButton(
            icon: IconlyLight.filter,
            label: 'Filter',
            onTap: onFilterTap,
          ),

          // Add expense
          if (UserPermissions.validator.canCreateExpense) ...<Widget>[
            const SizedBox(width: 8),
            FilledButton.icon(
              onPressed: controller.navigateToAddExpenseWeb,
              icon: const Icon(IconlyLight.plus, size: 16),
              label: const Text('Add expense',
                  style: TextStyle(fontSize: 13)),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 10),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ToolbarIconButton extends StatelessWidget {
  const _ToolbarIconButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(
              color: colors.outlineVariant.withValues(alpha: 0.5),
              width: 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, size: 15, color: colors.onSurfaceVariant),
            const SizedBox(width: 5),
            Text(label,
                style: TextStyle(
                    fontSize: 12, color: colors.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }
}

