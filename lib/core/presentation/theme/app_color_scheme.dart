import 'package:flutter/material.dart';

class AppColorScheme {
  const AppColorScheme(this.textTheme);

  final TextTheme textTheme;

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff000000),
      surfaceTint: Color(0xff5e5e5e),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff262626),
      onPrimaryContainer: Color(0xffb1b1b1),
      secondary: Color(0xff5e5e5e),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffe6e6e6),
      onSecondaryContainer: Color(0xff4a4a4a),
      tertiary: Color(0xff000000),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff262626),
      onTertiaryContainer: Color(0xffb1b1b1),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfff9f9f9),
      onSurface: Color(0xff1b1b1b),
      onSurfaceVariant: Color(0xff4c4546),
      outline: Color(0xff7e7576),
      outlineVariant: Color(0xffcfc4c5),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff303030),
      inversePrimary: Color(0xffc6c6c6),
      background: Color(0xffffffff),
      onBackground: Color(0xffffffff),
    );
  }



  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff000000),
      surfaceTint: Color(0xff5e5e5e),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff262626),
      onPrimaryContainer: Color(0xffdcdcdc),
      secondary: Color(0xff434343),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff747474),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff000000),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff262626),
      onTertiaryContainer: Color(0xffdcdcdc),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff9f9f9),
      onSurface: Color(0xff1b1b1b),
      onSurfaceVariant: Color(0xff484142),
      outline: Color(0xff655d5e),
      outlineVariant: Color(0xff81787a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff303030),
      inversePrimary: Color(0xffc6c6c6),
      background: Color(0xffffffff),
      onBackground: Color(0xffffffff),
    );
  }


  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff000000),
      surfaceTint: Color(0xff5e5e5e),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff262626),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff222222),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff434343),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff000000),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff262626),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff9f9f9),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff282224),
      outline: Color(0xff484142),
      outlineVariant: Color(0xff484142),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff303030),
      inversePrimary: Color(0xffececec),
      background: Color(0xffffffff),
      onBackground: Color(0xffffffff),
    );
  }



  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffc6c6c6),
      surfaceTint: Color(0xffc6c6c6),
      onPrimary: Color(0xff303030),
      primaryContainer: Color(0xff000000),
      onPrimaryContainer: Color(0xff969696),
      secondary: Color(0xffc6c6c6),
      onSecondary: Color(0xff303030),
      secondaryContainer: Color(0xff3d3d3d),
      onSecondaryContainer: Color(0xffd1d1d1),
      tertiary: Color(0xffc6c6c6),
      onTertiary: Color(0xff303030),
      tertiaryContainer: Color(0xff000000),
      onTertiaryContainer: Color(0xff969696),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff131313),
      onSurface: Color(0xffe2e2e2),
      onSurfaceVariant: Color(0xffcfc4c5),
      outline: Color(0xff988e90),
      outlineVariant: Color(0xff4c4546),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e2e2),
      inversePrimary: Color(0xff5e5e5e),
      background: Color(0xff141313),
      onBackground: Color(0xffe5e2e1),
    );
  }



  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffcbcbcb),
      surfaceTint: Color(0xffc6c6c6),
      onPrimary: Color(0xff161616),
      primaryContainer: Color(0xff919191),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffcbcbcb),
      onSecondary: Color(0xff161616),
      secondaryContainer: Color(0xff919191),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffcbcbcb),
      onTertiary: Color(0xff161616),
      tertiaryContainer: Color(0xff919191),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff131313),
      onSurface: Color(0xfffbfbfb),
      onSurfaceVariant: Color(0xffd3c8c9),
      outline: Color(0xffaaa0a2),
      outlineVariant: Color(0xff8a8182),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e2e2),
      inversePrimary: Color(0xff484848),
      background: Color(0xff141313),
      onBackground: Color(0xffe5e2e1),
    );
  }



  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffbfbfb),
      surfaceTint: Color(0xffc6c6c6),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffcbcbcb),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffbfbfb),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffcbcbcb),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffbfbfb),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffcbcbcb),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff131313),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfffff9f9),
      outline: Color(0xffd3c8c9),
      outlineVariant: Color(0xffd3c8c9),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e2e2),
      inversePrimary: Color(0xff2a2a2a),
      background: Color(0xff141313),
      onBackground: Color(0xffe5e2e1),
    );
  }





  /*static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff4d4d4d),
      surfaceTint:  Color(0xff5e5e5e),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff717171),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff5f5e5e),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffe6e3e2),
      onSecondaryContainer: Color(0xff494848),
      tertiary: Color(0xff4e4c4e),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff737072),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfffcf8f8),
      onSurface: Color(0xff1c1b1b),
      onSurfaceVariant: Color(0xff444748),
      outline: Color(0xff747878),
      outlineVariant: Color(0xffc4c7c7),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xffc7c6c6),
      background: Color(0xffffffff),
      onBackground: Color(0xffffffff),
    );
  }


  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff424343),
      surfaceTint: Color(0xff5e5e5e),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff717171),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff434342),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff757474),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff444244),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff737072),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffcf8f8),
      onSurface: Color(0xff1c1b1b),
      onSurfaceVariant: Color(0xff404344),
      outline: Color(0xff5c6060),
      outlineVariant: Color(0xff787b7c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xffc7c6c6),
      background: Color(0xffffffff),
      onBackground: Color(0xffffffff),
    );
  }


  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff222222),
      surfaceTint: Color(0xff5e5e5e),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff424343),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff222222),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff434342),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff232223),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff444244),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffcf8f8),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff212525),
      outline: Color(0xff404344),
      outlineVariant: Color(0xff404344),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xffedeceb),
      background: Color(0xffffffff),
      onBackground: Color(0xffffffff),
    );
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffc7c6c6),
      surfaceTint: Color(0xffc7c6c6),
      onPrimary: Color(0xff303031),
      primaryContainer: Color(0xff585858),
      onPrimaryContainer: Color(0xfffdffff),
      secondary: Color(0xffc8c6c5),
      onSecondary: Color(0xff313030),
      secondaryContainer: Color(0xff3e3d3d),
      onSecondaryContainer: Color(0xffd3d0d0),
      tertiary: Color(0xffcac5c7),
      onTertiary: Color(0xff323032),
      tertiaryContainer: Color(0xff5a5759),
      onTertiaryContainer: Color(0xfffffdff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff141313),
      onSurface: Color(0xffe5e2e1),
      onSurfaceVariant: Color(0xffc4c7c7),
      outline: Color(0xff8e9192),
      outlineVariant: Color(0xff444748),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff5e5e5e),
      background: Color(0xff141313),
      onBackground: Color(0xffe5e2e1),
    );
  }


  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffcccaca),
      surfaceTint: Color(0xffc7c6c6),
      onPrimary: Color(0xff161617),
      primaryContainer: Color(0xff919090),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffcdcaca),
      onSecondary: Color(0xff161616),
      secondaryContainer: Color(0xff929090),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffcec9cb),
      onTertiary: Color(0xff171617),
      tertiaryContainer: Color(0xff939092),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff141313),
      onSurface: Color(0xfffefaf9),
      onSurfaceVariant: Color(0xffc8cbcc),
      outline: Color(0xffa0a3a4),
      outlineVariant: Color(0xff808484),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff484848),
      background: Color(0xff141313),
      onBackground: Color(0xfffefaf9),
    );
  }


  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffcfafa),
      surfaceTint: Color(0xffc7c6c6),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffcccaca),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffdfaf9),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffcdcaca),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffff9fb),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffcec9cb),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff141313),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfff9fbfc),
      outline: Color(0xffc8cbcc),
      outlineVariant: Color(0xffc8cbcc),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff292a2a),
      background: Color(0xff141313),
      onBackground: Color(0xffffffff),
    );
  }

*/



  List<ExtendedColor> get extendedColors => <ExtendedColor>[];
}

class ExtendedColor {
  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });

  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
