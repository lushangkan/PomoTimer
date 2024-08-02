import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pomotimer/main.dart';
import '../../../common/preferences/preference_manager.dart';
import '../../../common/Settings.dart';
import '../../../generated/l10n.dart';


class SettingBody extends StatelessWidget {
  const SettingBody({super.key});

  @override
  Widget build(BuildContext context) {
    void showLanguageDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const LanguageDialog();
        },
      );
    }

    var handler = {
      Settings.language: () {
        showLanguageDialog();
      },
      Settings.theme: () {
        print('Theme');
      },
      Settings.darkMode: () {
        print('DarkMode');
      },
      Settings.autoNext: (bool value) {
        print('AutoNext: $value');
      },
      Settings.ringtone: () {
        print('Ringtone');
      },
      Settings.about: () {
        print('About');
      },
    };

    return Column(
      children: [
        const Divider(),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Column(
              // 遍历settingMap，生成对应的PreferenceTile或PreferenceSwitchTile
              children: Settings.settingMap.entries.map((entry) {
                var key = entry.key;
                var setting = entry.value;

                if (setting.isSwitch) {
                  return PreferenceSwitchTile(
                    icon: setting.icon,
                    title: setting.title,
                    switchValue: false,
                    onSwitchChanged: (String key, bool value) {
                      return (bool value) {
                        handler[key]!(value);
                      };
                    },
                    tileKey: key,
                  );
                } else {
                  return PreferenceTile(
                    icon: setting.icon,
                    title: setting.title,
                    onPressed: (String key) {
                      return () {
                        handler[key]!();
                      };
                    },
                    tileKey: key,
                  );
                }
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class SettingDivider extends StatelessWidget {
  const SettingDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1,
      thickness: 0.5,
    );
  }
}

class PreferenceTile extends StatelessWidget {
  // icon, title
  const PreferenceTile({super.key, required this.icon, required this.title, required this.onPressed, required this.tileKey});

  final IconData icon;
  final String title;
  final Function(String) onPressed;
  final String tileKey;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      onPressed: onPressed(tileKey),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
      ),
    );
  }
}

class PreferenceSwitchTile extends StatelessWidget {
  // icon, title, switchValue, onSwitchChanged
  const PreferenceSwitchTile({super.key, required this.icon, required this.title, required this.switchValue, required this.onSwitchChanged, required this.tileKey});

  final IconData icon;
  final String title;
  final bool switchValue;
  final Function(String, bool) onSwitchChanged;
  final String tileKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: Switch(
          value: switchValue,
          onChanged: onSwitchChanged(tileKey, switchValue),
        ),
      ),
    );
  }
}

class LanguageDialog extends StatelessWidget {
  const LanguageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    void setLanguage(String? language) {
      if (PreferenceManager.instance.language == language) {
        Navigator.pop(context);
        return;
      }
      PreferenceManager.instance.language = language;

      String text;
      if (language == null) {
        S.load(Locale(Platform.localeName));
        text = S.current.settingRequestRestart;
      } else {
        S.load(Locale(language));
        text = S.current.settingRequestRestart;
      }

      ScaffoldMessenger.of(context).showSnackBar(RestartAppSnackBar(text));
      Navigator.pop(context);
    }

    return AlertDialog(
      title: const Text('选择语言'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('跟随系统'),
            onTap: () {
              setLanguage(null);
            },
          ),
          ListTile(
            title: const Text('简体中文'),
            onTap: () {
              setLanguage('zh');
            },
          ),
          ListTile(
            title: const Text('English'),
            onTap: () {
              setLanguage('en');
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('取消'),
        ),
      ],
    );
  }
}

class RestartAppSnackBar extends SnackBar {
  RestartAppSnackBar(String content, {super.key})
      : super(
          content: Text(content),
          duration: const Duration(seconds: 2),
        );
}