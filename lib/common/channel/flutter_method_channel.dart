import 'package:flutter/services.dart';
import 'package:pomotimer/common/channel/methods.dart';
import 'package:pomotimer/common/timer/timer.dart';
import 'package:pomotimer/generated/l10n.dart';

import '../alarm/alarm.dart';
import '../constants.dart';

class FlutterMethodChannel {
  late MethodChannel methodChannel;

  static final FlutterMethodChannel instance = FlutterMethodChannel();

  void configureChannel() {
    methodChannel = const MethodChannel(Constants.pluginChannelId);
    methodChannel.setMethodCallHandler(methodHandler); // set method handler
  }

  Future<dynamic> methodHandler(MethodCall call) async {
    switch (call.method) {
      // 将逻辑拆分为方法
      case Methods.getLocalAppName:
        return S.current.appName;
      case Methods.getForegroundNotificationDescription:
        return S.current.foregroundNotificationDescription;
      case Methods.getNotificationStopButtonText:
        return S.current.notificationStopButton;
      case Methods.alarmCallback:
        AppTimer.instance.onAlarmRinging(Alarm.fromJsonString(call.arguments));
      case Methods.clickNotificationCallback:
        AppTimer.instance.onClickNotification(Alarm.fromJsonString(call.arguments));
    }
  }

  Future<void> reloadLocale() async {
    methodChannel.invokeMethod(Methods.reloadLocale);
  }

  Future<void> registerAlarm(Alarm alarm) async {
    return await methodChannel.invokeMethod(Methods.registerAlarm, alarm.toJsonText());
  }

  Future<void> unregisterAlarm(String id) async {
    return await methodChannel.invokeMethod(Methods.unregisterAlarm, id);
  }

  Future<void> unregisterAllAlarms() async {
    return await methodChannel.invokeMethod(Methods.unregisterAllAlarms);
  }

  Future<void> stopAlarm(int alarmId) async {
    return await methodChannel.invokeMethod(Methods.stopAlarm, alarmId);
  }

  Future<void> requestHeadsUpPermission() async {
    return await methodChannel.invokeMethod(Methods.requestHeadsUpPermission);
  }

}