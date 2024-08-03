import 'dart:async';
import 'dart:developer';
import 'dart:math';
import 'dart:ui';

import 'package:pomotimer/common/alarm/alarm.dart';
import 'package:pomotimer/common/channel/flutter_method_channel.dart';
import 'package:pomotimer/common/event/events.dart';
import 'package:pomotimer/common/exceptions.dart';
import 'package:pomotimer/common/permission_handle.dart';
import 'package:pomotimer/common/utils/timer_utils.dart';
import 'package:pomotimer/states/app_states.dart';

import '../../generated/l10n.dart';
import '../../states/timer_states.dart';
import '../constants.dart';
import '../enum/attribute.dart';
import '../enum/reminder_type.dart';
import '../event/event_bus.dart';
import '../logger.dart';
import '../preferences/preference_manager.dart';

// TODO: 完善单元测试
class AppTimer {
  AppTimer(this._states, this._appStates) {
    instance = this;

    logger.d('AppTimer init');
    logger.t(_states.toJson());

    init();
  }

  static late final AppTimer instance;

  // Timer运行间隔时间
  static const _internalTimerDuration = Duration(seconds: 1);

  late final AppStates _appStates;
  late final TimerStates _states;
  Timer? _timer;
  Phase? _lastPhase;

  // 已注册闹铃的ID列表
  final List<int> _alarmList = [];

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
        passedTime += offsetTime!;
      }
      return passedTime;
    }
    return null;
  }

  /// 获取偏移时间（含暂停时间）
  /// @return 偏移时间，单位毫秒
  int? get offsetTime {
    if (_states.offsetTime == null) {
      return null;
    }

    if (_states.startPauseTime == null || !isPausing) {
      return _states.offsetTime;
    }

    return _states.offsetTime! -
        (DateTime.now().millisecondsSinceEpoch - _states.startPauseTime!);
  }

  /// 初始化，仅在应用启动时调用
  void init() {
    _checkAndResetTimer();

    if (!isRunning || isPausing) {
      // 未运行
      return;
    }

    // 如果在运行, 启动内部计时器
    _startInternalTimer();
  }

  /// 启动计时
  void start() {
    if (isRunning) {
      // 已经运行，返回
      return;
    }

    _startTimer();
  }

  /// 停止计时
  void stop() {
    if (!isRunning) {
      // 未运行，返回
      return;
    }

    _stopTimer();
  }

  /// 暂停计时
  void pause() {
    if (!isRunning || isPausing) {
      return;
    }

    _pauseTimer();
  }

  /// 恢复计时
  void resume() {
    if (!isPausing || !isRunning) {
      return;
    }

    _resumeTimer();
  }

  /// 快进一段时间
  /// @milliseconds 快进的时间，单位毫秒
  void fastForward(int milliseconds) {
    if (_states.offsetTime == null) {
      setOffsetTime(milliseconds);
    } else {
      setOffsetTime(_states.offsetTime! + milliseconds);
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
  /// @reregisterAlarm 是否重新注册闹钟
  void setOffsetTime(int milliseconds, {reregisterAlarm = true}) {
    _states.offsetTime = milliseconds;

    if (reregisterAlarm) {
      _unregisterAllAlarm();
      _registerAlarm();
    }

    _states.notifyListeners();
  }

  /// 检查并重置计时器
  /// 如果计时器已经完成，则重置计时器
  /// @return 是否已经完成
  bool _checkAndResetTimer() {
    if (totalTime != null &&
        elapsedTime != null &&
        elapsedTime! >= totalTime!) {
      _stopTimer();
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

  void _startInternalTimer() {
    // 立即执行一次
    run();

    // 启动定时任务，每秒执行一次
    _timer = Timer.periodic(_internalTimerDuration, (_) => run());
  }

  void _destroyInternalTimer() {
    _timer?.cancel();
  }

  int _randomAlarmId() {
    int? result;
    while (result == null) {
      var id = Random().nextInt(99999999);
      if (!_alarmList.contains(id)) {
        result = id;
      }
    }
    return result;
  }

  Future<void> _registerAlarm() async {
    if (_states.reminderType == ReminderType.none) {
      return;
    }

    // 检测权限
    if (!PermissionHandle.instance.isPermissionGranted) {
      throw PermissionDeniedException();
    }

    var phases = getPhases();

    for (var data in phases) {
      var cycle = data.$1;
      var phase = data.$2;
      var time = data.$3;

      var ringTime = DateTime.now().add(Duration(milliseconds: time));

      int alarmId = _randomAlarmId();
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

      bool vibrate;
      bool notification;
      bool isAlarm;

      switch (_states.reminderType) {
        case null:
          throw Exception('Reminder type is null');
        case ReminderType.none:
          vibrate = false;
          notification = false;
          isAlarm = false;
        case ReminderType.notification:
          vibrate = false;
          notification = true;
          isAlarm = false;
        case ReminderType.vibration:
          vibrate = true;
          notification = true;
          isAlarm = false;
        case ReminderType.alarm:
          vibrate = true;
          notification = true;
          isAlarm = true;
      }

      var alarm = Alarm(
          id: alarmId,
          timestamp: ringTime.toUtc().millisecondsSinceEpoch,
          fromAppAsset: true,
          audioPath: PreferenceManager.instance.ringtonePath ?? 'assets/media/default_ring.mp3',
          vibrate: vibrate,
          notification: notification,
          isAlarm: isAlarm,
          loop: true,
          loopTimes: 20,
          notificationTitle: notificationTitle,
          notificationContent: notificationContent,
      );

      _alarmList.add(alarmId);

      // 注册闹钟
      FlutterMethodChannel.instance.registerAlarm(alarm);
    }
  }

  Future<void> _unregisterAllAlarm() async {
    FlutterMethodChannel.instance.unregisterAllAlarms();
  }

  Future<void> ringtoneChanged() async {
    if (_states.reminderType != ReminderType.alarm || !isRunning) {
      return;
    }

    _unregisterAllAlarm();
    _registerAlarm();
  }

  Future<void> _startTimer() async {
    // 初始化变量
    _states.startTime = DateTime.now();
    setOffsetTime(reregisterAlarm: false, 0);
    _states.timerRunning = true;
    _states.pausing = false;
    _states.startPauseTime = null;
    _lastPhase = null;

    // 检测权限
    if (!PermissionHandle.instance.isPermissionGranted) {
      throw PermissionDeniedException();
    }

    // 触发事件
    eventBus.fire(TimerStartEvent(this));

    _startInternalTimer();

    _states.notifyListeners();

    // 注册闹钟
    _registerAlarm();
  }

  void _stopTimer() {
    // 清除变量
    _states.startTime = null;
    resetOffsetTime();
    _states.timerRunning = false;
    _states.pausing = false;
    _states.startPauseTime = null;
    _lastPhase = null;

    // 如果CustomTime小于最小时间，则重置
    setCustomTimes(Constants.defaultTime);

    _states.notifyListeners();

    if (_timer != null) _destroyInternalTimer();

    // 触发事件
    eventBus.fire(TimerStopEvent(this));

    // 取消所有闹钟
    _unregisterAllAlarm();
  }

  void _pauseTimer() {
    _states.pausing = true;
    _states.startPauseTime = DateTime.now().millisecondsSinceEpoch;

    eventBus.fire(TimerPauseEvent(this));

    _destroyInternalTimer();
    // 取消所有闹钟
    _unregisterAllAlarm();

    _states.notifyListeners();
  }

  void _resumeTimer() {
    if (offsetTime == null) {
      throw Exception('Offset time is null');
    }

    setOffsetTime(offsetTime!, reregisterAlarm: false);

    _states.pausing = false;
    _states.startPauseTime = null;

    eventBus.fire(TimerResumeEvent(this));

    _startInternalTimer();
    // 注册闹钟
    _registerAlarm();

    _states.notifyListeners();
  }

  void onAlarmRinging(Alarm alarm) {
    logger.d('Alarm ringing: #${alarm.id}');

    unawaited(() async {
      // 如果应用不在前台，等待应用恢复
      if (_appStates.appLifecycleState != AppLifecycleState.resumed) {
        while (_appStates.appLifecycleState != AppLifecycleState.resumed) {
          await Future.delayed(const Duration(milliseconds: 1000));
        }

        logger.d('Back to foreground, stop alarm: #${alarm.id}');
      } else {
        // 如果应用在前台，等待触摸App再停止
        var clicked = false;

        eventBus.on<AppClickedEvent>().listen((event) {
          clicked = true;
        });

        while (!clicked) {
          await Future.delayed(const Duration(milliseconds: 1000));
        }

        logger.d('App clicked, stop alarm: #${alarm.id}');
      }

      // 停止闹钟
      FlutterMethodChannel.instance.stopAlarm(alarm.id);
    }.call());
  }

  void onClickNotification(Alarm alarm) {
    logger.d('Notification stop button clicked: #${alarm.id}');

    // 停止闹钟
    FlutterMethodChannel.instance.stopAlarm(alarm.id);
  }

  /// 内部计时器的周期方法
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
    _timer?.cancel();
  }
}
