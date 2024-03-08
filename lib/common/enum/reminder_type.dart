import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

enum ReminderType {
  none(LucideIcons.alarmClockOff),
  notification(LucideIcons.bellDot),
  vibration(LucideIcons.vibrate),
  alarm(LucideIcons.alarmClock);

  final IconData icon;

  const ReminderType(this.icon);
}