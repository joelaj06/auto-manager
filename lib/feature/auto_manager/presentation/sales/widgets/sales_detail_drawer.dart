import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../../core/presentation/theme/app_theme.dart';
import '../../../../../core/presentation/utils/app_dialogs.dart';
import '../../../../../core/presentation/utils/string_utils.dart';
import '../../../../../core/utils/data_formatter.dart';
import '../../../../../core/utils/permissions.dart';
import '../../../data/model/response/sale/sales_model.dart';
import '../getx/sales_controller.dart';
class SaleDetailDrawer extends StatelessWidget {
  const SaleDetailDrawer({super.key,
    required this.sale,
    required this.controller,
    required this.onClose,
  });

  final Sale sale;
  final SalesController controller;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colorScheme;
    final String driverInitials = _initials(
      sale.driver?.firstName,
      sale.driver?.lastName,
    );
    final bool isPaid =
        (sale.status ?? 'pending').toLowerCase() == 'paid';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Header
        Container(
          padding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                  sale.saleId ?? '--',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
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

        // Driver avatar
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 22,
                backgroundColor: colors.primaryContainer,
                child: Text(
                  driverInitials,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: colors.onPrimaryContainer,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${sale.driver?.firstName ?? ''} ${sale.driver?.lastName ?? ''}',
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      DataFormatter.formatDateToString(
                          sale.createdAt ?? ''),
                      style: TextStyle(
                          fontSize: 11,
                          color: colors.onSurfaceVariant),
                    ),
                  ],
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
                  label: 'Sale ID',
                  value: sale.saleId ?? '--',
                ),
                _DrawerField(
                  label: 'Vehicle',
                  value:
                  '${sale.vehicle?.make ?? ''} ${sale.vehicle?.model ?? ''} '
                      '${sale.vehicle?.color ?? ''} ${sale.vehicle?.year ?? ''}',
                ),
                _DrawerField(
                  label: 'Amount',
                  value: DataFormatter.getLocalCurrencyFormatter(context)
                      .format(sale.amount),
                  valueStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: colors.primary,
                  ),
                ),
                _DrawerField(
                  label: 'Status',
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isPaid
                          ? Colors.green.withValues(alpha: 0.12)
                          : Colors.orange.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      (sale.status ?? 'pending').toTitleCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: isPaid ? Colors.green : Colors.orange,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Delete action
        if (UserPermissions.validator.canDeleteSale)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: InkWell(
              onTap: () async {
                await AppDialogs.showDialogWithButtons(
                  context,
                  onConfirmPressed: () {
                    controller.deleteASale(sale.id);
                    onClose();
                  },
                  content: const Text(
                    'Are you sure you want to delete this sale?',
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
                    Icon(IconlyLight.delete, size: 15,
                    color: colors.error),
                    const SizedBox(width: 10),
                     Text('Delete sale',
                        style: TextStyle(fontSize: 13,
                        color: colors.error),
                    ),
                  ],
                ),
              ),
            )
            // OutlinedButton.icon(
            //
            //   onPressed: () async {
            //     await AppDialogs.showDialogWithButtons(
            //       context,
            //       onConfirmPressed: () {
            //         controller.deleteASale(sale.id);
            //         onClose();
            //       },
            //       content: const Text(
            //         'Are you sure you want to delete this sale?',
            //         textAlign: TextAlign.center,
            //       ),
            //       confirmText: 'Delete',
            //     );
            //   },
            //   icon: const Icon(IconlyLight.delete, size: 15),
            //   label: const Text('Delete sale',
            //       style: TextStyle(fontSize: 13)),
            //   style: OutlinedButton.styleFrom(
            //     foregroundColor: Colors.red,
            //     visualDensity: VisualDensity.compact,
            //     side: const BorderSide(color: Colors.red, width: 0.5),
            //     padding: const EdgeInsets.symmetric(vertical: 10),
            //   ),
            // ),
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
                style: valueStyle ??
                    const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w500),
              ),
        ],
      ),
    );
  }
}