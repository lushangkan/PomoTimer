import 'dart:async';

import 'package:pomotimer/common/event_bus.dart';
import 'package:pomotimer/common/events.dart';
import 'package:pomotimer/common/utils/timer_utils.dart';

import '../../states/timer_states.dart';
import '../constants.dart';
import '../enum/attribute.dart';
import '../enum/reminder_type.dart';
import '../logger.dart';

// TODO: 完善单元测试
class AppTimer {
  AppTimer(this._states) {
    logger.d('AppTimer init');
    logger.t(_states.toJson());
  }

  static const duration = Duration(seconds: 1);

  late final TimerStates _states;
  late Timer timer;
  Phase? lastPhase;

  /// 是否正在运行
  /// @return 是否正在运行
  bool get isRunning => _states.timerRunning == true && _states.startTime != null && _states.offsetTime != null;

  /// 剩余时间
  /// @return 剩余时间，单位毫秒， 如果相关变量值无效，则返回null
  int? get remainingTime {
    if (_states.timerRunning != true) {
      return null;
    }
    return totalTime! - elapsedTime!;
  }

  /// 计算总时间
  /// @return 总时间
  int? get totalTime => calculateTotalTime(_states.customTimes, Constants.longBreakInterval)! * 60 * 1000;

  /// 计算经过的时间
  /// @return 已经经过的时间，单位毫秒, 如果相关变量值无效，则返回null
  int? get elapsedTime {
    if (_states.timerRunning != true && _states.startTime == null && _states.offsetTime == null) {
      return null;
    } else if (_states.startTime != null) {
      var now = DateTime.now();
      var passedTime = now.difference(_states.startTime!).inMilliseconds;
      if (_states.offsetTime != null) {
        passedTime += _states.offsetTime!;
      }
      return passedTime;
    }
    return null;
  }

  Future<void> init() async {
    checkAndResetTimer();
    var now = DateTime.now();
    var microsecondsToNextSecond = 1000000 - now.microsecond;
    await Future.delayed(Duration(microseconds: microsecondsToNextSecond));

    timer = Timer.periodic(duration, run);
  }

  /// 快进一段时间
  /// @milliseconds 快进的时间，单位毫秒
  void fastForward(int milliseconds) {
    if (_states.offsetTime == null) {
      _states.offsetTime = milliseconds;
    } else {
      _states.offsetTime = _states.offsetTime! + milliseconds;
    }
    _states.notifyListeners();

  }

  /// 检查并重置计时器
  /// 如果计时器已经完成，则重置计时器
  /// @return 是否已经完成
  bool checkAndResetTimer() {
    if (totalTime != null && elapsedTime != null && elapsedTime! >= totalTime!) {
      stopTimer();
      return true;
    }
    return false;
  }

  /// 重置偏移时间
  void resetOffsetTime() {
    _states.offsetTime = null;
    _states.notifyListeners();
  }

  /// 设置提醒类型
  /// @type 提醒类型
  void setReminderType(ReminderType type) {
    _states.reminderType = type;
    _states.notifyListeners();
  }

  /// 设置自定义时间
  /// @attribute 自定义时间类型
  void setCustomTime(Phase attribute, int time) {
    switch (attribute) {
      case Phase.focus:
        _states.customFocusTime = time;
        break;
      case Phase.shortBreak:
        _states.customShortBreakTime = time;
        break;
      case Phase.longBreak:
        _states.customLongBreakTime = time;
        break;
    }

    _states.notifyListeners();
  }

  /// 设置自定义时间
  /// @times 自定义时间
  void setCustomTimes(Map<Phase, int> times) {
    _states.customFocusTime = times[Phase.focus];
    _states.customShortBreakTime = times[Phase.shortBreak];
    _states.customLongBreakTime = times[Phase.longBreak];

    _states.notifyListeners();
  }

  /// 计算当前阶段
  /// @return 当前阶段, 当前阶段的剩余时间
  (Phase?, int?)? calculateCurrentPhase() {
    int focusTimeMs = _states.customFocusTime! * 60 * 1000;
    int shortBreakTimeMs = _states.customShortBreakTime! * 60 * 1000;
    int longBreakTimeMs = _states.customLongBreakTime! * 60 * 1000;

    // 计算每个循环的总时间（3个专注时间 + 3个小休息时间）
    int cycleTimeMs = (focusTimeMs + shortBreakTimeMs) * (Constants.longBreakInterval - 1);
    // 计算完整循环的总时间（包括一个大休息时间）
    int fullCycleTimeMs = cycleTimeMs + longBreakTimeMs;

    // 获取已过时间
    int? passedTimeMs = elapsedTime;
    if (passedTimeMs == null) {
      return null;
    }

    // 计算当前所在的完整循环次数
    int cyclesCompleted = passedTimeMs ~/ fullCycleTimeMs;

    // 计算当前循环中剩余的时间
    int timeInCurrentCycleMs = passedTimeMs % fullCycleTimeMs;

    // 如果剩余时间在一个完整循环之内，计算当前阶段
    if (timeInCurrentCycleMs <= cycleTimeMs) {
      // 计算当前所在的小循环次数（专注 + 小休息）
      int smallCyclesCompleted = timeInCurrentCycleMs ~/ (focusTimeMs + shortBreakTimeMs);
      // 计算当前小循环中剩余的时间
      int timeInSmallCycleMs = timeInCurrentCycleMs % (focusTimeMs + shortBreakTimeMs);

      // 根据剩余时间判断是在专注阶段还是小休息阶段
      if (timeInSmallCycleMs < focusTimeMs) {
        return (Phase.focus, focusTimeMs - timeInSmallCycleMs);
      } else {
        return (Phase.shortBreak, shortBreakTimeMs - (timeInSmallCycleMs - focusTimeMs));
      }
    } else {
      // 如果剩余时间超过了一个完整循环，则当前处于大休息阶段
      int timeInLongBreakMs = passedTimeMs - cycleTimeMs;
      return (Phase.longBreak, longBreakTimeMs - timeInLongBreakMs);
    }
  }


  /// 开始计时
  void startTimer() {
    _states.startTime = DateTime.now();
    _states.offsetTime = 0;
    _states.timerRunning = true;
    _states.notifyListeners();

    eventBus.fire(TimerStartEvent(this));
  }

  // TODO: 暂停

  /// 停止计时
  void stopTimer() {
    _states.startTime = null;
    _states.offsetTime = null;
    _states.timerRunning = false;
    _states.notifyListeners();

    eventBus.fire(TimerStopEvent(this));
  }

  void run(timer) {
    if (_states.timerRunning != true) {
      return;
    }

    if (checkAndResetTimer()) {
      return;
    }

    var currentPhase = calculateCurrentPhase()?.item1;

    if (currentPhase != null && currentPhase != lastPhase) {
      eventBus.fire(TimerPhaseChangeEvent(currentPhase, this));
    }

    if (currentPhase != null) {
      lastPhase = currentPhase;
    }

    eventBus.fire(TimerTickEvent(elapsedTime!, this));
  }

  void dispose() {
    timer.cancel();
  }

}