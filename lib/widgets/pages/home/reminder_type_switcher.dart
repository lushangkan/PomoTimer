import 'package:flutter/material.dart';
import 'package:pomotimer/common/constants.dart';
import 'package:pomotimer/common/enum/reminder_type.dart';
import 'package:pomotimer/states/main_states.dart';
import 'package:provider/provider.dart';

class ReminderTypeSwitcher extends StatelessWidget {
  const ReminderTypeSwitcher({super.key, required this.reminderType, required this.onSelected});

  final ReminderType reminderType;
  final void Function(ReminderType) onSelected;

  @override
  Widget build(BuildContext context) {
    MainStates mainStates = context.watch<MainStates>();

    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;

    var iconColor = colorScheme.onBackground;

    return Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(9999),
        ),
        child: PopupMenuButton(
          // TODO: PopupMenuButton背景颜色和color不一致，提交issue
          tooltip: "选择提醒类型",
          icon: Icon(reminderType?.icon),
          onSelected: (ReminderType? value) {
            if (value != null) {
              onSelected(value);
            }
          },
          offset: const Offset(0, 25),
          padding: const EdgeInsets.only(left: 12, right: 8, top: 8, bottom: 8),
          itemBuilder: (BuildContext context) => ReminderType.values
              .where((e) => e != reminderType)
              .map((e) => PopupMenuItem(
                    value: e,
                    child: Row(
                      children: [
                        Icon(e.icon, color: iconColor,),
                        const SizedBox(width: 15),
                        Text(Constants.reminderTypeTranslation[e]!(context)),
                      ],
                    ),
                  ))
              .toList(),
          color: colorScheme.background,
        ));
  }
}
