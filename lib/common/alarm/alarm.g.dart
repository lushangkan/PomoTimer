// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Alarm _$AlarmFromJson(Map<String, dynamic> json) => Alarm(
      id: json['id'] as int,
      timestamp: json['timestamp'] as int,
      audioPath: json['audioPath'] as String?,
      fromAppAsset: json['fromAppAsset'] as bool?,
      vibrate: json['vibrate'] as bool,
      loop: json['loop'] as bool,
      loopTimes: json['loopTimes'] as int,
      notificationTitle: json['notificationTitle'] as String?,
      notificationContent: json['notificationContent'] as String?,
    );

Map<String, dynamic> _$AlarmToJson(Alarm instance) => <String, dynamic>{
      'id': instance.id,
      'timestamp': instance.timestamp,
      'audioPath': instance.audioPath,
      'fromAppAsset': instance.fromAppAsset,
      'vibrate': instance.vibrate,
      'loop': instance.loop,
      'loopTimes': instance.loopTimes,
      'notificationTitle': instance.notificationTitle,
      'notificationContent': instance.notificationContent,
    };
