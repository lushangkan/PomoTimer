import 'package:flutter/material.dart';
import 'package:pomotimer/common/constants.dart';
import 'package:pomotimer/common/enum/reminder_type.dart';
import 'package:pomotimer/widgets/pages/home/reminder_type_switcher.dart';
import 'package:pomotimer/widgets/pages/home/start_button.dart';
import 'package:pomotimer/widgets/pages/home/time_display.dart';
import 'package:pomotimer/widgets/pages/home/total_time_display.dart';
import 'package:provider/provider.dart';

import '../../../common/enum/attribute.dart';
import '../../../states/main_states.dart';
import 'attribute_selector.dart';
import 'attribute_switcher.dart';

class TimerController extends StatefulWidget {
  const TimerController({super.key});

  @override
  State<StatefulWidget> createState() => _TimerControllerState();
}

class _TimerControllerState extends State<TimerController>
    with AutomaticKeepAliveClientMixin {
  Attribute selected = Attribute.focus;

  // 创建临时变量保存customTimes, 这个变量会在用户开始后保存到states和localstorage
  // 为了避免在用户选择时间后立即开始时, 保存的customTimes不是最新的
  late Map<Attribute, int> tmpCustomTimes;
  late ReminderType tmpReminderType;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    // 从State复制customTimes
    var mainStates = context.read<MainStates>();
    tmpCustomTimes = mainStates.customTimes;
    tmpReminderType = mainStates.reminderType!;
  }

  void _onAttributeSwitcherSelected(Attribute value) {
    setState(() {
      selected = value;
    });
  }

  void _onAttributeSelectorSelected(int value) {
    setState(() {
      tmpCustomTimes[selected] = value;
    });
  }

  void _onReminderTypeSwitcherSelected(ReminderType value) {
    setState(() {
      tmpReminderType = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    var theme = Theme.of(context);

    var mainStates = context.watch<MainStates>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AttributeSwitcher(
          selected: selected,
          onSelected: _onAttributeSwitcherSelected,
        ),
        Builder(builder: (context) {
          if (mainStates.timerRunning == true) {
            return const TimeDisplay();
          } else {
            return AttributeSelector(
              selected: selected,
              customTimes: tmpCustomTimes,
              onSelected: _onAttributeSelectorSelected,
            );
          }
        }),
        SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TotalTimeDisplay(
                  customTimes: tmpCustomTimes,
                  longBreakInterval: Constants.longBreakInterval),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: VerticalDivider(
                  color: theme.colorScheme.onBackground.withOpacity(0.3),
                  width: 1,
                ),
              ),
              ReminderTypeSwitcher(
                  reminderType: tmpReminderType,
                  onSelected: _onReminderTypeSwitcherSelected),
            ],
          ),
        ),
        const StartButton()
      ],
    );
  }
}
