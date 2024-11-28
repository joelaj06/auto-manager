import 'package:flutter/material.dart';

import '../../../../../core/presentation/utils/app_spacing.dart';

class ImageModalListCard extends StatelessWidget {
  const ImageModalListCard(
      {super.key,
      required this.onTap,
      required this.title,
      required this.icon,
      });

  final VoidCallback onTap;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Icon(icon),
              ],
            ),
            const AppSpacing(
              v: 8,
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
