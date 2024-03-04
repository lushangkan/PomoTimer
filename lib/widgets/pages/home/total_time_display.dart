import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../common/app_utils.dart';
import '../../../common/attribute.dart';
import '../../../common/timer_utils.dart';

class TotalTimeDisplay extends StatelessWidget {
  const TotalTimeDisplay({super.key, required this.customTimes, required this.longBreakInterval});

  final Map<Attribute, int> customTimes;
  final int longBreakInterval;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    var timeTextStyle = theme.textTheme.bodyLarge!.copyWith(
      fontWeight: FontWeight.w400,
      color: colorScheme.onPrimaryContainer
    );

    var descriptionTextStyle = theme.textTheme.bodySmall!.copyWith(
      fontWeight: FontWeight.w200,
      color: colorScheme.onPrimaryContainer.withOpacity(0.5)
    );

    int totalTime = calculateTotalTime(customTimes, longBreakInterval);
    String languageCode = getAppLocal(context)!;

    var timeText = DateFormat.jms(languageCode).format(DateTime.fromMillisecondsSinceEpoch(totalTime * 60 * 1000 , isUtc: true));

    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(9999),
          boxShadow: [
            BoxShadow(
              color: colorScheme.primaryContainer.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 8,
              offset: Offset.zero,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            Text(
              timeText,
              style: timeTextStyle,
            ),
            Text(
              '预计时间',
              style: descriptionTextStyle,
            ),
          ],
        ),
      )
    );
  }
}