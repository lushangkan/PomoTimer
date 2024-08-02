// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appName": MessageLookupByLibrary.simpleMessage("PomoTimer"),
        "focusNotificationContent": MessageLookupByLibrary.simpleMessage(
            "It’s time to dive back into work with full concentration! 🔥"),
        "focusNotificationTitle":
            MessageLookupByLibrary.simpleMessage("Focus Time!"),
        "foregroundNotificationDescription":
            MessageLookupByLibrary.simpleMessage(
                "The timer is being processed in the background..."),
        "longBreakNotificationContent": MessageLookupByLibrary.simpleMessage(
            "You’ve been working hard, now it’s time to unwind and recharge before you go again! 🍹"),
        "longBreakNotificationTitle":
            MessageLookupByLibrary.simpleMessage("Relaxation Time!"),
        "notificationStopButton": MessageLookupByLibrary.simpleMessage("Stop"),
        "reminderAlarm": MessageLookupByLibrary.simpleMessage("Alarm"),
        "reminderNone": MessageLookupByLibrary.simpleMessage("None"),
        "reminderNotification":
            MessageLookupByLibrary.simpleMessage("Notification"),
        "reminderVibration": MessageLookupByLibrary.simpleMessage("Vibration"),
        "settingAboutTitle": MessageLookupByLibrary.simpleMessage("About"),
        "settingAutoNextTitle":
            MessageLookupByLibrary.simpleMessage("Auto Start Next Pomodoro"),
        "settingBtnTooltip": MessageLookupByLibrary.simpleMessage("Settings"),
        "settingLanguageTitle":
            MessageLookupByLibrary.simpleMessage("Language"),
        "settingRingtoneTitle":
            MessageLookupByLibrary.simpleMessage("Ringtone"),
        "settingThemeTitle": MessageLookupByLibrary.simpleMessage("Theme"),
        "settingTitle": MessageLookupByLibrary.simpleMessage("Settings"),
        "shortBreakNotificationContent": MessageLookupByLibrary.simpleMessage(
            "A quick break will refresh you and get you ready for the next focus session! 🌟"),
        "shortBreakNotificationTitle":
            MessageLookupByLibrary.simpleMessage("Short Break!"),
        "startBtn": MessageLookupByLibrary.simpleMessage("Start")
      };
}
