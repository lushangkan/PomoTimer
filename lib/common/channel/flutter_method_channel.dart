import 'package:flutter/services.dart';
import 'package:pomotimer/common/channel/methods.dart';
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
      case Methods.getLocalAppName:
        return S.current.appName;
      case Methods.getForegroundNotificationDescription:
        return S.current.foregroundNotificationDescription;
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

  Future<void> stopAlarm() async {
    return await methodChannel.invokeMethod(Methods.stopAlarm);
  }

  Future<void> requestHeadsUpPermission() async {
    return await methodChannel.invokeMethod(Methods.requestHeadsUpPermission);
  }

}