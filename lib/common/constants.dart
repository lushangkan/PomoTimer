import 'dart:core';

import 'package:flutter/material.dart';
import 'package:pomotimer/common/enum/reminder_type.dart';
import 'package:tuple/tuple.dart';

import '../generated/l10n.dart';
import 'enum/attribute.dart';

class Constants {

  /// 专注时间范围
  /// Attribute: Tuple2<min, max>
  static final Map<Phase, Tuple2<int, int>> timeRange = {
    Phase.focus: const Tuple2(20, 60),
    Phase.shortBreak: const Tuple2(5, 15),
    Phase.longBreak: const Tuple2(15, 30),
  };

  /// 专注时间默认值
  /// Attribute: int
  static final Map<Phase, int> defaultTime = {
    Phase.focus: 25,
    Phase.shortBreak: 5,
    Phase.longBreak: 20,
  };

  /// 提醒方式翻译
  /// ReminderType: String Function(BuildContext)
  static final Map<ReminderType, String Function(BuildContext)> reminderTypeTranslation = {
    ReminderType.none: (context) => S.of(context).reminderNone,
    ReminderType.notification: (context) => S.of(context).reminderNotification,
    ReminderType.vibration: (context) => S.of(context).reminderVibration,
    ReminderType.alarm: (context) => S.of(context).reminderAlarm,
  };



  /// 长休息间隔
  static const int longBreakInterval = 4;
}