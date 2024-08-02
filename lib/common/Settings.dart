import 'package:flutter/cupertino.dart';

import '../generated/l10n.dart';

class Settings {
  static const String language = 'language';
  static const String theme = 'theme';
  static const String autoNext = 'autoNext';
  static const String ringtone = 'ringtone';
  static const String about = 'about';

  static final Map<String, Setting> settingMap = {
    language: Setting(
        icon: CupertinoIcons.globe,
        title: S.current.settingLanguageTitle,
        isSwitch: false),
    theme: Setting(
        icon: CupertinoIcons.paintbrush,
        title: S.current.settingThemeTitle,
        isSwitch: false),
    autoNext: Setting(
        icon: CupertinoIcons.arrow_right_arrow_left,
        title: S.current.settingAutoNextTitle,
        isSwitch: true),
    ringtone: Setting(
        icon: CupertinoIcons.bell,
        title: S.current.settingRingtoneTitle,
        isSwitch: false),
    about: Setting(
        icon: CupertinoIcons.info,
        title: S.current.settingAboutTitle,
        isSwitch: false),
  };
}

class Setting {
  final IconData icon;
  final String title;
  final bool isSwitch;

  Setting({required this.icon, required this.title, required this.isSwitch});
}
