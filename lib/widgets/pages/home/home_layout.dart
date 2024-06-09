import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:pomotimer/widgets/pages/home/app_page.dart';
import 'package:pomotimer/widgets/pages/home/click_listener.dart';
import 'package:pomotimer/widgets/pages/home/timer_controller.dart';

import '../../../common/utils/debug_utils.dart';
import '../../../generated/l10n.dart';
import '../../debugging/debugging_tools.dart';

class HomePage extends AppPage {
  const HomePage({super.key, required this.timerController});

  final TimerController timerController;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends AppPageState<HomePage>  {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return ClickListener(
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: TopBar(theme),
        body: HomeBody(timerController: widget.timerController,),
      ),
    );
  }
}

class TopBar extends AppBar {
  TopBar(ThemeData theme, {super.key})
      : super(
            backgroundColor: Colors.transparent,
            actions: [
              if (isDebugMode) Container(padding: const EdgeInsets.only(right: 15),child: const DebuggingTools()),
            ],
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
  const HomeBody({super.key, required this.timerController});

  final TimerController timerController;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      child: Center(
        child: Container(
            constraints: const BoxConstraints(maxWidth: 300, maxHeight: 600),
            child: timerController),
      ),
    );
  }
}

// TODO: 专注次数显示
