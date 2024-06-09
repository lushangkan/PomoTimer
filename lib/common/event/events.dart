
import 'dart:ui';

import 'package:pomotimer/common/timer/timer.dart';

import '../enum/attribute.dart';

/// 计时器事件
abstract interface class TimerEvent {
  TimerEvent();
}

/// App事件
abstract interface class AppEvent {
  AppEvent();
}

/// 计时器时间更新事件
/// @elapsedTime 已经经过的时间
/// @timer 计时器
class TimerTickEvent implements TimerEvent {
  static const EventType type = EventType.timerTick;

  final int elapsedTime;
  final int timeOfCurrentPhase;
  final AppTimer timer;

  TimerTickEvent(this.elapsedTime, this.timeOfCurrentPhase, this.timer);
}

/// 计时器状态改变事件
/// @timer 计时器
/// @phase 改变后的阶段
class TimerPhaseChangeEvent implements TimerEvent {
  static const EventType type = EventType.timerPhaseChange;

  final Phase phase;
  final int smallCyclesCompleted;
  final AppTimer timer;

  TimerPhaseChangeEvent(this.phase, this.timer, this.smallCyclesCompleted);
}

/// 计时器开始计数事件
/// @timer 计时器
class TimerStartEvent implements TimerEvent {
  static const EventType type = EventType.timerStart;

  final AppTimer timer;

  TimerStartEvent(this.timer);
}

/// 计时器暂停计数事件
/// @timer 计时器
class TimerPauseEvent implements TimerEvent {
  static const EventType type = EventType.timerPause;

  final AppTimer timer;

  TimerPauseEvent(this.timer);
}

/// 计时器停止计数事件
/// @timer 计时器
class TimerStopEvent implements TimerEvent {
  static const EventType type = EventType.timerStop;

  final AppTimer timer;

  TimerStopEvent(this.timer);
}

/// 计时器恢复计时事件
/// @timer 计时器
class TimerResumeEvent implements TimerEvent {
  static const EventType type = EventType.timerResume;

  final AppTimer timer;

  TimerResumeEvent(this.timer);
}

class AppLifecycleChangeEvent implements AppEvent {
  static const EventType type = EventType.appLifecycleChange;

  final AppLifecycleState state;

  AppLifecycleChangeEvent(this.state);
}

class AppClickedEvent implements AppEvent {
  static const EventType type = EventType.appClicked;

  AppClickedEvent();
}


/// 获取事件类型
/// @param event 事件
EventType? getEventType(TimerEvent event) {

  // dart没有反射，无法通过对象获取静态变量
  switch (event.runtimeType) {
    case TimerTickEvent:
      return TimerTickEvent.type;
    case TimerPhaseChangeEvent:
      return TimerPhaseChangeEvent.type;
    case TimerStartEvent:
      return TimerStartEvent.type;
    case TimerPauseEvent:
      return TimerPauseEvent.type;
    case TimerStopEvent:
      return TimerStopEvent.type;
    case TimerResumeEvent:
      return TimerResumeEvent.type;
    case AppLifecycleChangeEvent:
      return EventType.appLifecycleChange;
    case AppClickedEvent:
      return EventType.appClicked;
  }

  return null;
}

enum EventType {
  timerTick,
  timerPhaseChange,
  timerStart,
  timerPause,
  timerStop,
  timerResume,
  appLifecycleChange,
  appClicked,
}