import 'dart:async';

import 'enum/attribute.dart';

/// 计时器事件
class TimerEvent {

}

/// 计时器时间更新事件
/// @elapsedTime 已经经过的时间
/// @timer 计时器
class TimerTimeUpdateEvent extends TimerEvent {
  final int elapsedTime;
  final Timer timer;

  TimerTimeUpdateEvent(this.elapsedTime, this.timer);
}

/// 计时器状态改变事件
/// @timer 计时器
/// @phase 改变后的阶段
class TimerPhaseChangeEvent extends TimerEvent {
  final Phase phase;
  final Timer timer;

  TimerPhaseChangeEvent(this.phase, this.timer);
}