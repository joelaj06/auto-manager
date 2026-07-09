import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/presentation/theme/app_theme.dart';
import '../../../data/model/response/work_and_pay/work_and_pay_agreement_model.dart';

class WorkPaySummaryGrid extends StatelessWidget {
  final WorkAndPayAgreement agreement;

  const WorkPaySummaryGrid({super.key, required this.agreement});

  @override
  Widget build(BuildContext context) {
    final numberFmt = NumberFormat('#,##0.##');

    final tiles = [
      _TileData(
        icon: Icons.account_balance_wallet_outlined,
        value: 'GH₵ ${numberFmt.format(agreement.balanceDue)}',
        label: 'Balance due',
        highlight: false,
      ),
      _TileData(
        icon: Icons.calendar_today_outlined,
        value: 'GH₵ ${numberFmt.format(agreement.installmentAmount)}',
        label: 'Per installment',
        highlight: false,
      ),
      _TileData(
        icon: Icons.check_circle_outline,
        value: '${agreement.installmentsPaid} paid',
        label: 'Installments done',
        highlight: true,
      ),
      _TileData(
        icon: Icons.schedule_outlined,
        value: '${agreement.installmentsRemaining} left',
        label: 'Remaining',
        highlight: false,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: tiles.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 2.0,
        ),
        itemBuilder: (context, i) => _SummaryTile(data: tiles[i]),
      ),
    );
  }
}

class _TileData {
  final IconData icon;
  final String value;
  final String label;
  final bool highlight;

  const _TileData({
    required this.icon,
    required this.value,
    required this.label,
    required this.highlight,
  });
}

class _SummaryTile extends StatelessWidget {
  final _TileData data;
  const _SummaryTile({required this.data});

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;
    final valueColor = data.highlight ? cs.tertiary : cs.onSurface;
    final iconColor =
    data.highlight ? cs.tertiary.withValues(alpha: 0.7) : cs.onSurfaceVariant.withValues(alpha: 0.5);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(data.icon, size: 16, color: iconColor),
          const SizedBox(height: 6),
          Text(
            data.value,
            style: context.textTheme.titleSmall?.copyWith(
              color: valueColor,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 3),
          Text(
            data.label,
            style: context.textTheme.labelSmall
                ?.copyWith(color: cs.onSurfaceVariant.withValues(alpha: 0.5)),
          ),
        ],
      ),
    );
  }
}