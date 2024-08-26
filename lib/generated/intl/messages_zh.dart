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

  static String m0(link, reason) => "无法打开链接: ${link} 原因: ${reason}";

  static String m1(time) => "推荐设置为${time}分钟";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "acknowledgments": MessageLookupByLibrary.simpleMessage("鸣谢"),
        "acknowledgmentsLogoDesign":
            MessageLookupByLibrary.simpleMessage("提供Logo设计指导"),
        "afadiana": MessageLookupByLibrary.simpleMessage("爱发电"),
        "alwaysOff": MessageLookupByLibrary.simpleMessage("总是关闭"),
        "alwaysOn": MessageLookupByLibrary.simpleMessage("总是开启"),
        "appName": MessageLookupByLibrary.simpleMessage("PomoTimer"),
        "bugReport": MessageLookupByLibrary.simpleMessage("问题反馈"),
        "cancel": MessageLookupByLibrary.simpleMessage("取消"),
        "cannotOpenLink": m0,
        "chooseLanguage": MessageLookupByLibrary.simpleMessage("选择语言"),
        "chooseRingtone": MessageLookupByLibrary.simpleMessage("选择铃声"),
        "chooseTheme": MessageLookupByLibrary.simpleMessage("选择主题"),
        "codeLicense": MessageLookupByLibrary.simpleMessage("项目协议"),
        "codeRepo": MessageLookupByLibrary.simpleMessage("源码仓库"),
        "copyrightInfo": MessageLookupByLibrary.simpleMessage("版权信息"),
        "darkMode": MessageLookupByLibrary.simpleMessage("暗色模式"),
        "defaultRingtone": MessageLookupByLibrary.simpleMessage("默认铃声"),
        "developer": MessageLookupByLibrary.simpleMessage("开发者"),
        "estimatedTime": MessageLookupByLibrary.simpleMessage("预计时间"),
        "fileHasNotAudio": MessageLookupByLibrary.simpleMessage("文件不含有音频"),
        "focus": MessageLookupByLibrary.simpleMessage("专注"),
        "focusNotificationContent":
            MessageLookupByLibrary.simpleMessage("专注的时间开始了, 让我们沉浸在工作中吧! 🔥"),
        "focusNotificationTitle":
            MessageLookupByLibrary.simpleMessage("集中注意力!"),
        "followSystem": MessageLookupByLibrary.simpleMessage("跟随系统"),
        "fontCopyRight": MessageLookupByLibrary.simpleMessage("字体"),
        "foregroundNotificationDescription":
            MessageLookupByLibrary.simpleMessage("计时器正在后台处理..."),
        "fromStorage": MessageLookupByLibrary.simpleMessage("从存储中选择"),
        "longBreak": MessageLookupByLibrary.simpleMessage("大休息"),
        "longBreakNotificationContent": MessageLookupByLibrary.simpleMessage(
            "你已经非常努力了，现在是时候放松一下，充充电，再继续前行! 🍹"),
        "longBreakNotificationTitle":
            MessageLookupByLibrary.simpleMessage("放松时间!"),
        "lushangkan": MessageLookupByLibrary.simpleMessage("路上看见"),
        "needBackgroundPermission":
            MessageLookupByLibrary.simpleMessage("需要权限"),
        "needBackgroundPermissionContent": MessageLookupByLibrary.simpleMessage(
            "计时器需要持续在后台运行, 以便及时提醒您。\n可能会弹出权限设置页面, 若弹出, 请将该应用设置为“无限制”或允许应用在后台运行。"),
        "needNotificationPermission":
            MessageLookupByLibrary.simpleMessage("需要权限"),
        "needNotificationPermissionContent":
            MessageLookupByLibrary.simpleMessage(
                "计时器需要获取通知权限, 以便及时提醒您。\n请允许该应用的悬浮通知权限和锁屏通知权限。"),
        "needPermission": MessageLookupByLibrary.simpleMessage("需要权限"),
        "needPermissionContent":
            MessageLookupByLibrary.simpleMessage("启动计时器需要一些权限, 是否继续?"),
        "needPopoutPermission": MessageLookupByLibrary.simpleMessage("需要权限"),
        "needPopoutPermissionContent": MessageLookupByLibrary.simpleMessage(
            "计时器需要在到达一个阶段后弹出窗口提醒, 以便及时提醒您。\n可能会弹出权限设置页面, 若弹出, 请将该应用设置为“允许‘勿扰’模式”。"),
        "needStoragePermission": MessageLookupByLibrary.simpleMessage("需要权限"),
        "needStoragePermissionContent":
            MessageLookupByLibrary.simpleMessage("选择铃声需要访问存储的权限, 是否继续?"),
        "notChooseFile": MessageLookupByLibrary.simpleMessage("未选择文件"),
        "notificationStopButton": MessageLookupByLibrary.simpleMessage("停止"),
        "permissionNotGranted": MessageLookupByLibrary.simpleMessage("权限未授予"),
        "phase": MessageLookupByLibrary.simpleMessage("阶段"),
        "recommendTime": m1,
        "rejectionPermission":
            MessageLookupByLibrary.simpleMessage("您拒绝了权限请求，无法开始计时"),
        "rejectionTestRingtonePermission":
            MessageLookupByLibrary.simpleMessage("您拒绝了权限请求，无法测试响铃"),
        "reminderAlarm": MessageLookupByLibrary.simpleMessage("闹钟提醒"),
        "reminderModeButtonTip": MessageLookupByLibrary.simpleMessage("提醒模式"),
        "reminderNone": MessageLookupByLibrary.simpleMessage("无提醒"),
        "reminderNotification": MessageLookupByLibrary.simpleMessage("仅通知"),
        "reminderVibration": MessageLookupByLibrary.simpleMessage("震动提醒"),
        "ringtoneRegistered": MessageLookupByLibrary.simpleMessage("响铃已注册"),
        "setting": MessageLookupByLibrary.simpleMessage("设置"),
        "settingAboutTitle": MessageLookupByLibrary.simpleMessage("关于"),
        "settingAutoNextTitle":
            MessageLookupByLibrary.simpleMessage("自动开始下一次番茄"),
        "settingBtnTooltip": MessageLookupByLibrary.simpleMessage("设置"),
        "settingDarkModeTitle": MessageLookupByLibrary.simpleMessage("深色模式"),
        "settingLanguageTitle": MessageLookupByLibrary.simpleMessage("语言"),
        "settingRequestRestart":
            MessageLookupByLibrary.simpleMessage("设置成功，重启应用生效"),
        "settingRingtoneTitle": MessageLookupByLibrary.simpleMessage("铃声"),
        "settingThemeTitle": MessageLookupByLibrary.simpleMessage("主题"),
        "settingTitle": MessageLookupByLibrary.simpleMessage("设置"),
        "shortBreak": MessageLookupByLibrary.simpleMessage("小休息"),
        "shortBreakNotificationContent": MessageLookupByLibrary.simpleMessage(
            "短暂的休息可以让你更有活力，准备好迎接下一个专注时段吧! 🌟"),
        "shortBreakNotificationTitle":
            MessageLookupByLibrary.simpleMessage("短暂休息!"),
        "sponsor": MessageLookupByLibrary.simpleMessage("赞助"),
        "startBtn": MessageLookupByLibrary.simpleMessage("开始"),
        "version": MessageLookupByLibrary.simpleMessage("版本")
      };
}
