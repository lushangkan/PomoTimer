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

  static String m0(link, reason) =>
      "Cannot open link: ${link} Reason: ${reason}";

  static String m1(time) => "Recommended to set to ${time} minutes";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "acknowledgments":
            MessageLookupByLibrary.simpleMessage("Acknowledgments"),
        "acknowledgmentsLogoDesign": MessageLookupByLibrary.simpleMessage(
            "Provided logo design guidance"),
        "afadiana": MessageLookupByLibrary.simpleMessage("Afadiana"),
        "alwaysOff": MessageLookupByLibrary.simpleMessage("Always Off"),
        "alwaysOn": MessageLookupByLibrary.simpleMessage("Always On"),
        "appName": MessageLookupByLibrary.simpleMessage("PomoTimer"),
        "bugReport": MessageLookupByLibrary.simpleMessage("Bug Report"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "cannotOpenLink": m0,
        "chooseLanguage":
            MessageLookupByLibrary.simpleMessage("Choose Language"),
        "chooseRingtone":
            MessageLookupByLibrary.simpleMessage("Choose Ringtone"),
        "chooseTheme": MessageLookupByLibrary.simpleMessage("Choose Theme"),
        "codeLicense": MessageLookupByLibrary.simpleMessage("Project License"),
        "codeRepo": MessageLookupByLibrary.simpleMessage("Repo"),
        "copyrightInfo":
            MessageLookupByLibrary.simpleMessage("Copyright Information"),
        "darkMode": MessageLookupByLibrary.simpleMessage("Dark Mode"),
        "defaultRingtone":
            MessageLookupByLibrary.simpleMessage("Default Ringtone"),
        "developer": MessageLookupByLibrary.simpleMessage("Developer"),
        "estimatedTime": MessageLookupByLibrary.simpleMessage("Estimated Time"),
        "fileHasNotAudio": MessageLookupByLibrary.simpleMessage(
            "The file does not contain audio"),
        "focus": MessageLookupByLibrary.simpleMessage("Focus"),
        "focusNotificationContent": MessageLookupByLibrary.simpleMessage(
            "It’s time to dive back into work with full concentration! 🔥"),
        "focusNotificationTitle":
            MessageLookupByLibrary.simpleMessage("Focus Time!"),
        "followSystem": MessageLookupByLibrary.simpleMessage("Follow System"),
        "fontCopyRight": MessageLookupByLibrary.simpleMessage("Font"),
        "foregroundNotificationDescription":
            MessageLookupByLibrary.simpleMessage(
                "The timer is being processed in the background..."),
        "fromStorage":
            MessageLookupByLibrary.simpleMessage("Choose from Storage"),
        "longBreak": MessageLookupByLibrary.simpleMessage("Long Break"),
        "longBreakNotificationContent": MessageLookupByLibrary.simpleMessage(
            "You’ve been working hard, now it’s time to unwind and recharge before you go again! 🍹"),
        "longBreakNotificationTitle":
            MessageLookupByLibrary.simpleMessage("Relaxation Time!"),
        "lushangkan": MessageLookupByLibrary.simpleMessage("lushangkan"),
        "needBackgroundPermission":
            MessageLookupByLibrary.simpleMessage("Permission Required"),
        "needBackgroundPermissionContent": MessageLookupByLibrary.simpleMessage(
            "The timer needs to run continuously in the background to remind you in time.\nA permission settings page may pop up. If it does, please set this app to \'Unrestricted\' or allow it to run in the background."),
        "needNotificationPermission":
            MessageLookupByLibrary.simpleMessage("Permission Required"),
        "needNotificationPermissionContent": MessageLookupByLibrary.simpleMessage(
            "The timer needs notification permissions to remind you in time.\nPlease allow floating notifications and lock screen notifications for this app."),
        "needPermission":
            MessageLookupByLibrary.simpleMessage("Permission Required"),
        "needPermissionContent": MessageLookupByLibrary.simpleMessage(
            "Starting the timer requires some permissions. Do you want to continue?"),
        "needPopoutPermission":
            MessageLookupByLibrary.simpleMessage("Permission Required"),
        "needPopoutPermissionContent": MessageLookupByLibrary.simpleMessage(
            "The timer needs to pop up a window to remind you when a stage is reached.\nA permission settings page may pop up. If it does, please set this app to \'Allow in Do Not Disturb mode\'."),
        "needStoragePermission":
            MessageLookupByLibrary.simpleMessage("Permission Required"),
        "needStoragePermissionContent": MessageLookupByLibrary.simpleMessage(
            "Selecting a ringtone requires access to storage. Do you want to continue?"),
        "notChooseFile":
            MessageLookupByLibrary.simpleMessage("No file selected"),
        "notificationStopButton": MessageLookupByLibrary.simpleMessage("Stop"),
        "permissionNotGranted":
            MessageLookupByLibrary.simpleMessage("Permission not granted"),
        "phase": MessageLookupByLibrary.simpleMessage("Phase"),
        "recommendTime": m1,
        "rejectionPermission": MessageLookupByLibrary.simpleMessage(
            "You have denied the permission request, unable to start the timer"),
        "rejectionTestRingtonePermission": MessageLookupByLibrary.simpleMessage(
            "You have denied the permission request, unable to test the ringtone"),
        "reminderAlarm": MessageLookupByLibrary.simpleMessage("Alarm"),
        "reminderModeButtonTip":
            MessageLookupByLibrary.simpleMessage("Reminder Mode"),
        "reminderNone": MessageLookupByLibrary.simpleMessage("None"),
        "reminderNotification":
            MessageLookupByLibrary.simpleMessage("Notification"),
        "reminderVibration": MessageLookupByLibrary.simpleMessage("Vibration"),
        "ringtoneRegistered":
            MessageLookupByLibrary.simpleMessage("Ringtone registered"),
        "setting": MessageLookupByLibrary.simpleMessage("Setting"),
        "settingAboutTitle": MessageLookupByLibrary.simpleMessage("About"),
        "settingAutoNextTitle":
            MessageLookupByLibrary.simpleMessage("Auto Start Next Pomodoro"),
        "settingBtnTooltip": MessageLookupByLibrary.simpleMessage("Settings"),
        "settingDarkModeTitle":
            MessageLookupByLibrary.simpleMessage("Dark Mode"),
        "settingLanguageTitle":
            MessageLookupByLibrary.simpleMessage("Language"),
        "settingRequestRestart": MessageLookupByLibrary.simpleMessage(
            "Restart the application to apply the changes."),
        "settingRingtoneTitle":
            MessageLookupByLibrary.simpleMessage("Ringtone"),
        "settingThemeTitle": MessageLookupByLibrary.simpleMessage("Theme"),
        "settingTitle": MessageLookupByLibrary.simpleMessage("Settings"),
        "shortBreak": MessageLookupByLibrary.simpleMessage("Short Break"),
        "shortBreakNotificationContent": MessageLookupByLibrary.simpleMessage(
            "A quick break will refresh you and get you ready for the next focus session! 🌟"),
        "shortBreakNotificationTitle":
            MessageLookupByLibrary.simpleMessage("Short Break!"),
        "sponsor": MessageLookupByLibrary.simpleMessage("Sponsor"),
        "startBtn": MessageLookupByLibrary.simpleMessage("Start"),
        "version": MessageLookupByLibrary.simpleMessage("Version")
      };
}
