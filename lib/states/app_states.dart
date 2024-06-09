import 'package:flutter/widgets.dart';
import 'package:pomotimer/states/timer_states.dart';

import '../common/timer/timer.dart';

class AppStates extends ChangeNotifier {
  late final AppTimer timer;

  AppLifecycleState? appLifecycleState;

  AppStates(TimerStates timerStates) {
    timer = AppTimer(timerStates, this);
  }


}