import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:pomotimer/common/event/event_bus.dart';
import 'package:pomotimer/common/event/events.dart';
import 'package:pomotimer/widgets/pages/home/fast_forward_button.dart';
import 'package:pomotimer/widgets/pages/home/pause_button.dart';
import 'package:pomotimer/widgets/pages/home/stop_button.dart';
import 'package:pomotimer/widgets/pages/home/time_display.dart';
import 'package:pomotimer/widgets/pages/home/timer_controller.dart';
import 'package:pomotimer/widgets/pages/home/total_progress_indicator.dart';
import 'package:provider/provider.dart';

import '../../../../common/enum/attribute.dart';
import '../../../../common/timer/timer.dart';
import '../../../../states/timer_states.dart';
import '../attribute_switcher.dart';
import '../resume_button.dart';

class InProgressTimeController extends TimerController {
  const InProgressTimeController({super.key});

  @override
  InProgressTimeControllerState createState() =>
      InProgressTimeControllerState();
}

class InProgressTimeControllerState extends TimerControllerState  {
  Phase? phase;
  int? timeOfCurrentPhase;
  int? smallCyclesCompleted;

  late bool isTimerStop;

  late StreamSubscription<TimerPhaseChangeEvent>
      _timerPhaseChangeEventSubscription;
  late StreamSubscription<TimerTickEvent> _timerTickSubscription;
  late StreamSubscription<TimerStopEvent> _timeStopEventSubscription;

  void onTimerTick(TimerTickEvent event) {
    if (isTimerStop) return;

    setState(() {
      timeOfCurrentPhase = event.timeOfCurrentPhase;
    });
  }

  void onTimerPhaseChanged(TimerPhaseChangeEvent event) {
    if (isTimerStop) return;

    setState(() {
      phase = event.phase;
      smallCyclesCompleted = event.smallCyclesCompleted;
    });
  }

  void onTimerStop(TimerStopEvent event) {
    isTimerStop = true;
    reset();

    if (mounted) context.go('/');
  }

  void reset() {
    setState(() {
      phase = null;
      timeOfCurrentPhase = null;
      smallCyclesCompleted = null;
    });
  }

  @override
  void initState() {
    super.initState();

    var timerStates = context.read<TimerStates>();
    var timer = AppTimer.instance;

    isTimerStop = false;
    reset();

    // 更新时间
    if (timerStates.timerRunning == true) {
      var (phase, timeOfCurrentPhase, smallCyclesCompleted) =
          timer.getCurrentPhase ?? (null, null, null);
      this.phase = phase!;
      this.timeOfCurrentPhase =
          timerStates.customTimes[phase]! * 60 * 1000 - timeOfCurrentPhase!;
      this.smallCyclesCompleted = smallCyclesCompleted;
    }

    // 监听事件
    _timerPhaseChangeEventSubscription =
        eventBus.on<TimerPhaseChangeEvent>().listen(onTimerPhaseChanged);
    _timerTickSubscription = eventBus.on<TimerTickEvent>().listen(onTimerTick);
    _timeStopEventSubscription =
        eventBus.on<TimerStopEvent>().listen(onTimerStop);
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

    var timer = AppTimer.instance;

    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        TotalProgressIndicator(
            elapsedTime: timer.elapsedTime ?? 0,
            totalTime: timer.totalTime!),
        Center(
          child: Container(
            constraints: const BoxConstraints(maxHeight: 580),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AttributeSwitcher(
                  selected: phase ?? Phase.focus,
                ),
                Hero(
                  tag: 'time',
                  child: TimeDisplay(
                    phase: phase ?? Phase.focus,
                    timeOfCurrentPhase: timeOfCurrentPhase ?? 0,
                    smallCyclesCompleted: smallCyclesCompleted ?? 0,
                  ),
                ),
                const ControlButtons()
              ],
            ),
          ),
        )
      ],
    );
  }
}

class ControlButtons extends StatelessWidget {
  const ControlButtons({super.key});

  @override
  Widget build(BuildContext context) {
    var timer = AppTimer.instance;
    context.watch<TimerStates>();

    void onPressStopButton() {
      timer.stop();
    }

    void onPressFastForwardButton() {
      if (timer.isPausing) {
        return;
      }
      timer.fastForwardToNextPhase();
    }

    void onPressPauseButton() {
      timer.pause();
    }

    void onPressResumeButton() {
      timer.resume();
    }

    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!timer.isPausing)
            PauseButton(onPressed: onPressPauseButton)
          else
            ResumeButton(
              onPressed: onPressResumeButton,
            ),
          Hero(
            tag: 'control_button',
            child: StopButton(
              onPressed: onPressStopButton,
            ),
          ),
          Opacity(
              opacity: timer.isPausing ? 0 : 1,
              child: FastForwardButton(
                onPressed: onPressFastForwardButton,
              ))
        ],
      ),
    );
  }
}
