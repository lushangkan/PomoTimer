import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pomotimer/common/constants.dart';
import 'package:pomotimer/common/enum/reminder_type.dart';
import 'package:pomotimer/common/event_bus.dart';
import 'package:pomotimer/common/events.dart';
import 'package:pomotimer/widgets/pages/home/reminder_type_switcher.dart';
import 'package:pomotimer/widgets/pages/home/start_button.dart';
import 'package:pomotimer/widgets/pages/home/time_display.dart';
import 'package:pomotimer/widgets/pages/home/total_time_display.dart';
import 'package:provider/provider.dart';

import '../../../common/enum/attribute.dart';
import '../../../states/app_states.dart';
import '../../../states/timer_states.dart';
import 'attribute_selector.dart';
import 'attribute_switcher.dart';

class TimerController extends StatefulWidget {
  const TimerController({super.key});

  @override
  State<StatefulWidget> createState() => _TimerControllerState();
}

class _TimerControllerState extends State<TimerController>
    with AutomaticKeepAliveClientMixin {
  Phase selected = Phase.focus;

  // 创建临时变量保存customTimes, 这个变量会在用户开始后保存到states和localstorage
  // 为了避免在用户选择时间后立即开始时, 保存的customTimes不是最新的
  late Map<Phase, int> _tmpCustomTimes;
  late ReminderType _tmpReminderType;

  late StreamSubscription<TimerPhaseChangeEvent> _timerPhaseChangeEventSubscription;

  void onTimerPhaseChanged(TimerPhaseChangeEvent event) {
    setState(() {
      selected = event.phase;
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    // 从State复制customTimes
    var timerStates = context.read<TimerStates>();
    _tmpCustomTimes = timerStates.customTimes;
    _tmpReminderType = timerStates.reminderType!;

    // 监听事件
    _timerPhaseChangeEventSubscription = eventBus.on<TimerPhaseChangeEvent>().listen(onTimerPhaseChanged);
  }

  @override
  void dispose() {
    super.dispose();

    // 卸载监听器
    _timerPhaseChangeEventSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    var theme = Theme.of(context);

    var timerStates = context.watch<TimerStates>();
    var appStates = context.watch<AppStates>();
    var timer = appStates.timer;

    void onAttributeSwitcherSelected(Phase value) {
      // 如果计时器正在运行, 则不允许切换
      if (timerStates.timerRunning == true) return;

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

    void onPressedStartButton() {
      timer.startTimer();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AttributeSwitcher(
          selected: selected,
          onSelected: onAttributeSwitcherSelected,
        ),
        if (timerStates.timerRunning == true)
          const TimeDisplay()
        else
          AttributeSelector(
            selected: selected,
            customTimes: _tmpCustomTimes,
            onSelected: onAttributeSelectorSelected,
          ),
        if (timerStates.timerRunning == false)
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
        if (timerStates.timerRunning == false)
          StartButton(
            onPressed: onPressedStartButton,
          )
        else
          const SizedBox(height: 60),
      ],
    );
  }
}
