import 'dart:convert';
import 'dart:core';

import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pomotimer/common/enum/attribute.dart';
import 'package:pomotimer/common/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/enum/reminder_type.dart';
import '../common/reflector.dart';

part 'timer_states.g.dart';

@reflector
@JsonSerializable()
class TimerStates extends ChangeNotifier {
  /// @loadFromStorage 是否从储存中加载

  bool? timerRunning; // 是否正在执行中
  DateTime? startTime; // 开始时间，未运行时为null
  int? offsetTime; // 快进的偏移时间，单位毫秒，未运行时为null

  bool? pausing;
  int? startPauseTime;

  Map<Phase, int> get customTimes => {
    Phase.focus: customFocusTime!,
    Phase.shortBreak: customShortBreakTime!,
    Phase.longBreak: customLongBreakTime!,
  };

  int? customFocusTime; // 自定义专注时间
  int? customShortBreakTime; // 自定义短休息时间
  int? customLongBreakTime; // 自定义长休息时间

  ReminderType? reminderType; // 计时器完成提醒类型

  TimerStates({
    this.timerRunning,
    this.startTime,
    this.offsetTime,
    this.pausing,
    this.startPauseTime,
    this.customFocusTime,
    this.customShortBreakTime,
    this.customLongBreakTime,
    this.reminderType,
  }) {
    var dirty = false;

    for (var element in _TimerStates.values) {
      var mirror = reflector.reflect(this);

      var varValue = mirror.invokeGetter(element.name);

      if (varValue == null && !element.canBeNull) {
        logger.t('${element.name} is null, setting to default value: ${element.defaultValue}');
        mirror.invokeSetter(element.name, element.defaultValue);
        dirty = true;
      }
    }

    notifyListeners(saveToStorage: dirty);
  }

  factory TimerStates.fromJson(Map<String, dynamic> json) =>_$TimerStatesFromJson(json);

  factory TimerStates.fromJsonText(String json) => _$TimerStatesFromJson(jsonDecode(json) as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$TimerStatesToJson(this);

  String toJsonText() => jsonEncode(toJson());

  factory TimerStates.loadFromStorage(SharedPreferences prefs) {
    logger.d('Loading main states from storage');

    var jsonText = prefs.getString('timer_states');

    jsonText ??= '{}';

    dynamic json;

    try {
      json = jsonDecode(jsonText);
      if (json != null) {
        json = json as Map<String, dynamic>;
      } else {
        json = {};
      }
    } on FormatException catch (e) {
      logger.e('Error loading from storage: ${e.toString()}');

      json = {};
    }

    return TimerStates.fromJson(json);
  }

  void _saveToStorage() async {
    logger.d('Saving main states to storage');

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('timer_states', toJsonText());
  }

  @override
  void notifyListeners({bool saveToStorage = true}) {
    super.notifyListeners();

    if (saveToStorage) {
      _saveToStorage();
    }
  }

}

/// 状态枚举
enum _TimerStates {
  timerRunning(false, false),
  startTime(null, true),
  offsetTime(null, true),

  pausing(false, false),
  startPauseTime(null, true),

  // 由于dart限制，无法直接引用常量类中的值
  customFocusTime(25, false), // 25 分钟
  customShortBreakTime(5, false), // 5 分钟
  customLongBreakTime(20, false), // 20 分钟

  reminderType(ReminderType.alarm, false);


  final Object? defaultValue; // 默认值
  final bool canBeNull; // 是否可以为null

  const _TimerStates(this.defaultValue, this.canBeNull);
}