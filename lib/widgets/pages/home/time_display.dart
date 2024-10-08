import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pomotimer/common/constants.dart';
import 'package:pomotimer/widgets/slider/app_circular_slider.dart';
import 'package:provider/provider.dart';

import '../../../common/app_text_style.dart';
import '../../../common/enum/attribute.dart';
import '../../../common/utils/app_utils.dart';
import '../../../generated/l10n.dart';
import '../../../states/timer_states.dart';

class TimeDisplay extends StatelessWidget {
  const TimeDisplay(
      {super.key, required this.phase, required this.timeOfCurrentPhase, required this.smallCyclesCompleted});

  final Phase phase;
  final int timeOfCurrentPhase;
  final int smallCyclesCompleted;


  @override
  Widget build(BuildContext context) {
    var timerStates = context.watch<TimerStates>();

    const double min = 0;
    var max =
    ((timerStates.customTimes[phase] ?? 0) * 60 * 1000).toDouble();

    return AppCircularSlider(
        value: timeOfCurrentPhase.toDouble(),
        min: min,
        max: max,
        animationEnabled: timerStates.timerRunning == false, // TODO: 待提Issue，如果运行时启用动画，运行半小时后会卡顿，每3秒一帧
        innerWidget: (_) => _TimeDisplayInner(
          timeOfCurrentPhase: timeOfCurrentPhase,
          phase: phase,
          smallCyclesCompleted: smallCyclesCompleted,
        ));
  }
}

class _TimeDisplayInner extends StatelessWidget {
  const _TimeDisplayInner(
      {required this.timeOfCurrentPhase, required this.phase, required this.smallCyclesCompleted});

  final int timeOfCurrentPhase;
  final Phase phase;
  final int smallCyclesCompleted;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    var time =
        DateTime.fromMillisecondsSinceEpoch(timeOfCurrentPhase, isUtc: true);

    TextStyle? textTheme = AppTextStyle.generateWithTextStyle(theme.textTheme.headlineMedium!.copyWith(
        fontWeight: FontWeight.w400
    ));

    TextStyle? cyclesTextStyle = AppTextStyle.generateWithTextStyle(theme.textTheme.bodySmall!.copyWith(
      fontWeight: FontWeight.w200,
      fontSize: 11,
    ));

    String? languageCode = getAppLocal(context);

    String timeText;

    if (languageCode == null) {
      timeText = DateFormat.ms().format(time);
    } else {
      timeText = DateFormat.ms(languageCode).format(time);
    }


    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(timeText, style: textTheme,),
          Text("${S.current.phase} $smallCyclesCompleted / ${Constants.longBreakInterval}", style: cyclesTextStyle,)
        ],
      ),
    );
  }
}
