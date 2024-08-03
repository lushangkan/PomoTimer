import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:has_audio/has_audio.dart';
import 'package:intl/intl.dart';
import 'package:pomotimer/common/permission_handle.dart';
import 'package:pomotimer/common/timer/timer.dart';
import 'package:pomotimer/main.dart';
import 'package:pomotimer/themes/default_theme.dart';
import '../../../common/preferences/preference_manager.dart';
import '../../../common/Settings.dart';
import '../../../generated/l10n.dart';


class SettingBody extends StatefulWidget {
  const SettingBody({super.key});

  @override
  State<SettingBody> createState() => _SettingBodyState();
}

class _SettingBodyState extends State<SettingBody> {

  late bool autoNext;

  @override
  void initState() {
    super.initState();

    autoNext = PreferenceManager.instance.autoNext;
  }

  @override
  Widget build(BuildContext context) {
    void showSettingDialog(Widget widget) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return widget;
        },
      );
    }

    void autoNextChanged(bool value) {
      setState(() {
        autoNext = value;
      });
      PreferenceManager.instance.autoNext = value;
    }

    void onRingtoneTapFromStorage() async {
      if (!(await PermissionHandle.instance.isStoragePermissionGranted)) {
        var result = await PermissionHandle.instance.requestStoragePermission(context);

        if (!result) {
          // SnackBar提示用户
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('未授予权限'),
            duration: Duration(seconds: 2),
          ));
          return;
        }
      }

      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result == null) {
        // SnackBar提示用户
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('未选择文件'),
          duration: Duration(seconds: 2),
        ));
        return;
      }

      File file = File(result.files.single.path!);

      bool hasAudio = await HasAudio.check(file.path);

      if (!hasAudio) {
        // SnackBar提示用户
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('文件不含有音频'),
          duration: Duration(seconds: 2),
        ));
        return;
      }

      PreferenceManager.instance.ringtonePath = file.path;
    }

    var handler = {
      Settings.language: () {
        showSettingDialog(const LanguageDialog());
      },
      Settings.theme: () {
        showSettingDialog(const ThemeDialog());
      },
      Settings.darkMode: () {
        showSettingDialog(const DarkModeDialog());
      },
      Settings.autoNext: (bool value) {
        autoNextChanged(value);
      },
      Settings.ringtone: () {
        showSettingDialog(RingtoneDialog(onTapFromStorage: onRingtoneTapFromStorage,));
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

                if (setting.isSwitch && key == Settings.autoNext) {
                  return PreferenceSwitchTile(
                    icon: setting.icon,
                    title: setting.title,
                    switchValue: autoNext,
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
            selected: PreferenceManager.instance.language == null,
            title: const Text('跟随系统'),
            onTap: () {
              setLanguage(null);
            },
          ),
          ListTile(
            selected: PreferenceManager.instance.language == 'zh',
            title: const Text('简体中文'),
            onTap: () {
              setLanguage('zh');
            },
          ),
          ListTile(
            selected: PreferenceManager.instance.language == 'en',
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

class DarkModeDialog extends StatelessWidget {
  // 始终关闭, 始终开启, 跟随系统
  const DarkModeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    void setDarkMode(int darkMode) {
      if (PreferenceManager.instance.themeMode == darkMode) {
        Navigator.pop(context);
        return;
      }

      PreferenceManager.instance.themeMode = darkMode;

      ScaffoldMessenger.of(context).showSnackBar(RestartAppSnackBar(S.current.settingRequestRestart));
      Navigator.pop(context);
    }

    return AlertDialog(
      title: const Text('选择主题'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            selected: PreferenceManager.instance.themeMode == 1,
            title: const Text('始终关闭'),
            onTap: () {
              setDarkMode(1);
            },
          ),
          ListTile(
            selected: PreferenceManager.instance.themeMode == 2,
            title: const Text('始终开启'),
            onTap: () {
              setDarkMode(2);
            },
          ),
          ListTile(
            selected: PreferenceManager.instance.themeMode == 0,
            title: const Text('跟随系统'),
            onTap: () {
              setDarkMode(0);
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

class ThemeDialog extends StatelessWidget {
  const ThemeDialog({super.key});

  String toUnderscore(String name) {
    final exp = RegExp('(?<=[a-z])[A-Z]');
    return name.replaceAllMapped(exp, (m) => '_${m.group(0)}').toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    var children = FlexScheme.values.map((scheme) {
      return ListTile(
        selected: PreferenceManager.instance.themeName == scheme.name,
        leading: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: FlexColorScheme.light(scheme: scheme).primary,
              borderRadius: BorderRadius.circular(2),
            )
        ),
        title: Text(toUnderscore(scheme.name)),
        onTap: () {
          PreferenceManager.instance.themeName = scheme.name;

          ScaffoldMessenger.of(context).showSnackBar(RestartAppSnackBar(S.current.settingRequestRestart));
          Navigator.pop(context);
        },
      );
    }).toList();

    children.insert(0, ListTile(
      selected: PreferenceManager.instance.themeName == null,
      leading: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: defThemeLight.colorScheme.primary,
            borderRadius: BorderRadius.circular(2),
          )
      ),
      title: const Text('默认'),
      onTap: () {
        PreferenceManager.instance.themeName = null;

        ScaffoldMessenger.of(context).showSnackBar(RestartAppSnackBar(S.current.settingRequestRestart));
        Navigator.pop(context);
      },
    ));

    return AlertDialog(
      title: const Text('选择主题'),
      content: SizedBox(
        height: 600,
        width: 300,
        child: ListView(
          children: children
        ),
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

class RingtoneDialog extends StatelessWidget {
  const RingtoneDialog({super.key, required this.onTapFromStorage});

  final Function() onTapFromStorage;

  @override
  Widget build(BuildContext context) {
    AppTimer timer = AppTimer.instance;

    return AlertDialog(
      title: const Text('选择铃声'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            selected: PreferenceManager.instance.ringtonePath == null,
            title: const Text('默认'),
            onTap: () {
              if (PreferenceManager.instance.ringtonePath == null) {
                Navigator.pop(context);
                return;
              }

              PreferenceManager.instance.ringtonePath = null;
              timer.ringtoneChanged();

              Navigator.pop(context);
            },
          ),
          ListTile(
            selected: PreferenceManager.instance.ringtonePath != null,
            title: const Text('从存储中选择'),
            onTap: () {
              Navigator.pop(context);

              onTapFromStorage();
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