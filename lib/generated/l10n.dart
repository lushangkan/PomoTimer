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
