import 'dart:async';
import 'dart:developer';
import 'dart:math';

import 'package:pomotimer/common/alarm/alarm.dart';
import 'package:pomotimer/common/channel/flutter_method_channel.dart';
import 'package:pomotimer/common/event/events.dart';
import 'package:pomotimer/common/exceptions.dart';
import 'package:pomotimer/common/permission_handle.dart';
import 'package:pomotimer/common/utils/timer_utils.dart';

import '../../generated/l10n.dart';
import '../../states/timer_states.dart';
import '../constants.dart';
import '../enum/attribute.dart';
import '../enum/reminder_type.dart';
import '../event/event_bus.dart';
import '../logger.dart';

// TODO: 完善单元测试
class AppTimer {
  AppTimer(this._states) {
    logger.d('AppTimer init');
    logger.t(_states.toJson());

    init();
  }

  static const duration = Duration(seconds: 1);

  late final TimerStates _states;
  Timer? timer;
  Phase? _lastPhase;

  // 已注册闹铃的ID列表
  final List<int> alarmList = [];

  /// 是否正在运行
  /// @return 是否正在运行
  bool get isRunning =>
      _states.timerRunning == true &&
      _states.startTime != null &&
      _states.offsetTime != null;

  /// 是否正在暂停
  /// @return 是否正在暂停
  bool get isPausing =>
      _states.pausing == true && _states.startPauseTime != null;

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
  int? get totalTime =>
      calculateTotalTime(_states.customTimes, Constants.longBreakInterval)! *
      60 *
      1000;

  /// 计算经过的时间
  /// @return 已经经过的时间，单位毫秒, 如果相关变量值无效，则返回null
  int? get elapsedTime {
    if (_states.timerRunning != true &&
        _states.startTime == null &&
        _states.offsetTime == null) {
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

  /// 初始化，仅在应用启动时调用
  void init() {
    _checkAndResetTimer();

    if (!isRunning) {
      // 未运行
      return;
    }

    _startTimer();
  }

  /// 暂停计算
  void pause() {
    if (!isRunning) {
      return;
    }

    _states.pausing = true;
    _states.startPauseTime = DateTime.now().millisecondsSinceEpoch;

    eventBus.fire(TimerPauseEvent(this));

    _destroyTimer();

    _states.notifyListeners();
  }

  /// 恢复计算
  void resume() {
    if (!isPausing) {
      return;
    }

    _states.pausing = false;
    _states.offsetTime = _states.offsetTime! -
        (DateTime.now().millisecondsSinceEpoch - _states.startPauseTime!);

    eventBus.fire(TimerResumeEvent(this));

    _startTimer();

    _states.notifyListeners();
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

  /// 快进到下一个阶段
  void fastForwardToNextPhase() {
    if (!isRunning) {
      return;
    }

    // 获取当前阶段剩余时间
    var (_, timeRemainingInCurrentPhase, _) =
        getCurrentPhase ?? (null, null, null);

    if (timeRemainingInCurrentPhase == null) {
      return;
    }

    fastForward(timeRemainingInCurrentPhase);
  }

  /// 设置快进偏移时间
  /// @milliseconds 快进的时间，单位毫秒
  void setOffsetTime(int milliseconds) {
    _states.offsetTime = milliseconds;
    _states.notifyListeners();
  }

  /// 检查并重置计时器
  /// 如果计时器已经完成，则重置计时器
  /// @return 是否已经完成
  bool _checkAndResetTimer() {
    if (totalTime != null &&
        elapsedTime != null &&
        elapsedTime! >= totalTime!) {
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
  /// @return 当前阶段, 当前阶段的剩余时间，当前小循环次数
  (Phase?, int?, int?)? get getCurrentPhase {
    int focusTimeMs = _states.customFocusTime! * 60 * 1000;
    int shortBreakTimeMs = _states.customShortBreakTime! * 60 * 1000;
    int longBreakTimeMs = _states.customLongBreakTime! * 60 * 1000;

    const interval = Constants.longBreakInterval;

    // 计算每个循环的总时间（4个专注时间 + 3个小休息时间）
    int cycleTimeMs =
        focusTimeMs * interval + shortBreakTimeMs * (interval - 1);

    // 获取已过时间
    int? timeInCurrentCycleMs = elapsedTime;
    if (timeInCurrentCycleMs == null) {
      return null;
    }

    // 如果剩余时间在一个完整循环之内，计算当前阶段
    if (timeInCurrentCycleMs <= cycleTimeMs) {
      // 计算当前所在的小循环次数（专注 + 小休息）
      int smallCyclesCompleted =
          timeInCurrentCycleMs ~/ (focusTimeMs + shortBreakTimeMs);

      // 计算当前小循环中剩余的时间
      int timeInSmallCycleMs =
          timeInCurrentCycleMs % (focusTimeMs + shortBreakTimeMs);

      // 根据剩余时间判断是在专注阶段还是小休息阶段
      if (timeInSmallCycleMs < focusTimeMs) {
        return (
          Phase.focus,
          focusTimeMs - timeInSmallCycleMs,
          smallCyclesCompleted
        );
      } else {
        return (
          Phase.shortBreak,
          shortBreakTimeMs - (timeInSmallCycleMs - focusTimeMs),
          smallCyclesCompleted
        );
      }
    } else {
      // 如果剩余时间超过了一个完整循环，则当前处于大休息阶段
      int timeInLongBreakMs = timeInCurrentCycleMs - cycleTimeMs;
      return (Phase.longBreak, longBreakTimeMs - timeInLongBreakMs, interval);
    }
  }

  /// 获取所有阶段的信息
  /// @return 阶段信息列表 List: (阶段序号, 阶段, 总时间毫秒)
  List<(int, Phase, int)> getPhases() {
    // 计算每个阶段的时间
    int focusTimeMs = _states.customFocusTime! * 60 * 1000;
    int shortBreakTimeMs = _states.customShortBreakTime! * 60 * 1000;
    int longBreakTimeMs = _states.customLongBreakTime! * 60 * 1000;

    const interval = Constants.longBreakInterval;

    List<(int, Phase, int)> phases = [];

    int time = 0;

    for (var i = 0; i < interval; i++) {
      // 记录专注阶段
      time += focusTimeMs;
      phases.add((i, Phase.focus, time));

      if (i != interval - 1) {
        // 如果不是最后一个循环，记录短休息阶段
        time += shortBreakTimeMs;
        phases.add((i, Phase.shortBreak, time));
      }
    }

    // 记录长休息阶段
    time += longBreakTimeMs;
    phases.add((interval, Phase.longBreak, time));

    return phases;
  }

  void _startTimer() {
    // 立即执行一次
    run();

    // 启动定时任务，每秒执行一次
    timer = Timer.periodic(duration, (_) => run());
  }

  void _destroyTimer() {
    timer?.cancel();
  }

  int _randomAlarmId() {
    int? result;
    while (result == null) {
      var id = Random().nextInt(99999999);
      if (!alarmList.contains(id)) {
        result = id;
      }
    }
    return result;
  }

  Future<void> _registerAlarm() async {
    // 检测权限
    if (!permissionHandle.isPermissionGranted) {
      throw PermissionDeniedException();
    }

    var phases = getPhases();

    for (var data in phases) {
      var cycle = data.$1;
      var phase = data.$2;
      var time = data.$3;

      var ringTime = DateTime.now().add(Duration(milliseconds: time));

      String? notificationTitle;
      String? notificationContent;

      if (phase == Phase.focus) {
        notificationTitle = S.current.focusNotificationTitle;
        notificationContent = S.current.focusNotificationContent;
      } else if (phase == Phase.shortBreak) {
        notificationTitle = S.current.shortBreakNotificationTitle;
        notificationContent = S.current.shortBreakNotificationContent;
      } else if (phase == Phase.longBreak) {
        notificationTitle = S.current.longBreakNotificationTitle;
        notificationContent = S.current.longBreakNotificationContent;
      }

      var alarm = Alarm(
          id: _randomAlarmId(),
          timestamp: ringTime.toUtc().millisecondsSinceEpoch,
          fromAppAsset: true,
          audioPath: 'assets/media/default_ring.mp3',
          vibrate: true,
          loop: true,
          loopTimes: 9999);
          loopTimes: 20,
          notificationTitle: notificationTitle,
          notificationContent: notificationContent,
      );


      // 注册闹钟
      FlutterMethodChannel.instance.registerAlarm(alarm);
    }
  }

  /// 开始计时
  Future<void> startTimer() async {
    // 初始化变量
    _states.startTime = DateTime.now();
    _states.offsetTime = 0;
    _states.timerRunning = true;
    _states.pausing = false;
    _states.startPauseTime = null;
    _lastPhase = null;

    // 检测权限
    if (!permissionHandle.isPermissionGranted) {
      throw PermissionDeniedException();
    }

    // 触发事件
    eventBus.fire(TimerStartEvent(this));

    _startTimer();

    _states.notifyListeners();

    // 注册闹钟
    _registerAlarm();
  }

  // TODO: 暂停

  /// 停止计时
  void stopTimer() {
    if (!isRunning) {
      // 未运行，返回
      return;
    }

    // 清除变量
    _states.startTime = null;
    _states.offsetTime = null;
    _states.timerRunning = false;
    _states.pausing = false;
    _states.startPauseTime = null;
    _lastPhase = null;

    _states.notifyListeners();

    if (timer != null) _destroyTimer();

    // 触发事件
    eventBus.fire(TimerStopEvent(this));
  }

  void run() {
    Timeline.startSync('run');

    if (!isRunning) {
      return;
    }

    if (_checkAndResetTimer()) {
      return;
    }

    var (currentPhase, timeRemainingInCurrentPhase, smallCyclesCompleted) =
        getCurrentPhase ?? (null, null, null);

    if (currentPhase == null ||
        timeRemainingInCurrentPhase == null ||
        smallCyclesCompleted == null) {
      return;
    }

    if (currentPhase != _lastPhase) {
      eventBus.fire(
          TimerPhaseChangeEvent(currentPhase, this, smallCyclesCompleted));
    }

    _lastPhase = currentPhase;

    var timeOfCurrentPhase = _states.customTimes[currentPhase]! * 60 * 1000 -
        timeRemainingInCurrentPhase;

    eventBus.fire(TimerTickEvent(elapsedTime!, timeOfCurrentPhase, this));

    Timeline.finishSync();
  }

  void dispose() {
    timer?.cancel();
  }
}
