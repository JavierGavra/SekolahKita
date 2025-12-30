import 'package:flutter/material.dart';

class MaterialTheme {
  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF1A6585),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFFC2E8FF),
      onPrimaryContainer: Color(0xFF004D67),
      secondary: Color(0xFF4E616D),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFD1E5F3),
      onSecondaryContainer: Color(0xFF364954),
      tertiary: Color(0xff605A7D),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFFE5DEFF),
      onTertiaryContainer: Color(0xFF484364),
      error: Color(0xFFBA1A1A),
      onError: Color(0xFFFFFFFF),
      errorContainer: Color(0xFFFFDAD6),
      onErrorContainer: Color(0xFF93000A),
      surface: Color(0xFFF6FAFE),
      onSurface: Color(0xFF171C1F),
      onSurfaceVariant: Color(0xFF40484D),
      surfaceContainerLowest: Color(0xFFFFFFFF),
      surfaceContainerLow: Color(0xFFF0F4F8),
      surfaceContainer: Color(0xFFEAEEF2),
      surfaceContainerHigh: Color(0xFFE5E9ED),
      surfaceContainerHighest: Color(0xFFDFE3E7),
      outline: Color(0xFF71787D),
      outlineVariant: Color(0xFFC0C7CD),
      inverseSurface: Color(0xFF2C3134),
      onInverseSurface: Color(0xFFEDF1F5),
      inversePrimary: Color(0xFF8ECFF2),
    );
  }
}

extension SuccessColorScheme on ColorScheme {
  Color get success => Color(0xFF4BC57C);
  Color get onSuccess => Color(0xFFFFFFFF);
  Color get successContainer => Color(0xFFC7EDD6);
  Color get onSuccessContainer => Color(0xFF205334);
}
