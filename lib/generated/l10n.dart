// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `PomoTimer`
  String get appName {
    return Intl.message(
      'PomoTimer',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `计时器正在后台处理...`
  String get foregroundNotificationDescription {
    return Intl.message(
      '计时器正在后台处理...',
      name: 'foregroundNotificationDescription',
      desc: '',
      args: [],
    );
  }

  /// `设置`
  String get settingBtnTooltip {
    return Intl.message(
      '设置',
      name: 'settingBtnTooltip',
      desc: '',
      args: [],
    );
  }

  /// `无提醒`
  String get reminderNone {
    return Intl.message(
      '无提醒',
      name: 'reminderNone',
      desc: '',
      args: [],
    );
  }

  /// `仅通知`
  String get reminderNotification {
    return Intl.message(
      '仅通知',
      name: 'reminderNotification',
      desc: '',
      args: [],
    );
  }

  /// `震动提醒`
  String get reminderVibration {
    return Intl.message(
      '震动提醒',
      name: 'reminderVibration',
      desc: '',
      args: [],
    );
  }

  /// `闹钟提醒`
  String get reminderAlarm {
    return Intl.message(
      '闹钟提醒',
      name: 'reminderAlarm',
      desc: '',
      args: [],
    );
  }

  /// `开始`
  String get startBtn {
    return Intl.message(
      '开始',
      name: 'startBtn',
      desc: '',
      args: [],
    );
  }

  /// `集中注意力!`
  String get focusNotificationTitle {
    return Intl.message(
      '集中注意力!',
      name: 'focusNotificationTitle',
      desc: '',
      args: [],
    );
  }

  /// `专注的时间开始了, 让我们沉浸在工作中吧! 🔥`
  String get focusNotificationContent {
    return Intl.message(
      '专注的时间开始了, 让我们沉浸在工作中吧! 🔥',
      name: 'focusNotificationContent',
      desc: '',
      args: [],
    );
  }

  /// `短暂休息!`
  String get shortBreakNotificationTitle {
    return Intl.message(
      '短暂休息!',
      name: 'shortBreakNotificationTitle',
      desc: '',
      args: [],
    );
  }

  /// `短暂的休息可以让你更有活力，准备好迎接下一个专注时段吧! 🌟`
  String get shortBreakNotificationContent {
    return Intl.message(
      '短暂的休息可以让你更有活力，准备好迎接下一个专注时段吧! 🌟',
      name: 'shortBreakNotificationContent',
      desc: '',
      args: [],
    );
  }

  /// `放松时间!`
  String get longBreakNotificationTitle {
    return Intl.message(
      '放松时间!',
      name: 'longBreakNotificationTitle',
      desc: '',
      args: [],
    );
  }

  /// `你已经非常努力了，现在是时候放松一下，充充电，再继续前行! 🍹`
  String get longBreakNotificationContent {
    return Intl.message(
      '你已经非常努力了，现在是时候放松一下，充充电，再继续前行! 🍹',
      name: 'longBreakNotificationContent',
      desc: '',
      args: [],
    );
  }

  /// `停止`
  String get notificationStopButton {
    return Intl.message(
      '停止',
      name: 'notificationStopButton',
      desc: '',
      args: [],
    );
  }

  /// `设置`
  String get settingTitle {
    return Intl.message(
      '设置',
      name: 'settingTitle',
      desc: '',
      args: [],
    );
  }

  /// `语言`
  String get settingLanguageTitle {
    return Intl.message(
      '语言',
      name: 'settingLanguageTitle',
      desc: '',
      args: [],
    );
  }

  /// `主题`
  String get settingThemeTitle {
    return Intl.message(
      '主题',
      name: 'settingThemeTitle',
      desc: '',
      args: [],
    );
  }

  /// `深色模式`
  String get settingDarkModeTitle {
    return Intl.message(
      '深色模式',
      name: 'settingDarkModeTitle',
      desc: '',
      args: [],
    );
  }

  /// `自动开始下一次番茄`
  String get settingAutoNextTitle {
    return Intl.message(
      '自动开始下一次番茄',
      name: 'settingAutoNextTitle',
      desc: '',
      args: [],
    );
  }

  /// `铃声`
  String get settingRingtoneTitle {
    return Intl.message(
      '铃声',
      name: 'settingRingtoneTitle',
      desc: '',
      args: [],
    );
  }

  /// `关于`
  String get settingAboutTitle {
    return Intl.message(
      '关于',
      name: 'settingAboutTitle',
      desc: '',
      args: [],
    );
  }

  /// `设置成功，重启应用生效`
  String get settingRequestRestart {
    return Intl.message(
      '设置成功，重启应用生效',
      name: 'settingRequestRestart',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'zh'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
