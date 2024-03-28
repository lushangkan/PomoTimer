import 'package:flutter/material.dart';

abstract class SecondaryControlButton extends StatelessWidget {
  const SecondaryControlButton({super.key, required this.onPressed, required this.icon});

  final void Function() onPressed;
  final IconData icon;

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
        icon,
        color: iconColor,
      ),
    );
  }
}