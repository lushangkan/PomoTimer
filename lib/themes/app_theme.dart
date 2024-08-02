import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:pomotimer/themes/default_theme.dart';

class AppTheme {

  late List<String> _themes;

  AppTheme() {
    _themes = FlexScheme.values.map((FlexScheme e) => e.name.toLowerCase()).toList();
    _themes.add('default');
  }

  FlexScheme? getFlexSchemeTheme(String theme) {
    if (theme == "default") {
      return null;
    }

    return FlexScheme.values.firstWhere((element) => element.name == theme);
  }

  ThemeData getThemeData(String theme, bool isDark) {
    if (theme == "default") {
      if (!isDark) {
        return defThemeLight;
      }

      return defThemeDark;
    }

    if (!isDark) {
        return FlexThemeData.light(scheme: getFlexSchemeTheme(theme), fontFamily: 'MiSans').copyWith(
            popupMenuTheme: PopupMenuThemeData(
              position: PopupMenuPosition.under,
              color: FlexThemeData.light(scheme: getFlexSchemeTheme(theme)).colorScheme.surfaceContainer,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
        );
    }

    return FlexThemeData.dark(scheme: getFlexSchemeTheme(theme), fontFamily: 'MiSans').copyWith(
        popupMenuTheme: PopupMenuThemeData(
          position: PopupMenuPosition.under,
          color: FlexThemeData.dark(scheme: getFlexSchemeTheme(theme)).colorScheme.surfaceContainer,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
    );
  }

}