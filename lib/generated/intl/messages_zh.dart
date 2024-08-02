// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appName": MessageLookupByLibrary.simpleMessage("PomoTimer"),
        "focusNotificationContent":
            MessageLookupByLibrary.simpleMessage("专注的时间开始了, 让我们沉浸在工作中吧! 🔥"),
        "focusNotificationTitle":
            MessageLookupByLibrary.simpleMessage("集中注意力!"),
        "foregroundNotificationDescription":
            MessageLookupByLibrary.simpleMessage("计时器正在后台处理..."),
        "longBreakNotificationContent": MessageLookupByLibrary.simpleMessage(
            "你已经非常努力了，现在是时候放松一下，充充电，再继续前行! 🍹"),
        "longBreakNotificationTitle":
            MessageLookupByLibrary.simpleMessage("放松时间!"),
        "notificationStopButton": MessageLookupByLibrary.simpleMessage("停止"),
        "reminderAlarm": MessageLookupByLibrary.simpleMessage("闹钟提醒"),
        "reminderNone": MessageLookupByLibrary.simpleMessage("无提醒"),
        "reminderNotification": MessageLookupByLibrary.simpleMessage("仅通知"),
        "reminderVibration": MessageLookupByLibrary.simpleMessage("震动提醒"),
        "settingAboutTitle": MessageLookupByLibrary.simpleMessage("关于"),
        "settingAutoNextTitle":
            MessageLookupByLibrary.simpleMessage("自动开始下一次番茄"),
        "settingBtnTooltip": MessageLookupByLibrary.simpleMessage("设置"),
        "settingLanguageTitle": MessageLookupByLibrary.simpleMessage("语言"),
        "settingRequestRestart":
            MessageLookupByLibrary.simpleMessage("设置成功，重启应用生效"),
        "settingRingtoneTitle": MessageLookupByLibrary.simpleMessage("铃声"),
        "settingThemeTitle": MessageLookupByLibrary.simpleMessage("主题"),
        "settingTitle": MessageLookupByLibrary.simpleMessage("设置"),
        "shortBreakNotificationContent": MessageLookupByLibrary.simpleMessage(
            "短暂的休息可以让你更有活力，准备好迎接下一个专注时段吧! 🌟"),
        "shortBreakNotificationTitle":
            MessageLookupByLibrary.simpleMessage("短暂休息!"),
        "startBtn": MessageLookupByLibrary.simpleMessage("开始")
      };
}
