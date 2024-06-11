import 'package:flutter/services.dart';
import 'package:pomotimer/common/channel/methods.dart';
import 'package:pomotimer/common/timer/timer.dart';
import 'package:pomotimer/generated/l10n.dart';

import '../alarm/alarm.dart';
import '../constants.dart';
import '../exceptions/MethodNotFoundException.dart';

class FlutterMethodChannel {

  FlutterMethodChannel() {
    instance = this;

    configureChannel();

    methods = {
      Methods.getLocalAppName: _onGetLocalAppNameCalled,
      Methods.getForegroundNotificationDescription: _onGetForegroundNotificationDescriptionCalled,
      Methods.getNotificationStopButtonText: _onGetNotificationStopButtonTextCalled,
      Methods.alarmCallback: _onAlarmCallbackCalled,
      Methods.clickNotificationCallback: _onClickNotificationCallbackCalled,
    };
  }

  late MethodChannel methodChannel;

  static late final FlutterMethodChannel instance;

  late Map methods;

  void configureChannel() {
    methodChannel = const MethodChannel(Constants.pluginChannelId);
    methodChannel.setMethodCallHandler(methodHandler); // set method handler
  }

  Future<dynamic> methodHandler(MethodCall call) async {
    if (methods.containsKey(call.method)) {
      return await methods[call.method]();
    } else {
      throw MethodNotFoundException('Method ${call.method} not found');
    }
  }
  
  Future<String> _onGetLocalAppNameCalled() async {
    return S.current.appName;
  }

  Future<String> _onGetForegroundNotificationDescriptionCalled() async {
    return S.current.foregroundNotificationDescription;
  }

  Future<String> _onGetNotificationStopButtonTextCalled() async {
    return S.current.notificationStopButton;
  }

  Future<void> _onAlarmCallbackCalled(String alarmJson) async {
    AppTimer.instance.onAlarmRinging(Alarm.fromJsonString(alarmJson));
  }

  Future<void> _onClickNotificationCallbackCalled(String alarmJson) async {
    AppTimer.instance.onClickNotification(Alarm.fromJsonString(alarmJson));
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