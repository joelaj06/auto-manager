import 'package:automanager/core/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../../../../core/presentation/utils/utils.dart';

class DashboardSummaryCard extends StatelessWidget {
  const DashboardSummaryCard(
      {super.key,
      required this.title,
      required this.value,
      required this.icon,
      this.onTap,
      this.valueIcon});

  final String title;
  final String value;
  final IconData icon;
  final VoidCallback? onTap;
  final Widget? valueIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPaddings.lA,
      decoration: BoxDecoration(
        color: context.colorScheme.outline.withValues(alpha:0.1),
        borderRadius: AppBorderRadius.card,
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: context.colorScheme.outline.withValues(alpha:0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: AppPaddings.mA,
                  child: Icon(
                    icon,
                    color: context.colorScheme.secondary,
                  ),
                ),
                const AppSpacing(
                  h: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title.toUpperCase(),
                    ),
                    Row(
                      children: <Widget>[
                        Text(value,
                            style: context.textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w500)),
                        const AppSpacing(
                          h: 5,
                        ),
                       if (valueIcon != null) valueIcon! else const SizedBox.shrink(),
                      ],
                    ),
                  ],
                ),
              ],
            ),
           /* Builder(builder: (BuildContext context) {
              if (onTap != null) {
                return Container(
                  decoration: BoxDecoration(
                    color: context.colorScheme.outline.withValues(alpha:0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: AppPaddings.sA.add(AppPaddings.sH),
                  child: InkWell(
                    onTap: onTap,
                    child: const Row(
                      children: <Widget>[
                        Text(
                          'details',
                          style: TextStyle(fontSize: 16),
                        ),
                        AppSpacing(
                          h: 5,
                        ),
                        Icon(
                          Icons.launch_rounded,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            })*/
          ]),
    );
  }
}
