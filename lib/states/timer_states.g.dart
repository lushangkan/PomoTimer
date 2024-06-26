// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_states.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimerStates _$TimerStatesFromJson(Map<String, dynamic> json) => TimerStates(
      timerRunning: json['timerRunning'] as bool?,
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      offsetTime: json['offsetTime'] as int?,
      pausing: json['pausing'] as bool?,
      startPauseTime: json['startPauseTime'] as int?,
      customFocusTime: json['customFocusTime'] as int?,
      customShortBreakTime: json['customShortBreakTime'] as int?,
      customLongBreakTime: json['customLongBreakTime'] as int?,
      reminderType:
          $enumDecodeNullable(_$ReminderTypeEnumMap, json['reminderType']),
    );

Map<String, dynamic> _$TimerStatesToJson(TimerStates instance) =>
    <String, dynamic>{
      'timerRunning': instance.timerRunning,
      'startTime': instance.startTime?.toIso8601String(),
      'offsetTime': instance.offsetTime,
      'pausing': instance.pausing,
      'startPauseTime': instance.startPauseTime,
      'customFocusTime': instance.customFocusTime,
      'customShortBreakTime': instance.customShortBreakTime,
      'customLongBreakTime': instance.customLongBreakTime,
      'reminderType': _$ReminderTypeEnumMap[instance.reminderType],
    };

const _$ReminderTypeEnumMap = {
  ReminderType.none: 'none',
  ReminderType.notification: 'notification',
  ReminderType.vibration: 'vibration',
  ReminderType.alarm: 'alarm',
};
