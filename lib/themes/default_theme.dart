import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';

final buttonTheme = ButtonThemeData(
  textTheme: ButtonTextTheme.normal,
  highlightColor: fromCssColor('#ebe6da'),
  splashColor: fromCssColor('#ebe6da'),
  hoverColor: fromCssColor('#ebe6da'),
);

final defThemeLight = ThemeData(
    useMaterial3: true,
    colorScheme: _defColorSchemeLight,
    fontFamily: 'MiSans',
    highlightColor: fromCssColor('#ebe6da'),
    splashColor: fromCssColor('#ebe6da'),
    hoverColor: fromCssColor('#ebe6da'),
    buttonTheme: buttonTheme,
    scaffoldBackgroundColor: fromCssColor("#FDF7F2"),
    popupMenuTheme: PopupMenuThemeData(
      position: PopupMenuPosition.under,
      color: _defColorSchemeLight.surfaceContainer,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ));

final defThemeDark = ThemeData(
    useMaterial3: true,
    colorScheme: _defColorSchemeDark,
    fontFamily: 'MiSans',
    highlightColor: fromCssColor('#ebe6da'),
    splashColor: fromCssColor('#ebe6da'),
    hoverColor: fromCssColor('#ebe6da'),
    buttonTheme: buttonTheme,
    popupMenuTheme: PopupMenuThemeData(
      position: PopupMenuPosition.under,
      color: _defColorSchemeDark.surfaceContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ));

final _defColorSchemeLight = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: fromCssColor('#FFB366'),
  primary: fromCssColor('#FFB366'),
  onPrimary: fromCssColor('#935606'),
  primaryContainer: fromCssColor('#FFC488'),
  onPrimaryContainer: fromCssColor('#333333'),
  secondary: fromCssColor('#FF8C00'),
  onSecondary: fromCssColor('#FFFFFF'),
  secondaryContainer: fromCssColor('#FFC277'),
  onSecondaryContainer: fromCssColor('#333333'),
  tertiary: fromCssColor('#B5DDE3'),
  onTertiary: fromCssColor('#333333'),
  tertiaryContainer: fromCssColor('#DAEEF1'),
  onTertiaryContainer: fromCssColor('#333333'),
  error: fromCssColor('#FF6B81'),
  onError: fromCssColor('#FFFFFF'),
  errorContainer: fromCssColor('#FFE8E1'),
  onErrorContainer: fromCssColor('#333333'),
  surface: fromCssColor('#F5F0E4'),
  onSurface: fromCssColor('#5c5c5c'),
  surfaceContainer: fromCssColor('#FFEEDD'),
  surfaceContainerLow: fromCssColor('#f7f5f0'),
  surfaceContainerLowest: fromCssColor('#fdfcfb'),
  surfaceContainerHigh: fromCssColor('#a99461'),
  onSurfaceVariant: fromCssColor('#5c5c5c'),
);

final _defColorSchemeDark = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: fromCssColor('#FFB366'),
  primary: fromCssColor('#FFB366'),
  onPrimary: fromCssColor('#ffffa1'),
  primaryContainer: fromCssColor('#EE7800'),
  onPrimaryContainer: fromCssColor('#FFFFFF'),
  secondary: fromCssColor('#FF8C00'),
  onSecondary: fromCssColor('#1A1A1A'),
  secondaryContainer: fromCssColor('#DD7A00'),
  onSecondaryContainer: fromCssColor('#FFFFFF'),
  tertiary: fromCssColor('#B5DDE3'),
  onTertiary: fromCssColor('#1A1A1A'),
  tertiaryContainer: fromCssColor('#5FB5C2'),
  onTertiaryContainer: fromCssColor('#1A1A1A'),
  error: fromCssColor('#FF6B81'),
  onError: fromCssColor('#1A1A1A'),
  errorContainer: fromCssColor('#AF001A'),
  onErrorContainer: fromCssColor('#FFFFFF'),
  surface: fromCssColor('#1A1A1A'),
  onSurface: fromCssColor('#5c5c5c'),
  surfaceContainer: fromCssColor('#ebe6da'),
  surfaceContainerLow: fromCssColor('#f7f5f0'),
  surfaceContainerLowest: fromCssColor('#fdfcfb'),
  surfaceContainerHigh: fromCssColor('#a99461'),
  onSurfaceVariant: fromCssColor('#5c5c5c'),
);
