import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pomotimer/common/logger.dart';
import 'package:pomotimer/common/permission_handle.dart';
import 'package:pomotimer/widgets/pages/home/timer_controller.dart';
import 'package:provider/provider.dart';

import '../../../../common/constants.dart';
import '../../../../common/enum/attribute.dart';
import '../../../../common/enum/reminder_type.dart';
import '../../../../states/app_states.dart';
import '../../../../states/timer_states.dart';
import '../../../button_dialog_inner.dart';
import '../attribute_selector.dart';
import '../attribute_switcher.dart';
import '../reminder_type_switcher.dart';
import '../start_button.dart';
import '../total_time_display.dart';

class InitialTimerController extends TimerController {
  const InitialTimerController({super.key});

  @override
  TimerControllerState createState() => _InitialTimerControllerState();

}

class _InitialTimerControllerState extends TimerControllerState {

  Phase selected = Phase.focus;

  Phase? phase;
  int? timeOfCurrentPhase;

  // 创建临时变量保存customTimes, 这个变量会在用户开始后保存到states和localstorage
  // 为了避免在用户选择时间后立即开始时, 保存的customTimes不是最新的
  late Map<Phase, int> _tmpCustomTimes;
  late ReminderType _tmpReminderType;

  @override
  void initState() {
    super.initState();

    // 从State复制customTimes
    var timerStates = context.read<TimerStates>();

    _tmpCustomTimes = timerStates.customTimes;
    _tmpReminderType = timerStates.reminderType!;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // 从State复制customTimes
    var timerStates = context.read<TimerStates>();
    var appStates = context.read<AppStates>();
    var timer = appStates.timer;

    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;

    Future<bool> showPermissionDialog() async {
      return await showBarModalBottomSheet(
          duration: const Duration(milliseconds: 200),
          barrierColor: Colors.black54,
          context: context,
          backgroundColor: colorScheme.background,
          builder: (context) {
            return const ButtonDialogInner(title: '需要权限', content: '启动计时器需要一些权限, 是否同意?',);
          }
      ) ?? false;
    }

    void onAttributeSwitcherSelected(Phase value) {
      setState(() {
        selected = value;
      });
    }

    void onAttributeSelectorSelected(int value) {
      setState(() {
        _tmpCustomTimes[selected] = value;
      });
    }

    void onReminderTypeSwitcherSelected(ReminderType value) {
      setState(() {
        _tmpReminderType = value;
      });
    }

    void onPressedStartButton() async {
      // 检查权限
      if (!permissionHandle.isTimerPermissionGranted) {
        // 未授权
        var result = await showPermissionDialog();

        if (result == true) {
          var granted = await permissionHandle.requestTimerPermission(context);

          if (!granted) {
            logger.t('User denied permission');
            return;
          }
        } else {
          logger.t('User denied permission');
          return;
        }
      }

      timer.setCustomTimes(_tmpCustomTimes);
      timer.setReminderType(_tmpReminderType);

      timer.startTimer();

      context.go('/in-progress');
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AttributeSwitcher(
          selected: selected,
          onSelected: onAttributeSwitcherSelected,
        ),
        AttributeSelector(
          selected: selected,
          customTimes: _tmpCustomTimes,
          onSelected: onAttributeSelectorSelected,
        ),
        SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TotalTimeDisplay(
                  customTimes: _tmpCustomTimes,
                  longBreakInterval: Constants.longBreakInterval),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: VerticalDivider(
                  color: theme.colorScheme.onBackground.withOpacity(0.3),
                  width: 1,
                ),
              ),
              ReminderTypeSwitcher(
                  reminderType: _tmpReminderType,
                  onSelected: onReminderTypeSwitcherSelected),
            ],
          ),
        ),
        StartButton(
          onPressed: onPressedStartButton,
        )
      ],
    );
  }
}