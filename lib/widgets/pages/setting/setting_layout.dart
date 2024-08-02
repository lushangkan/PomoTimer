import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pomotimer/routes/app_routes.dart';
import 'package:pomotimer/widgets/pages/app_page.dart';
import 'package:pomotimer/widgets/pages/home/click_listener.dart';
import 'package:pomotimer/widgets/pages/setting/Settings.dart';

import '../../../generated/l10n.dart';

class SettingPage extends AppPage {
  const SettingPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingPageState();
}

class _SettingPageState extends AppPageState<SettingPage> {
  @override
  Widget build(BuildContext context) {
    var themeColor = Theme.of(context).colorScheme.surface;

    return ClickListener(
        child: Scaffold(
      backgroundColor: themeColor,
      appBar: TopBar(Theme.of(context), context),
      body: const SettingBody(),
    ));
  }
}

class TopBar extends AppBar {
  TopBar(ThemeData theme, BuildContext context, {super.key})
      : super(
            backgroundColor: Colors.transparent,
            title: Text("设置", style: theme.textTheme.titleLarge,),
            leading: Container(
              margin: const EdgeInsets.only(left: 15),
              child: IconButton(
                iconSize: 25,
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  context.go('/');
                },
              ),
            ));
}

class SettingBody extends StatelessWidget {
  const SettingBody({super.key});

  @override
  Widget build(BuildContext context) {
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
                        print('Switch $key: $value');
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
                        print('Tile $key');
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
