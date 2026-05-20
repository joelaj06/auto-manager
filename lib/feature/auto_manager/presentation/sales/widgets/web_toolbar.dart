import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../../../../core/presentation/theme/app_theme.dart';
import '../../../../../core/utils/data_formatter.dart';
import '../../../../../core/utils/permissions.dart';
import '../getx/sales_controller.dart';
class WebToolbar extends StatelessWidget {
  const WebToolbar({super.key,
    required this.controller,
    required this.onFilterTap,
  });

  final SalesController controller;
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
              'Sales${controller.totalCount.value == 0 ? '' : ' · ${controller.totalCount.value}'}',
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

          // Search
          _WebSearchField(controller: controller),
          const SizedBox(width: 8),

          // Filter
          _ToolbarIconButton(
            icon: IconlyLight.filter,
            label: 'Filter',
            onTap: onFilterTap,
          ),

          // Add sale
          if (UserPermissions.validator.canCreateSale) ...<Widget>[
            const SizedBox(width: 8),
            FilledButton.icon(
              onPressed: controller.navigateToAddSalesWeb,
              icon: const Icon(IconlyLight.plus, size: 16),
              label: const Text('Add sale',
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

class _WebSearchField extends StatelessWidget {
  const _WebSearchField({required this.controller});

  final SalesController controller;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colorScheme;
    return SizedBox(
      width: 200,
      height: 34,
      child: TextField(
        controller: controller.searchQueryTextEditingController.value,
        onSubmitted: controller.onSearchQuerySubmitted,
        style: const TextStyle(fontSize: 13),
        decoration: InputDecoration(
          hintText: 'Search sales...',
          hintStyle:
          TextStyle(fontSize: 13, color: colors.onSurfaceVariant),
          prefixIcon: IconButton(
            onPressed: () {
              controller.reload();
            },
            icon: Icon(IconlyLight.search,
                size: 16, color: colors.onSurfaceVariant),
          ),
          suffixIcon: Obx(
                () => controller
                .searchQueryTextEditingController.value.text.isNotEmpty
                ? IconButton(
              icon: const Icon(Icons.cancel, size: 16),
              onPressed: controller.clearSearchField,
            )
                : const SizedBox.shrink(),
          ),
          isDense: true,
          contentPadding: EdgeInsets.zero,
          filled: true,
          fillColor: colors.surfaceContainerHighest,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
                color: colors.outlineVariant.withValues(alpha: 0.5),
                width: 0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
                color: colors.outlineVariant.withValues(alpha: 0.5),
                width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:
            BorderSide(color: colors.primary, width: 1),
          ),
        ),
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