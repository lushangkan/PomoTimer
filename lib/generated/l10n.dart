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

  /// `专注`
  String get focus {
    return Intl.message(
      '专注',
      name: 'focus',
      desc: '',
      args: [],
    );
  }

  /// `小休息`
  String get shortBreak {
    return Intl.message(
      '小休息',
      name: 'shortBreak',
      desc: '',
      args: [],
    );
  }

  /// `大休息`
  String get longBreak {
    return Intl.message(
      '大休息',
      name: 'longBreak',
      desc: '',
      args: [],
    );
  }

  /// `推荐设置为{time}分钟`
  String recommendTime(Object time) {
    return Intl.message(
      '推荐设置为$time分钟',
      name: 'recommendTime',
      desc: '',
      args: [time],
    );
  }

  /// `预计时间`
  String get estimatedTime {
    return Intl.message(
      '预计时间',
      name: 'estimatedTime',
      desc: '',
      args: [],
    );
  }

  /// `提醒模式`
  String get reminderModeButtonTip {
    return Intl.message(
      '提醒模式',
      name: 'reminderModeButtonTip',
      desc: '',
      args: [],
    );
  }

  /// `阶段`
  String get phase {
    return Intl.message(
      '阶段',
      name: 'phase',
      desc: '',
      args: [],
    );
  }

  /// `设置`
  String get setting {
    return Intl.message(
      '设置',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `跟随系统`
  String get followSystem {
    return Intl.message(
      '跟随系统',
      name: 'followSystem',
      desc: '',
      args: [],
    );
  }

  /// `取消`
  String get cancel {
    return Intl.message(
      '取消',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `选择语言`
  String get chooseLanguage {
    return Intl.message(
      '选择语言',
      name: 'chooseLanguage',
      desc: '',
      args: [],
    );
  }

  /// `暗色模式`
  String get darkMode {
    return Intl.message(
      '暗色模式',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `总是开启`
  String get alwaysOn {
    return Intl.message(
      '总是开启',
      name: 'alwaysOn',
      desc: '',
      args: [],
    );
  }

  /// `总是关闭`
  String get alwaysOff {
    return Intl.message(
      '总是关闭',
      name: 'alwaysOff',
      desc: '',
      args: [],
    );
  }

  /// `选择主题`
  String get chooseTheme {
    return Intl.message(
      '选择主题',
      name: 'chooseTheme',
      desc: '',
      args: [],
    );
  }

  /// `选择铃声`
  String get chooseRingtone {
    return Intl.message(
      '选择铃声',
      name: 'chooseRingtone',
      desc: '',
      args: [],
    );
  }

  /// `默认铃声`
  String get defaultRingtone {
    return Intl.message(
      '默认铃声',
      name: 'defaultRingtone',
      desc: '',
      args: [],
    );
  }

  /// `从存储中选择`
  String get fromStorage {
    return Intl.message(
      '从存储中选择',
      name: 'fromStorage',
      desc: '',
      args: [],
    );
  }

  /// `版本`
  String get version {
    return Intl.message(
      '版本',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `开发者`
  String get developer {
    return Intl.message(
      '开发者',
      name: 'developer',
      desc: '',
      args: [],
    );
  }

  /// `路上看见`
  String get lushangkan {
    return Intl.message(
      '路上看见',
      name: 'lushangkan',
      desc: '',
      args: [],
    );
  }

  /// `源码仓库`
  String get codeRepo {
    return Intl.message(
      '源码仓库',
      name: 'codeRepo',
      desc: '',
      args: [],
    );
  }

  /// `项目协议`
  String get codeLicense {
    return Intl.message(
      '项目协议',
      name: 'codeLicense',
      desc: '',
      args: [],
    );
  }

  /// `鸣谢`
  String get acknowledgments {
    return Intl.message(
      '鸣谢',
      name: 'acknowledgments',
      desc: '',
      args: [],
    );
  }

  /// `提供Logo设计指导`
  String get acknowledgmentsLogoDesign {
    return Intl.message(
      '提供Logo设计指导',
      name: 'acknowledgmentsLogoDesign',
      desc: '',
      args: [],
    );
  }

  /// `版权信息`
  String get copyrightInfo {
    return Intl.message(
      '版权信息',
      name: 'copyrightInfo',
      desc: '',
      args: [],
    );
  }

  /// `字体`
  String get fontCopyRight {
    return Intl.message(
      '字体',
      name: 'fontCopyRight',
      desc: '',
      args: [],
    );
  }

  /// `赞助`
  String get sponsor {
    return Intl.message(
      '赞助',
      name: 'sponsor',
      desc: '',
      args: [],
    );
  }

  /// `爱发电`
  String get afadiana {
    return Intl.message(
      '爱发电',
      name: 'afadiana',
      desc: '',
      args: [],
    );
  }

  /// `问题反馈`
  String get bugReport {
    return Intl.message(
      '问题反馈',
      name: 'bugReport',
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
