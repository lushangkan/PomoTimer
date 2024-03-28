import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class FastForwardButton extends StatelessWidget {
  const FastForwardButton({super.key, required this.onPressed});

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var iconColor = theme.colorScheme.onBackground;

    var buttonStyle = TextButton.styleFrom(
      shape: const CircleBorder(),
      padding: const EdgeInsets.all(15),
    );

    return TextButton(
      onPressed: onPressed,
      style: buttonStyle,
      child: Icon(
        LucideIcons.fast_forward,
        color: iconColor,
      ),
    );
  }
}
