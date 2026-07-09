import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/presentation/theme/app_theme.dart';
import '../../../data/model/response/work_and_pay/work_and_pay_agreement_model.dart';


class WorkPayHeroCard extends StatelessWidget {
  final WorkAndPayAgreement agreement;

  const WorkPayHeroCard({super.key, required this.agreement});

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;
    final numberFmt = NumberFormat('#,##0.##');

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cs.outlineVariant.withValues(alpha:0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: cs.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.directions_car_outlined,
                    color: cs.primary, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _vehicleLabel,
                      style: context.textTheme.titleSmall?.copyWith(
                        color: cs.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${agreement.vehicle?.licensePlate ?? ''} · ${_frequency}',
                      style: context.textTheme.bodySmall
                          ?.copyWith(color: cs.onSurfaceVariant),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      agreement.agreementId,
                      style: context.textTheme.labelSmall
                          ?.copyWith(color: cs.onSurfaceVariant.withValues(alpha:0.6)),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _StatusChip(status: agreement.status),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total paid',
                style: context.textTheme.labelSmall
                    ?.copyWith(color: cs.onSurfaceVariant),
              ),
              Text(
                'GH₵ ${numberFmt.format(agreement.amountPaid)} / ${numberFmt.format(agreement.totalSalePrice)}',
                style: context.textTheme.labelSmall
                    ?.copyWith(color: cs.onSurface, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 7),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LinearProgressIndicator(
              value: agreement.progressPercent,
              minHeight: 6,
              backgroundColor: cs.onSurface.withValues(alpha:0.1),
              valueColor: AlwaysStoppedAnimation<Color>(cs.primary),
            ),
          ),
          const SizedBox(height: 7),
          Text(
            '${(agreement.progressPercent * 100).toStringAsFixed(0)}% complete · ${agreement.durationYears} yr term',
            style: context.textTheme.labelSmall
                ?.copyWith(color: cs.primary, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  String get _vehicleLabel {
    final v = agreement.vehicle;
    if (v == null) return 'Vehicle';
    final parts = [v.make, v.model, v.year?.toString()]
        .where((e) => e != null && e.isNotEmpty)
        .join(' ');
    return parts.isNotEmpty ? parts : 'Vehicle';
  }

  String get _frequency {
    final f = agreement.paymentFrequency;
    return '${f[0].toUpperCase()}${f.substring(1)}';
  }
}

class _StatusChip extends StatelessWidget {
  final String status;
  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;
    final (bg, fg, dot) = switch (status) {
      'Active' => (
      cs.tertiaryContainer.withValues(alpha:0.5),
      cs.tertiary,
      cs.tertiary,
      ),
      'Completed' => (
      cs.primaryContainer.withValues(alpha:0.5),
      cs.primary,
      cs.primary,
      ),
      'Defaulted' => (
      cs.errorContainer.withValues(alpha:0.5),
      cs.error,
      cs.error,
      ),
      _ => (
      cs.surfaceContainerHighest,
      cs.onSurfaceVariant,
      cs.onSurfaceVariant,
      ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: fg.withValues(alpha:0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
          ),
          const SizedBox(width: 5),
          Text(
            status,
            style: context.textTheme.labelSmall
                ?.copyWith(color: fg, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}