// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Alarm _$AlarmFromJson(Map<String, dynamic> json) => Alarm(
      id: (json['id'] as num).toInt(),
      timestamp: (json['timestamp'] as num).toInt(),
      audioPath: json['audioPath'] as String?,
      fromAppAsset: json['fromAppAsset'] as bool?,
      vibrate: json['vibrate'] as bool,
      notification: json['notification'] as bool,
      isAlarm: json['isAlarm'] as bool,
      loop: json['loop'] as bool,
      loopTimes: (json['loopTimes'] as num).toInt(),
      notificationTitle: json['notificationTitle'] as String?,
      notificationContent: json['notificationContent'] as String?,
    );

Map<String, dynamic> _$AlarmToJson(Alarm instance) => <String, dynamic>{
      'id': instance.id,
      'timestamp': instance.timestamp,
      'audioPath': instance.audioPath,
      'fromAppAsset': instance.fromAppAsset,
      'vibrate': instance.vibrate,
      'notification': instance.notification,
      'isAlarm': instance.isAlarm,
      'loop': instance.loop,
      'loopTimes': instance.loopTimes,
      'notificationTitle': instance.notificationTitle,
      'notificationContent': instance.notificationContent,
    };
