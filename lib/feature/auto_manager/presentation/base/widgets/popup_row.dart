import 'package:flutter/material.dart';

import '../../../../../core/presentation/theme/app_theme.dart';
class PopupRow extends StatelessWidget {
  const PopupRow({
    required this.icon,
    required this.label,
    this.color,
  });

  final IconData icon;
  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final Color effectiveColor =
        color ?? context.colorScheme.onSurface;

    return Row(
      children: <Widget>[
        Icon(icon, size: 18, color: effectiveColor),
        const SizedBox(width: 10),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: effectiveColor,
          ),
        ),
      ],
    );
  }
}

