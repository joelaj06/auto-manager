import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
class PlatformWidget extends StatelessWidget {
  const PlatformWidget({required this.mobile, required this.web,super.key});

  final Widget web;
  final Widget mobile;

  @override
  Widget build(BuildContext context) {
     if (kIsWeb) {
      return web;
    } else {
      return mobile;
    }
  }
}
