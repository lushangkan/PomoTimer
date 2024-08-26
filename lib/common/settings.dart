import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../generated/l10n.dart';
import '../main.dart';

class Settings {
  static const String language = 'language';
  static const String theme = 'theme';
  static const String darkMode = 'darkMode';
  static const String autoNext = 'autoNext';
  static const String ringtone = 'ringtone';
  static const String about = 'about';

  static final Map<String, Setting> settingMap = {
    language: Setting(
        icon: Icon(LucideIcons.globe, color: App.themeData!.colorScheme.onSurface),
        title: S.current.settingLanguageTitle,
        isSwitch: false),
    darkMode: Setting(
        icon: Icon(LucideIcons.moon, color: App.themeData!.colorScheme.onSurface),
        title: S.current.settingDarkModeTitle,
        isSwitch: false),
    theme: Setting(
        icon: Icon(LucideIcons.palette, color: App.themeData!.colorScheme.onSurface),
        title: S.current.settingThemeTitle,
        isSwitch: false),
    autoNext: Setting(
        icon: Icon(LucideIcons.refresh_ccw, color: App.themeData!.colorScheme.onSurface),
        title: S.current.settingAutoNextTitle,
        isSwitch: true),
    ringtone: Setting(
        icon: Icon(LucideIcons.bell_ring, color: App.themeData!.colorScheme.onSurface),
        title: S.current.settingRingtoneTitle,
        isSwitch: false),
    about: Setting(
        icon: Icon(LucideIcons.info, color: App.themeData!.colorScheme.onSurface),
        title: S.current.settingAboutTitle,
        isSwitch: false),
  };
}

class Setting {
  final Widget icon;
  final String title;
  final bool isSwitch;

  Setting({required this.icon, required this.title, required this.isSwitch});
}
