import 'dart:core';

import 'package:flutter/material.dart';
import 'package:pomotimer/common/enum/reminder_type.dart';

import '../generated/l10n.dart';
import 'enum/attribute.dart';

class Constants {

  /// 专注时间范围
  /// Attribute: (min, max)
  static final Map<Phase, (int, int)> timeRange = {
    Phase.focus: const (20, 60),
    Phase.shortBreak: const (5, 15),
    Phase.longBreak: const (15, 30),
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

  static const String pluginChannelId = "pomotimer_channel";

  static const String issueUrl = "https://github.com/lushangkan/PomoTimer/issues";
  static const String sponsorUrl = "https://afdian.com/a/lushangkan";
}