import '../enum/attribute.dart';

/// 计算总时间
/// @customTimes 自定义时间
/// @longBreakInterval 长休息间隔
/// @return 总时间, 单位: 分钟
int calculateTotalTime(Map<Attribute, int> customTimes, int longBreakInterval) {
  var focusTime = customTimes[Attribute.focus]!;
  var shortBreakTime = customTimes[Attribute.shortBreak]!;
  var longBreakTime = customTimes[Attribute.longBreak]!;

  return focusTime * longBreakInterval + shortBreakTime * (longBreakInterval - 1) + longBreakTime;
}