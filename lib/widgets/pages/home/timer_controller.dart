import 'package:flutter/material.dart';
import 'package:pomotimer/widgets/pages/home/time_display.dart';
import 'package:provider/provider.dart';

import '../../../common/attribute.dart';
import '../../../states/main_states.dart';
import 'attribute_selector.dart';
import 'attribute_switcher.dart';

class TimerController extends StatefulWidget {
  const TimerController({super.key});

  @override
  State<StatefulWidget> createState() => _TimerControllerState();
}

class _TimerControllerState extends State<TimerController> with AutomaticKeepAliveClientMixin {
  Attribute selected = Attribute.focus;

  // 创建临时变量保存customTimes, 这个变量会在用户开始后保存到states和localstorage
  // 为了避免在用户选择时间后立即开始时, 保存的customTimes不是最新的
  late Map<Attribute, int> tmpCustomTimes;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    // 从State复制customTimes
    var mainStates = context.read<MainStates>();
    tmpCustomTimes = mainStates.customTimes;
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
          onSelected: (selected) => setState(() {
            this.selected = selected;
          }),
        ),
        Builder(builder: (context) {
          if (mainStates.timerRunning == true) {
            return const TimeDisplay();
          } else {
            return AttributeSelector(selected: selected, customTimes: tmpCustomTimes, onSelected: (int value) {
              setState(() {
                tmpCustomTimes[selected] = value;
              });
            },);
          }
        })
      ],
    );
  }
}