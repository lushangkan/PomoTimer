import 'package:flutter/cupertino.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

enum ReminderType {
  none(LucideIcons.alarm_clock_off),
  notification(LucideIcons.bell_dot),
  vibration(LucideIcons.vibrate),
  alarm(LucideIcons.alarm_clock);

  final IconData icon;

  const ReminderType(this.icon);
}