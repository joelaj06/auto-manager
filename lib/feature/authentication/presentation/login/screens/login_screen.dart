import 'package:flutter/material.dart';

import '../../../../../core/presentation/widgets/platform_widget.dart';
import 'login_screen_mobile.dart';
import 'login_screen_web.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlatformWidget(
      mobile: LoginScreenMobile(),
      web: LoginScreenWeb(),
    );
  }
}
