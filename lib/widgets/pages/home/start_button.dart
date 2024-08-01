import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';
import 'package:pomotimer/common/app_text_style.dart';

import '../../../generated/l10n.dart';

class StartButton extends StatelessWidget {
  const StartButton({super.key, required this.onPressed});

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    var colorScheme = theme.colorScheme;

    var textStyle =
        AppTextStyle.generateWithTextStyle(theme.textTheme.titleLarge!.copyWith(
      color: colorScheme.onPrimary,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ));

    var buttonColor = colorScheme.primary;

    return DropShadow(
      color: colorScheme.primary.withOpacity(1),
      offset: Offset.zero,
      blurRadius: 8,
      child: FilledButton(
          style: FilledButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            minimumSize: const Size(80, 63),

            backgroundColor: buttonColor,
          ),
          onPressed: onPressed,
          child: Text(
            S.current.startBtn,
            softWrap: false,
            style: textStyle,
          )),
    );
  }
}
