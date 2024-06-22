import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:go_router/go_router.dart';
import 'package:pomotimer/common/alarm/alarm.dart';
import 'package:pomotimer/common/channel/flutter_method_channel.dart';
import 'package:pomotimer/common/enum/reminder_type.dart';
import 'package:pomotimer/common/permission_handle.dart';
import 'package:provider/provider.dart';

import '../../common/enum/attribute.dart';
import '../../common/timer/timer.dart';
import '../../states/timer_states.dart';
import '../pages/home/reminder_type_switcher.dart';

class DebuggingTools extends StatelessWidget {
  const DebuggingTools({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;

    var timerStates = context.watch<TimerStates>();
    var timer = AppTimer.instance;

    Future<int?> showFastForwardToEndDialog() async {
      return await showDialog<int>(
          context: context,
          builder: (context) => FastForwardToEndDialog(
              onPressed: (int seconds) {
                var newTime = timer.remainingTime! - seconds * 1000;
                if (newTime < 0) {
                  newTime = 0;
                }
                timer.setOffsetTime(newTime + (timerStates.offsetTime ?? 0));
              },
              onCancel: () {}));
    }

    Future<int?> showFastForwardToSpecificTimeDialog() async {
      return await showDialog<int>(
          context: context,
          builder: (context) => FastForwardToSpecificTimeDialog(
              onPressed: (int seconds) {
                var newTime = seconds * 1000;
                timer.fastForward(newTime);
              },
              onCancel: () {}));
    }

    Future<int?> showAlarmTestDialog() async {
      return await showDialog<int>(
          context: context,
          builder: (context) => AlarmTestDialog(
              onPressed: (int seconds) async {
                if (await permissionHandle.requestPermission(context)) {
                  var time = DateTime.now().toUtc().add(Duration(seconds: seconds));

                  var alarm = Alarm(id: 252, timestamp: time.millisecondsSinceEpoch, vibrate: true, audioPath: 'assets/media/default_ring.mp3', fromAppAsset: true, loop: true, loopTimes: 50, notificationTitle: "Test", notificationContent: "Test");

                  FlutterMethodChannel.instance.registerAlarm(alarm);

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("响铃已注册")));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("您拒绝了权限请求，无法测试响铃")));
                }
              },
              onCancel: () {}));
    }

    Future<int?> showCustomTimerTimeDialog() async {
      return await showDialog<int>(
          context: context,
          builder: (context) => CustomTimerTimeDialog(
              onPressed: (focus, shortBreak, longBreak, reminderType) {
                if (!context.mounted) {
                  return;
                }

                timer.setReminderType(reminderType);
                timer.setCustomTimes({
                  Phase.focus: focus,
                  Phase.shortBreak: shortBreak,
                  Phase.longBreak: longBreak,
                });

                timer.start();

                context.go('/in-progress');
              },


              onCancel: () {}));
    }

    return PopupMenuButton(
        icon: Icon(
          LucideIcons.bug,
          color: colorScheme.onSurface,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onSelected: (dynamic value) async {
          switch (value) {
            case DebuggingTypeButton.fastForwardToStart:
              if (!timer.isRunning) return;
              showFastForwardToEndDialog();
            case DebuggingTypeButton.fastForwardToSpecificTime:
              if (!timer.isRunning) return;
              showFastForwardToSpecificTimeDialog();
            case DebuggingTypeButton.testAlarm:
              showAlarmTestDialog();
            case DebuggingTypeButton.customTimerTime:
              if (timer.isRunning) return;
              showCustomTimerTimeDialog();
          }
        },
        itemBuilder: (context) => [
              if (timer.isRunning) const FastForwardToEnd(),
              if (timer.isRunning) const FastForwardToSpecificTime(),
              const TestAlarm(),
              if (!timer.isRunning) const CustomTimerTime(),
            ]);
  }
}

enum DebuggingTypeButton {
  fastForwardToStart,
  fastForwardToSpecificTime,
  testAlarm,
  customTimerTime,
}

class FastForwardToEnd extends PopupMenuItem {
  const FastForwardToEnd({super.key})
      : super(
          child: const Text("快进到末尾指定时间"),
          value: DebuggingTypeButton.fastForwardToStart,
        );
}

class FastForwardToEndDialog extends StatefulWidget {
  const FastForwardToEndDialog(
      {super.key, required this.onPressed, required this.onCancel});

  final void Function(int) onPressed;
  final void Function() onCancel;

  @override
  State<FastForwardToEndDialog> createState() => _FastForwardToEndDialogState();
}

class _FastForwardToEndDialogState extends State<FastForwardToEndDialog> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.text = "3";

    return AlertDialog(
      title: const Text("快进到末尾指定时间"),
      content: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.done,
        decoration: const InputDecoration(
          hintText: "要快进到的剩余秒数",
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.onCancel();
            Navigator.of(context).pop();
          },
          child: const Text("取消"),
        ),
        TextButton(
          onPressed: () {
            widget.onPressed(int.parse(controller.text));
            Navigator.of(context).pop();
          },
          child: const Text("确定"),
        ),
      ],
    );
  }
}

class FastForwardToSpecificTime extends PopupMenuItem {
  const FastForwardToSpecificTime({super.key})
      : super(
          child: const Text("快进到指定时间"),
          value: DebuggingTypeButton.fastForwardToSpecificTime,
        );
}

class FastForwardToSpecificTimeDialog extends StatefulWidget {
  const FastForwardToSpecificTimeDialog(
      {super.key, required this.onPressed, required this.onCancel});

  final void Function(int) onPressed;
  final void Function() onCancel;

  @override
  State<FastForwardToSpecificTimeDialog> createState() =>
      _FastForwardToSpecificTimeDialogState();
}

class _FastForwardToSpecificTimeDialogState
    extends State<FastForwardToSpecificTimeDialog> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.text = "3";

    return AlertDialog(
      title: const Text("快进到指定时间"),
      content: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.done,
        decoration: const InputDecoration(
          hintText: "要快进到的秒数",
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.onCancel();
            Navigator.of(context).pop();
          },
          child: const Text("取消"),
        ),
        TextButton(
          onPressed: () {
            widget.onPressed(int.parse(controller.text));
            Navigator.of(context).pop();
          },
          child: const Text("确定"),
        ),
      ],
    );
  }
}

class TestAlarm extends PopupMenuItem {
  const TestAlarm({super.key})
      : super(
          child: const Text("测试响铃"),
          value: DebuggingTypeButton.testAlarm,
        );
}

class AlarmTestDialog extends StatefulWidget {
  const AlarmTestDialog({Key? key, required this.onPressed, required this.onCancel}) : super(key: key);

  final void Function(int) onPressed;
  final void Function() onCancel;

  @override
  _AlarmTestDialogState createState() => _AlarmTestDialogState();
}

class _AlarmTestDialogState extends State<AlarmTestDialog> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.text = "5";

    return AlertDialog(
      title: const Text("测试响铃"),
      content: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.done,
        decoration: const InputDecoration(
          hintText: "请输入启动响铃的延迟（秒）",
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            widget.onCancel();
          },
          child: const Text("取消"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            widget.onPressed(int.parse(controller.text));
          },
          child: const Text("确定"),
        ),
      ],
    );
  }
}

class CustomTimerTime extends PopupMenuItem {
  const CustomTimerTime({super.key})
      : super(
    child: const Text("自定义时间"),
    value: DebuggingTypeButton.customTimerTime,
  );
}

class CustomTimerTimeDialog extends StatefulWidget {
  const CustomTimerTimeDialog({Key? key, required this.onPressed, required this.onCancel}) : super(key: key);

  final void Function(int, int, int, ReminderType) onPressed;
  final void Function() onCancel;

  @override
  _CustomTimerTimeDialogState createState() => _CustomTimerTimeDialogState();
}

class _CustomTimerTimeDialogState extends State<CustomTimerTimeDialog> {
  late TextEditingController focusController;
  late TextEditingController shortBreakController;
  late TextEditingController longBreakController;

  late ReminderType tmpReminderType;

  @override
  void initState() {
    super.initState();
    focusController = TextEditingController();
    shortBreakController = TextEditingController();
    longBreakController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    focusController.dispose();
    shortBreakController.dispose();
    longBreakController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var timerStates = context.watch<TimerStates>();

    focusController.text = "1";
    shortBreakController.text = "1";
    longBreakController.text = "1";

    tmpReminderType = timerStates.reminderType ?? ReminderType.alarm;

    var contentTextStyles = Theme.of(context).textTheme.bodyMedium;

    void onReminderTypeSwitcherSelected(ReminderType value) {
      setState(() {
        tmpReminderType = value;
      });
    }

    return AlertDialog(
      title: const Text("自定义时间"),
      content: SizedBox(
        height: 100,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("请输入自定义Timer的时间(分钟)", style: contentTextStyles,),
            SizedBox(
              width: 400,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TextField(
                        controller: focusController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          hintText: "专注",
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TextField(
                        controller: shortBreakController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          hintText: "短休息",
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TextField(
                        controller: longBreakController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          hintText: "长休息",
                        ),
                      ),
                    ),
                  ),
                  ReminderTypeSwitcher(reminderType: tmpReminderType, onSelected: onReminderTypeSwitcherSelected,),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            widget.onCancel();
          },
          child: const Text("取消"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            widget.onPressed(int.parse(focusController.text), int.parse(shortBreakController.text), int.parse(longBreakController.text), tmpReminderType);
          },
          child: const Text("开始"),
        ),
      ],
    );
  }
}

