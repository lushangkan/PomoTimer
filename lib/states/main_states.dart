import 'dart:convert';
import 'dart:core';

import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pomotimer/common/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/reflector.dart';

part 'main_states.g.dart';

@reflector
@JsonSerializable()
// TODO: 完善单元测试
class MainStates extends ChangeNotifier {
  /// @loadFromStorage 是否从储存中加载

  bool? timerRunning; // 是否正在执行中
  DateTime? startTime; // 开始时间

  int? customFocusTime; // 自定义专注时间
  int? customShortBreakTime; // 自定义短休息时间
  int? customLongBreakTime; // 自定义长休息时间

  MainStates({
    this.timerRunning,
    this.startTime,
    this.customFocusTime,
    this.customShortBreakTime,
    this.customLongBreakTime,
  }) {
    for (var element in _AppStates.values) {
      var mirror = reflector.reflect(this);

      var varValue = mirror.invokeGetter(element.name);

      if (varValue == null && !element.canBeNull) {
        logger.t('${element.name} is null, setting to default value: ${element.defaultValue}');
        mirror.invokeSetter(element.name, element.defaultValue);
      }
    }

    notifyListeners();
  }

  factory MainStates.fromJson(Map<String, dynamic> json) =>_$MainStatesFromJson(json);

  factory MainStates.fromJsonText(String json) => _$MainStatesFromJson(jsonDecode(json) as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$MainStatesToJson(this);

  String toJsonText() => jsonEncode(toJson());

  void _saveToStorage() async {
    logger.d('Saving main states to storage');

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('states', toJsonText());
  }

  static Future<MainStates> loadFromStorage() async {
    logger.d('Loading main states from storage');

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var jsonText = prefs.getString('states');

    jsonText ??= '{}';

    dynamic json;

    try {
      json = jsonDecode(jsonText);
      if (json != null) {
        json = json as Map<String, dynamic>;
      } else {
        json = {};
      }
    } on FormatException catch (e) {
      logger.e('Error loading from storage: ${e.toString()}');

      json = {};
    }

    return MainStates.fromJson(json);
  }

  @override
  void notifyListeners() {
    super.notifyListeners();

    _saveToStorage();
  }

}

/// 状态枚举
enum _AppStates {
  timerRunning(false, false),
  startTime(-1, true),
  customFocusTime(25 * 60, false),
  customShortBreakTime(5 * 60, false), // 5 分钟
  customLongBreakTime(15 * 60, false); // 15 分钟

  final Object? defaultValue; // 默认值
  final bool canBeNull; // 是否可以为null

  const _AppStates(this.defaultValue, this.canBeNull);
}