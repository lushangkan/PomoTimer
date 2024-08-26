import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pomotimer/common/utils/timer_utils.dart';

import '../../../common/enum/attribute.dart';
import '../../../common/utils/app_utils.dart';
import '../../../generated/l10n.dart';


class TotalTimeDisplay extends StatelessWidget {
  const TotalTimeDisplay({super.key, required this.customTimes, required this.longBreakInterval});

  final Map<Phase, int> customTimes;
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

    var totalTime = (calculateTotalTime(customTimes, longBreakInterval) ?? 0) * 60 * 1000;

    String? languageCode = getAppLocal(context);

    String timeText;

    if (languageCode == null) {
      timeText = DateFormat.Hms().format(DateTime.fromMillisecondsSinceEpoch(totalTime , isUtc: true));
    } else {
      timeText = DateFormat.Hms(languageCode).format(DateTime.fromMillisecondsSinceEpoch(totalTime , isUtc: true));
    }

    return Center(
      child: Container(
        height: 60,
        width: 180,
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
              S.current.estimatedTime,
              style: descriptionTextStyle,
            ),
          ],
        ),
      )
    );
  }
}