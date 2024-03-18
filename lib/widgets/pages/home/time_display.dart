import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:pomotimer/widgets/slider/app_circular_slider.dart';
import 'package:provider/provider.dart';

import '../../../common/enum/attribute.dart';
import '../../../common/utils/app_utils.dart';
import '../../../states/timer_states.dart';

class TimeDisplay extends StatefulWidget {
  const TimeDisplay({super.key, required this.phase, required this.timeOfCurrentPhase});

  final Phase phase;
  final int timeOfCurrentPhase;

  @override
  State<TimeDisplay> createState() => _TimeDisplayState();
}

class _TimeDisplayState extends State<TimeDisplay> {

  @override
  Widget build(BuildContext context) {
    var timerStates = context.watch<TimerStates>();

    const double min = 0;
    var max = ((timerStates.customTimes[widget.phase] ?? 0) * 60 * 1000).toDouble();

    return AppCircularSlider(value: widget.timeOfCurrentPhase.toDouble(), min: min, max: max, innerWidget: (_) => _TimeDisplayInner(timeOfCurrentPhase: widget.timeOfCurrentPhase, phase: widget.phase));
  }
}

class _TimeDisplayInner extends StatelessWidget {
  const _TimeDisplayInner({super.key, required this.timeOfCurrentPhase, required this.phase});

  final int timeOfCurrentPhase;
  final Phase phase;

  @override
  Widget build(BuildContext context) {

    var time = DateTime.fromMillisecondsSinceEpoch(timeOfCurrentPhase, isUtc: true);

    String languageCode = getAppLocal(context)!;

    var timeText = DateFormat.jms(languageCode).format(time);

    return Container(
      alignment: Alignment.center,
      child: Text(
          timeText
      ),
    );
  }

}