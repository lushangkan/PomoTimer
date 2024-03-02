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

class _TimerControllerState extends State<TimerController> {
  Attribute selected = Attribute.focus;
  var switchKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    var mainStates = context.watch<MainStates>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AttributeSwitcher(
          key: switchKey,
          selected: selected,
          onSelected: (selected) => setState(() {
            this.selected = selected;
          }),
        ),
        Builder(builder: (context) {
          if (mainStates.timerRunning == true) {
            return const TimeDisplay();
          } else {
            return AttributeSelector(selected: selected);
          }
        })
      ],
    );
  }
}