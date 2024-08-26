import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pomotimer/widgets/pages/app_page.dart';
import 'package:pomotimer/widgets/pages/home/click_listener.dart';
import 'package:pomotimer/widgets/pages/setting/setting_body.dart';

import '../../../generated/l10n.dart';

class SettingPage extends AppPage {
  const SettingPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingPageState();
}

class _SettingPageState extends AppPageState<SettingPage> {
  @override
  Widget build(BuildContext context) {
    var themeColor = Theme.of(context).scaffoldBackgroundColor;

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
            title: Text(S.current.setting, style: theme.textTheme.titleLarge,),
            leading: Container(
              margin: const EdgeInsets.only(left: 15),
              child: IconButton(
                iconSize: 25,
                icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface,),
                onPressed: () {
                  context.go('/');
                },
              ),
            ));
}
