import 'package:automanager/core/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_spacing.dart';

class AppLoadingBox extends StatelessWidget {
  const AppLoadingBox({
    super.key,
    required this.child,
    this.backgroundColor,
    this.loaderColor,
    this.loaderSize,
    this.loadingProgress,
    this.loading = false,
    this.loadingText,
  });

  final Widget child;
  final bool loading;
  final Color? backgroundColor;
  final double? loadingProgress;
  final Color? loaderColor;
  final double? loaderSize;
  final Widget? loadingText;

  static const double circleSize= 50;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      curve: Curves.ease,
      duration: const Duration(milliseconds: 1300),
      tween: Tween<double>(begin: 0.0, end: 1.0),
      builder: (_, double animationValue, Widget? __) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            child,
            Positioned.fill(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: DecoratedBox(
                  key: ValueKey<bool>(loading),
                  decoration: BoxDecoration(
                    color: backgroundColor ??
                        context.colorScheme.surface.withValues(alpha: .70),
                  ),
                  child: !loading
                      ? const SizedBox()
                      : Stack(
                          children: <Widget>[
                            Center(
                              child: loadingText != null
                                  ? Container(
                                      height: 200,
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      decoration: BoxDecoration(
                                        color: context.colorScheme.surface,
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                            color: Colors.black.withValues(alpha: 0.1),
                                            blurRadius: 10,
                                            offset: const Offset(0, 10),
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                            width: circleSize,
                                            height: circleSize,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 15,
                                              strokeCap: StrokeCap.round,
                                              color: Get.isDarkMode
                                                  ? context.colorScheme.surfaceTint
                                                  : context.colorScheme.primary,
                                            ),
                                          ),
                                          const AppSpacing(v: 20,),
                                          Align(
                                              alignment: Alignment.center,
                                              child:
                                                  Center(child: loadingText),
                                          ),
                                        ],
                                      ),
                                    )
                                  : CircularProgressIndicator()
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}


