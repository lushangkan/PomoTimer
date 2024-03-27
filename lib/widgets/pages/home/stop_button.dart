import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class StopButton extends StatelessWidget {
  const StopButton({super.key, required this.onPressed});

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;

    var iconColor = colorScheme.onError;
    var buttonColor = colorScheme.error;
    var buttonStyle = FilledButton.styleFrom(
      shape: const CircleBorder(),
      minimumSize: const Size.square(65),
      backgroundColor: buttonColor,
    );

    return FilledButton(
      onPressed: onPressed,
      style: buttonStyle,
      child: Icon(LucideIcons.square, color: iconColor, size: 25,),
    );
  }

}