import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../../../../core/presentation/theme/app_theme.dart';
import '../../../../../core/presentation/utils/app_dialogs.dart';
import '../../../../../core/presentation/utils/app_spacing.dart';
import '../../../../../core/presentation/widgets/app_text_input_field.dart';
import '../../../../../core/utils/data_formatter.dart';
import '../../../../../core/utils/permissions.dart';
import '../../../data/model/model.dart';
import '../getx/rental_controller.dart';

class RentalDetailDrawer extends StatefulWidget {
  const RentalDetailDrawer({
    super.key,
    required this.rental,
    required this.controller,
    required this.onClose,
  });

  final Rental rental;
  final RentalController controller;
  final VoidCallback onClose;

  @override
  State<RentalDetailDrawer> createState() => _RentalDetailDrawerState();
}

class _RentalDetailDrawerState extends State<RentalDetailDrawer> {
  bool _showExtensionForm = false;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = context.colorScheme;

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
                  widget.rental.rentalCode,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 18),
                onPressed: widget.onClose,
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
              ),
            ],
          ),
        ),

        // Actions Header
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  DataFormatter.formatDateToString(widget.rental.createdAt ?? ''),
                  style: TextStyle(
                    fontSize: 11,
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ),
              if (UserPermissions.validator.canUpdateRental)
                Tooltip(
                  message: 'Edit rental',
                  child: IconButton(
                    onPressed: () {
                      widget.controller.navigateToUpdateRentalWeb(widget.rental);
                    },
                    icon: const Icon(IconlyLight.edit_square, size: 20),
                  ),
                ),
              if (UserPermissions.validator.canCreateRentalExtension)
                Tooltip(
                  message: 'Extend rental',
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _showExtensionForm = !_showExtensionForm;
                      });
                    },
                    icon: Icon(
                      _showExtensionForm ? Icons.close : Icons.add_circle_outline,
                      size: 20,
                      color: _showExtensionForm ? colors.error : colors.primary,
                    ),
                  ),
                ),
            ],
          ),
        ),

        const Divider(height: 1),

        // Body
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (_showExtensionForm) ...[
                  _buildExtensionForm(context),
                  const Divider(height: 32),
                ],
                _DrawerField(
                  label: 'Customer',
                  value: widget.rental.renter?.name ?? '--',
                ),
                _DrawerField(
                  label: 'Vehicle',
                  value:
                      '${widget.rental.vehicle?.make ?? ''} ${widget.rental.vehicle?.model ?? ''} '
                      '${widget.rental.vehicle?.color ?? ''} ${widget.rental.vehicle?.year ?? ''}',
                ),
                _DrawerField(
                  label: 'Duration',
                  value:
                      '${DataFormatter.formatDate(widget.rental.startDate ?? '')} - ${DataFormatter.formatDate(widget.rental.endDate ?? '')} '
                      '(${widget.controller.getNumberOfDays(DateTime.parse(widget.rental.startDate!), DateTime.parse(widget.rental.endDate!))} Days)',
                ),
                Row(
                  children: [
                    Expanded(
                      child: _DrawerField(
                        label: 'Total Amount',
                        value: DataFormatter.getLocalCurrencyFormatter(context)
                            .format(widget.rental.totalAmount),
                        valueStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: colors.primary,
                        ),
                      ),
                    ),
                    Expanded(
                      child: _DrawerField(
                        label: 'Paid',
                        value: DataFormatter.getLocalCurrencyFormatter(context)
                            .format(widget.rental.amountPaid),
                        valueStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                _DrawerField(
                  label: 'Balance',
                  value: DataFormatter.getLocalCurrencyFormatter(context)
                      .format(widget.rental.balance),
                  valueStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: (widget.rental.balance ?? 0) < 0
                        ? colors.error
                        : Colors.green,
                  ),
                ),
                if (widget.rental.purpose?.isNotEmpty == true)
                  _DrawerField(
                    label: 'Purpose',
                    value: widget.rental.purpose ?? '',
                  ),
                if (widget.rental.note?.isNotEmpty == true)
                  _DrawerField(
                    label: 'Notes',
                    value: widget.rental.note ?? '',
                  ),

                // Extensions History
                if ((widget.rental.extensions ?? <RentalExtension>[]).isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    'EXTENSIONS',
                    style: TextStyle(
                      fontSize: 10,
                      letterSpacing: 0.6,
                      fontWeight: FontWeight.w600,
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...widget.rental.extensions!.asMap().entries.map((entry) {
                    final int index = entry.key;
                    final RentalExtension ext = entry.value;
                    return _buildExtensionItem(context, ext, index);
                  }),
                ],
              ],
            ),
          ),
        ),

        // Delete action
        if (UserPermissions.validator.canDeleteRental)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: InkWell(
              onTap: () async {
                await AppDialogs.showDialogWithButtons(
                  context,
                  onConfirmPressed: () {
                    widget.controller.deleteTheRental(widget.rental);
                    widget.onClose();
                  },
                  content: const Text(
                    'Are you sure you want to delete this rental?',
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
                      'Delete rental',
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

  Widget _buildExtensionForm(BuildContext context) {
    final ColorScheme colors = context.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'EXTEND RENTAL',
          style: TextStyle(
            fontSize: 10,
            letterSpacing: 0.6,
            fontWeight: FontWeight.w600,
            color: colors.primary,
          ),
        ),
        const SizedBox(height: 12),
        Obx(
          () => AppTextInputField(
            controller: widget.controller.extendedDateController.value,
            labelText: 'New End Date',
            validator: (String? value) => null,
            textInputType: TextInputType.datetime,
            readOnly: true,
            onTap: () => widget.controller.selectExtendedDate(context),
          ),
        ),
        const AppSpacing(v: 12),
        AppTextInputField(
          labelText: 'Extension Amount',
          onChanged: widget.controller.onExtendedAmountInputChanged,
          textInputType: const TextInputType.numberWithOptions(decimal: true),
        ),
        const AppSpacing(v: 12),
        AppTextInputField(
          labelText: 'Notes',
          maxLines: 2,
          onChanged: widget.controller.onExtendedNotesInputChanged,
        ),
        const AppSpacing(v: 16),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: () {
              widget.controller.extendTheRental(widget.rental);
              setState(() => _showExtensionForm = false);
            },
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Submit Extension', style: TextStyle(fontSize: 13)),
          ),
        ),
      ],
    );
  }

  Widget _buildExtensionItem(BuildContext context, RentalExtension ext, int index) {
    final ColorScheme colors = context.colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ext ${index + 1}',
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
              ),
              if (UserPermissions.validator.canDeleteRentalExtension)
                InkWell(
                  onTap: () => widget.controller.removeTheExtension(ext, index, widget.rental.id),
                  child: Icon(Icons.delete_outline, size: 14, color: colors.error),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'New Date: ${DataFormatter.formatDate(ext.extendedDate ?? '')}',
            style: const TextStyle(fontSize: 12),
          ),
          Text(
            'Amount: ${DataFormatter.getLocalCurrencyFormatter(context).format(ext.extendedAmount)}',
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
          if (ext.extendedNote?.isNotEmpty == true)
            Text(
              'Note: ${ext.extendedNote}',
              style: TextStyle(fontSize: 11, color: colors.onSurfaceVariant),
            ),
        ],
      ),
    );
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
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
        ],
      ),
    );
  }
}
