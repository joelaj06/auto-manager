import 'dart:async';

import 'package:automanager/core/core.dart';
import 'package:automanager/core/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_padding.dart';

final Color primaryColor = !Get.isDarkMode ? Colors.black : Get.context!.colorScheme.secondaryContainer;

class AppButton extends StatefulWidget {
  AppButton(
      {required this.onPressed,
      this.loading = false,
      this.enabled = true,
      required this.text,
      this.fontSize,
      this.backgroundColor,
      this.padding,
      this.textColor,
      super.key});

  final VoidCallback onPressed;
  final bool loading;
  final bool enabled;
  final String text;
  late Color? backgroundColor;
  final double? fontSize;
  final EdgeInsets? padding;
  final Color? textColor;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  late Color backupColor;

  bool _isHovered = false;

  @override
  void initState() {
    backupColor = widget.backgroundColor ?? primaryColor;
    super.initState();
  }

  void changeColor() {
    setState(() {
      widget.backgroundColor = Colors.white;
    });
  }

  @override
  Widget build(BuildContext context) {
    widget.backgroundColor =
        widget.backgroundColor ?? Color(primaryColor.value);
    return Padding(
      padding: AppPaddings.mV,
      child: GestureDetector(
        onTap: () {
          if (widget.loading || !widget.enabled) {
            return;
          }
          widget.onPressed();
          changeColor();
          Future<dynamic>.delayed(const Duration(milliseconds: 100), () {
            setState(() {
              widget.backgroundColor =
                  backupColor; // Restore to default color after tapping
            });
          });
        },
        child: MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          cursor: widget.enabled ?  SystemMouseCursors.click : SystemMouseCursors.forbidden,
          child: AnimatedContainer(
            // width: width / 2,
            padding: widget.padding ?? AppPaddings.lA,
            decoration: BoxDecoration(
              color: widget.enabled
                  ?  _isHovered
                  ? widget.backgroundColor?.withOpacity(0.8) // Darker on hover
                  : widget.backgroundColor
                  : context.colorScheme.inversePrimary.withOpacity(0.4),
              borderRadius: BorderRadius.circular(15),
            ),
            duration: const Duration(
              milliseconds: 300,
            ),
            child: Center(
              child: FittedBox(
                fit: BoxFit.fill,
                child: Text(
                  widget.text,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: widget.enabled && !widget.loading
                        ? Colors.white
                        : context.colorScheme.onPrimaryContainer.withOpacity(0.4),
                    fontSize: widget.fontSize ?? 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
