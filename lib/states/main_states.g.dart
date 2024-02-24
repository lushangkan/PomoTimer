// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_states.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainStates _$MainStatesFromJson(Map<String, dynamic> json) => MainStates(
      timerRunning: json['timerRunning'] as bool?,
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      customFocusTime: json['customFocusTime'] as int?,
      customShortBreakTime: json['customShortBreakTime'] as int?,
      customLongBreakTime: json['customLongBreakTime'] as int?,
    );

Map<String, dynamic> _$MainStatesToJson(MainStates instance) =>
    <String, dynamic>{
      'timerRunning': instance.timerRunning,
      'startTime': instance.startTime?.toIso8601String(),
      'customFocusTime': instance.customFocusTime,
      'customShortBreakTime': instance.customShortBreakTime,
      'customLongBreakTime': instance.customLongBreakTime,
    };
