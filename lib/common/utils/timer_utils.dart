import '../enum/attribute.dart';

/// 计算总时间
/// @customTimes 自定义时间
/// @longBreakInterval 长休息间隔
/// @return 总时间, 单位: 分钟
int? calculateTotalTime(Map<Phase, int> customTimes, int longBreakInterval) {
  if (customTimes.values.any((time) => time < 0) || longBreakInterval < 0) {
    return null;
  }

  var focusTime = customTimes[Phase.focus]!;
  var shortBreakTime = customTimes[Phase.shortBreak]!;
  var longBreakTime = customTimes[Phase.longBreak]!;

  return focusTime * longBreakInterval + shortBreakTime * (longBreakInterval - 1) + longBreakTime;
}