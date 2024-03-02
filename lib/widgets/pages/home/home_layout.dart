import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:pomotimer/widgets/pages/home/timer_controller.dart';

import '../../../generated/l10n.dart';



class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: TopBar(theme),
      body: const HomeBody(),
    );
  }
}

class TopBar extends AppBar {
  TopBar(ThemeData theme, {super.key})
      : super(
            backgroundColor: Colors.transparent,
            leading: Container(
              margin: const EdgeInsets.only(left: 15),
              child: IconButton(
                iconSize: 25,
                tooltip: S.current.settingBtnTooltip,
                icon: Icon(LucideIcons.settings,
                    color: theme.colorScheme.onBackground),
                onPressed: () {
                  // TODO 跳转到设置
                },
              ),
            ));
}

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      child: Center(
        child: Container(
            constraints: const BoxConstraints.tightFor(width: 300, height: 500),
            child: const TimerController()),
      ),
    );
  }
}





// TODO: 专注次数显示

