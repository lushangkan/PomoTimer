
import 'package:pomotimer/common/timer/timer.dart';

import 'enum/attribute.dart';

/// 计时器事件
class TimerEvent {

}

/// 计时器时间更新事件
/// @elapsedTime 已经经过的时间
/// @timer 计时器
class TimerTickEvent extends TimerEvent {
  final int elapsedTime;
  final AppTimer timer;

  TimerTickEvent(this.elapsedTime, this.timer);
}

/// 计时器状态改变事件
/// @timer 计时器
/// @phase 改变后的阶段
class TimerPhaseChangeEvent extends TimerEvent {
  final Phase phase;
  final AppTimer timer;

  TimerPhaseChangeEvent(this.phase, this.timer);
}