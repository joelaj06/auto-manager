import 'dart:async';

import 'package:automanager/core/presentation/app/auto_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/error_handling/error_boundary.dart';
import 'core/error_handling/error_reporter.dart';
import 'core/presentation/widgets/error_view.dart';
import 'core/utils/app_log.dart';
import 'core/utils/environment.dart';

void mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      systemStatusBarContrastEnforced: true,
      systemNavigationBarDividerColor: Colors.transparent,
      //  systemNavigationBarIconBrightness: Brightness.light,
      //statusBarIconBrightness: Brightness.light
    ),
  );

  //Setting SystmeUIMode
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);

  /*await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
      overlays: <SystemUiOverlay>[SystemUiOverlay.top]);*/

  final ErrorReporter errorReporter = ErrorReporter(client: _ReporterClient());
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(
    logListener(
      onReleaseModeException: errorReporter.report,
    ),
  );

  final String initialRoute = await getInitialRoute();

  ErrorBoundary(
    isReleaseMode: !environment.isDebugging,
    errorViewBuilder: (_) => const ErrorView(),
    onException: AppLog.e,
    child: AutoManager(initialRoute: initialRoute),
  );
}

Future<String> getInitialRoute() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? currentRoute = prefs.getString('currentRoute');
  final bool? skipOnboarding = prefs.getBool('skipOnboarding');
  if (skipOnboarding == null || skipOnboarding == false) {
    currentRoute = '/onboarding';
  }
  currentRoute ??= '/login';
  return currentRoute;
}

class _ReporterClient implements ReporterClient {
  _ReporterClient();

  @override
  FutureOr<void> report(
      {required StackTrace stackTrace,
      required Object error,
      Object? extra}) async {
    // TODO: Sentry or Crashlytics
  }

  @override
  void log(Object object) {
    AppLog.i(object);
  }
}
