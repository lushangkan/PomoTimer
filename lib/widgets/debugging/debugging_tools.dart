import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:provider/provider.dart';

import '../../states/app_states.dart';

class DebuggingTools extends StatelessWidget {
  const DebuggingTools({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;

    var appStates = context.watch<AppStates>();
    var timer = appStates.timer;

    Future<int?> showFastForwardToEndDialog() async {
      return await showDialog<int>(
          context: context,
          builder: (context) => FastForwardToEndDialog(
              onPressed: (int seconds) {
                var newTime = timer.remainingTime! - seconds * 1000;
                if (newTime < 0) {
                  newTime = 0;
                }
                timer.fastForward(newTime);
              },
              onCancel: () {}));
    }

    return PopupMenuButton(
        icon: Icon(
          LucideIcons.bug,
          color: colorScheme.onBackground,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onSelected: (dynamic value) async {
          switch (value) {
            case DebuggingTypeButton.fastForwardToStart:
              if (!timer.isRunning) return;
              showFastForwardToEndDialog();
          }
        },
        itemBuilder: (context) => [
              const FastForwardToEnd(),
            ]);
  }
}

enum DebuggingTypeButton {
  fastForwardToStart,
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

    return AlertDialog(
      title: const Text("快进到末尾指定时间"),
      content: TextField(
        controller: controller,
        autofocus: true,
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
