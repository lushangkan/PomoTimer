import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/app_text_style.dart';
import '../../../common/constants.dart';
import '../../../common/enum/attribute.dart';
import '../../../states/timer_states.dart';
import '../../slider/app_circular_slider.dart';

class AttributeSelector extends StatelessWidget {
  const AttributeSelector({super.key, required this.selected, required this.customTimes, required this.onSelected, });

  final Phase selected;
  final Map<Phase, int> customTimes;
  final Function(int) onSelected;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    var timerStates = context.watch<TimerStates>();

    const double sliderSize = 238;
    const double progressBarWidth = 32;
    const double innerSize = sliderSize - progressBarWidth * 2;

    return AppCircularSlider(
      min: Constants.timeRange[selected]!.$1.toDouble(),
      max: Constants.timeRange[selected]!.$2.toDouble(),
      value: customTimes[selected]!.toDouble(),
      animationEnabled: timerStates.timerRunning == false,
      innerWidget: (double value) => CircularSliderInner(size: innerSize, minute: value.round(), selected: selected),
      onChange: (double value) {
        onSelected(value.round());
      }
    );
  }
}

class CircularSliderInner extends StatelessWidget {
  const CircularSliderInner({super.key, required this.size, required this.minute, required this.selected});

  final double size;
  final int minute;
  final Phase selected;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    TextStyle? textTheme = AppTextStyle.generateWithTextStyle(theme.textTheme.headlineMedium!.copyWith(
        fontWeight: FontWeight.w400
    ));

    TextStyle? recTextStyle = AppTextStyle.generateWithTextStyle(theme.textTheme.bodySmall!.copyWith(
      fontWeight: FontWeight.w200,
      fontSize: 11,
    ));

    int recTimeMinute = (Constants.defaultTime[selected]!).floor();

    var showMinute = minute < 10 ? '0$minute' : '$minute';
    var showSecond = '00';

    var showText = '$showMinute:$showSecond';
    var recText = '推荐设置为$recTimeMinute分钟';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          showText,
          style: textTheme,
        ),
        Text(
          recText,
          style: recTextStyle,
        )
      ],
    );
  }

}




