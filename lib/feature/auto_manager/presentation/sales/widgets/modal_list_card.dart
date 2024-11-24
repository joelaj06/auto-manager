import 'package:automanager/core/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../../../../core/presentation/utils/app_spacing.dart';

class ModalListCard extends StatelessWidget {
  const ModalListCard({required this.title, required this.value, super.key});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(title,
                style: context.body2.copyWith(fontWeight: FontWeight.w400)),
            const AppSpacing(
              h: 10,
            ),
            Flexible(
              child: Text(
                value.toString(),
                style: context.body2.copyWith(fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const AppSpacing(
          v: 8,
        ),
        const Divider(),
      ],
    );
  }
}
