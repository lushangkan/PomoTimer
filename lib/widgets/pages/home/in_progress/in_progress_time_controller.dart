import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pomotimer/common/event_bus.dart';
import 'package:pomotimer/common/events.dart';
import 'package:pomotimer/widgets/pages/home/time_display.dart';
import 'package:pomotimer/widgets/pages/home/timer_controller.dart';
import 'package:provider/provider.dart';

import '../../../../common/enum/attribute.dart';
import '../../../../states/app_states.dart';
import '../../../../states/timer_states.dart';
import '../attribute_switcher.dart';

class InProgressTimeController extends TimerController {
  const InProgressTimeController({super.key});

  @override
  InProgressTimeControllerState createState() =>
      InProgressTimeControllerState();
}

class InProgressTimeControllerState extends TimerControllerState {
  Phase selected = Phase.focus;

  Phase? phase;
  int? timeOfCurrentPhase;

  late StreamSubscription<TimerPhaseChangeEvent>
      _timerPhaseChangeEventSubscription;
  late StreamSubscription<TimerTickEvent> _timerTickSubscription;
  late StreamSubscription<TimerStopEvent> _timeStopEventSubscription;

  void onTimerTick(TimerTickEvent event) {
    setState(() {
      timeOfCurrentPhase = event.timeOfCurrentPhase;
    });
  }

  void onTimerPhaseChanged(TimerPhaseChangeEvent event) {
    setState(() {
      phase = event.phase;
    });
  }

  void onTimerStop(TimerStopEvent event) {
    reset();

    context.go('/');
  }

  void reset() {
    setState(() {
      phase = null;
      timeOfCurrentPhase = null;
    });
  }

  @override
  void initState() {
    super.initState();

    var timerStates = context.read<TimerStates>();
    var appStates = context.read<AppStates>();
    var timer = appStates.timer;

    reset();

    // 更新时间
    if (timerStates.timerRunning == true) {
      var (phase, timeOfCurrentPhase) = timer.getCurrentPhase ?? (null, null);
      this.phase = phase!;
      this.timeOfCurrentPhase = timerStates.customTimes[phase]! * 60 * 1000 - timeOfCurrentPhase!;
    }

    // 监听事件
    _timerPhaseChangeEventSubscription = eventBus.on<TimerPhaseChangeEvent>().listen(onTimerPhaseChanged);
    _timerTickSubscription = eventBus.on<TimerTickEvent>().listen(onTimerTick);
    _timeStopEventSubscription = eventBus.on<TimerStopEvent>().listen(onTimerStop);
  }

  @override
  void dispose() {
    // 卸载监听器
    _timerPhaseChangeEventSubscription.cancel();
    _timerTickSubscription.cancel();
    _timeStopEventSubscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (phase == null || timeOfCurrentPhase == null) {
      return const SizedBox();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AttributeSwitcher(
          selected: phase!,
        ),
        TimeDisplay(
          phase: phase!,
          timeOfCurrentPhase: timeOfCurrentPhase!,
        ),
        const SizedBox(height: 60),
      ],
    );
  }
}
