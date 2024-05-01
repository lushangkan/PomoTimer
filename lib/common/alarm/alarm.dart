import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'alarm.g.dart';

@JsonSerializable()
class Alarm {
  final int id;
  final int timestamp;
  final String? audioPath;
  final bool? fromAppAsset;
  final bool vibrate;
  final bool loop;
  final int loopTimes;
  final String? notificationTitle;
  final String? notificationContent;

  Alarm({
    required this.id,
    required this.timestamp,
    this.audioPath,
    this.fromAppAsset,
    required this.vibrate,
    required this.loop,
    required this.loopTimes,
    this.notificationTitle,
    this.notificationContent,
  });

  factory Alarm.fromJson(Map<String, dynamic> json) => _$AlarmFromJson(json);
  Map<String, dynamic> toJson() => _$AlarmToJson(this);
  String toJsonText() => jsonEncode(toJson());
}