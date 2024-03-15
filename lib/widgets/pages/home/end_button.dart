
import 'package:flutter/material.dart';

class EndButton extends StatelessWidget {
  const EndButton({super.key, required this.onPressed});

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    var colorScheme = theme.colorScheme;

    var buttonColor = colorScheme.error;

    return SizedBox();
  }


}