import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/presentation/theme/app_theme.dart';
import '../../../data/model/response/work_and_pay/work_and_pay_payment_model.dart';

class WorkPayTimeline extends StatelessWidget {
  final List<WorkAndPayPayment> payments;
  final bool isLoading;
  final String? error;
  final VoidCallback? onRetry;

  const WorkPayTimeline({
    super.key,
    required this.payments,
    this.isLoading = false,
    this.error,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'PAYMENT HISTORY',
                style: context.textTheme.labelSmall?.copyWith(
                  color: cs.onSurfaceVariant.withValues(alpha: 0.5),
                  letterSpacing: 1,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (!isLoading && error == null)
                Text(
                  '${payments.length} payment${payments.length == 1 ? '' : 's'}',
                  style: context.textTheme.labelSmall
                      ?.copyWith(color: cs.primary, fontWeight: FontWeight.w500),
                ),
            ],
          ),
          const SizedBox(height: 14),
          if (isLoading)
            _LoadingState()
          else if (error != null)
            _ErrorState(message: error!, onRetry: onRetry)
          else if (payments.isEmpty)
              _EmptyState()
            else
              _TimelineList(payments: payments),
        ],
      ),
    );
  }
}

class _TimelineList extends StatelessWidget {
  final List<WorkAndPayPayment> payments;
  const _TimelineList({required this.payments});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(payments.length, (i) {
        final isLast = i == payments.length - 1;
        return _TimelineItem(
          payment: payments[i],
          isFirst: i == 0,
          isLast: isLast,
        );
      }),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final WorkAndPayPayment payment;
  final bool isFirst;
  final bool isLast;

  const _TimelineItem({
    required this.payment,
    required this.isFirst,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;
    final numberFmt = NumberFormat('#,##0.##');

    final dotColor = isFirst ? cs.tertiary : cs.onSurface.withValues(alpha: 0.2);
    final amountColor =
    isFirst ? cs.onSurface : cs.onSurface.withValues(alpha: 0.55);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 22,
            child: Column(
              children: [
                const SizedBox(height: 3),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                    border: isFirst
                        ? Border.all(
                      color: cs.surface,
                      width: 1.5,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    )
                        : null,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 1,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      color: cs.onSurface.withValues(alpha: 0.08),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'GH₵ ${numberFmt.format(payment.amount)}',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: amountColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      if (payment.paymentId != null) ...[
                        Text(
                          payment.paymentId!,
                          style: context.textTheme.labelSmall?.copyWith(
                            color: cs.onSurfaceVariant.withValues(alpha: 0.5),
                          ),
                        ),
                        Text(
                          ' · ',
                          style: context.textTheme.labelSmall?.copyWith(
                            color: cs.onSurfaceVariant.withValues(alpha: 0.25),
                          ),
                        ),
                      ],
                      Text(
                        _formatDate(payment.paymentDate),
                        style: context.textTheme.labelSmall?.copyWith(
                          color: cs.onSurfaceVariant.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(
                      color: cs.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      payment.method.toLowerCase(),
                      style: context.textTheme.labelSmall?.copyWith(
                        color: cs.onSurfaceVariant.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String iso) {
    try {
      final dt = DateTime.parse(iso).toLocal();
      return DateFormat('MMM d, y').format(dt);
    } catch (_) {
      return iso;
    }
  }
}

class _LoadingState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const _ErrorState({required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 12),
          Text(
            message,
            style: context.textTheme.bodySmall?.copyWith(color: cs.error),
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 8),
            TextButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: Text(
          'No payments recorded yet',
          style: context.textTheme.bodySmall
              ?.copyWith(color: cs.onSurfaceVariant),
        ),
      ),
    );
  }
}