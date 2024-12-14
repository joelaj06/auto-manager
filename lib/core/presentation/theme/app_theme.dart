import 'package:automanager/core/core.dart';
import 'package:automanager/core/presentation/theme/fonts.dart';
import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme();

  static const TextTheme textTheme = TextTheme();

  static bool isJunat =
      AppFlavorEnvironment.appFlavor == FlavorEnvironment.junat.name;

  static ThemeData get light => _theme(isJunat
      ? AppColorSchemeJunat.lightScheme()
      : AppColorScheme.lightScheme());

  static ThemeData get dark => _theme(
        isJunat
            ? AppColorSchemeJunat.darkScheme()
            : AppColorScheme.darkScheme(),
      );

  static ThemeData _theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        fontFamily: AppFonts.poppins,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.background,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
            fontSize: 24,
            fontFamily: AppFonts.poppins,
          ),
        ),
        dividerTheme: DividerThemeData(
          color: colorScheme.outline.withOpacity(0.6),
          thickness: 1,
        ),
        scaffoldBackgroundColor: colorScheme.background,
        canvasColor: colorScheme.surface,
      );
}

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  TextStyle get h2 => theme.textTheme.displayMedium!;

  TextStyle get h3 => theme.textTheme.displaySmall!;

  TextStyle get h4 => theme.textTheme.headlineMedium!;

  TextStyle get h5 => theme.textTheme.headlineSmall!;

  TextStyle get h6 => theme.textTheme.titleLarge!;

  TextStyle get sub1 => theme.textTheme.titleMedium!;

  TextStyle get sub2 => theme.textTheme.titleSmall!;

  TextStyle get body1 => theme.textTheme.bodyLarge!;

  TextStyle get body2 => theme.textTheme.bodyMedium!;

  TextStyle get body2Bold =>
      theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w800);

  TextStyle get bodyError => theme.textTheme.bodyMedium!
      .copyWith(color: Theme.of(this).colorScheme.error);

  TextStyle get caption => theme.textTheme.bodySmall!;

  TextStyle get smallest => theme.textTheme.bodyMedium!;

  TextStyle get captionError => theme.textTheme.bodySmall!
      .copyWith(color: Theme.of(this).colorScheme.error);

  TextStyle get button => theme.textTheme.labelLarge!;

  TextStyle get buttonSmall => theme.textTheme.labelLarge!;

  TextStyle get overline => theme.textTheme.labelSmall!;

  TextStyle get appBarTitle => theme.textTheme.bodyLarge!.copyWith(
        fontWeight: FontWeight.w600,
      );

  bool get isDarkMode =>
      MediaQuery.of(this).platformBrightness == Brightness.dark;
}
