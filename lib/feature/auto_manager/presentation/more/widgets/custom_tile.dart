import 'package:automanager/core/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import '/core/presentation/utils/utils.dart';

class CustomTile extends StatelessWidget {
  const CustomTile({
    Key? key,
    required this.text,
    this.icon,
    required this.onPressed,
    this.hideMoreIcon = false,
    this.textColor,
    this.iconColor,
    this.backgroundColor,
    this.moreIconColor,
    this.showDivider,
  }) : super(key: key);

  final String text;
  final IconData? icon;
  final VoidCallback onPressed;
  final bool hideMoreIcon;
  final Color? textColor;
  final Color? iconColor;
  final Color? backgroundColor;
  final Color? moreIconColor;
  final bool? showDivider;

  @override
  Widget build(BuildContext context) {
    final bool viewDivider = showDivider ?? false;
    return Column(
      children: <Widget>[
        Container(
          decoration:  BoxDecoration(
              color: backgroundColor ?? Colors.transparent,
              borderRadius: BorderRadius.circular(8)
          ),
          child: TextButton(
            style: TextButton.styleFrom(
              padding: AppPaddings.lV,
            ),
            onPressed: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                if (icon == null)
                  const SizedBox.shrink()
                else
                  Icon(
                    icon,
                    size: 22,
                    color: iconColor ?? context.colorScheme.primary,
                  ),
                const AppSpacing(h: 26),
                Text(
                  text,
                  style: context.sub1.copyWith(
                    color: textColor ?? context.colorScheme.primary,
                  ),
                ),
                const Spacer(),
                if (hideMoreIcon)
                  const SizedBox.shrink()
                else
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: moreIconColor?? context.colorScheme.primary,
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (viewDivider) const Divider(height: 0) else const SizedBox.shrink()
      ],
    );
  }
}
