import 'package:automanager/core/presentation/theme/app_theme.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';

class NavigationAnimation extends StatefulWidget {
  const NavigationAnimation({super.key, required this.content});
  final Widget content;

  @override
  _NavigationAnimationState createState() => _NavigationAnimationState();
}

class _NavigationAnimationState extends State<NavigationAnimation>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? animation;

  @override
  void didUpdateWidget(NavigationAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.content != widget.content) {
      _startAnimation();
    }
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    if (_controller != null) {
      animation = CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeIn,
      );
      _controller!.forward();
    }

    super.initState();
  }

  void _startAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    if (_controller != null) {
      animation = CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeIn,
      );
      _controller!.forward();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: context.colorScheme.secondary.withOpacity(0.1),
      child: Center(
        child: animation == null
            ? const SizedBox()
            : CircularRevealAnimation(
                animation: animation!,
                centerOffset: const Offset(80, 80),
                maxRadius: MediaQuery.of(context).size.longestSide * 1.1,
                child: widget.content,
              ),
      ),
    );
  }
}
