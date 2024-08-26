import 'package:flutter/services.dart';
import 'package:pomotimer/common/channel/methods.dart';
import 'package:pomotimer/common/timer/timer.dart';
import 'package:pomotimer/generated/l10n.dart';

import '../alarm/alarm.dart';
import '../constants.dart';
import '../exceptions/native_exception.dart';

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
      return await methods[call.method](call);
    } else {
      throw MethodNotFoundException('Method ${call.method} not found');
    }
  }
  
  Future<String> _onGetLocalAppNameCalled(MethodCall call) async {
    return S.current.appName;
  }

  Future<String> _onGetForegroundNotificationDescriptionCalled(MethodCall call) async {
    return S.current.foregroundNotificationDescription;
  }

  Future<String> _onGetNotificationStopButtonTextCalled(MethodCall call) async {
    return S.current.notificationStopButton;
  }

  Future<void> _onAlarmCallbackCalled(MethodCall call) async {
    AppTimer.instance.onAlarmRinging(Alarm.fromJsonString(call.arguments));
  }

  Future<void> _onClickNotificationCallbackCalled(MethodCall call) async {
    AppTimer.instance.onClickNotification(Alarm.fromJsonString(call.arguments));
  }


  Future<void> reloadLocale() async {
    methodChannel.invokeMethod(Methods.reloadLocale);
  }

  Future<int> registerAlarm(Alarm alarm) async {
    try {
      await methodChannel.invokeMethod(Methods.registerAlarm, alarm.toJsonText());
    } on PlatformException catch (e) {
      if (e.code == "ALARM_ALREADY_EXISTS") {
        return -1;
      }
    }

    return 0;
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