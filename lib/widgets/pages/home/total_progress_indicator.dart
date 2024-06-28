import 'package:flutter/material.dart';


class TotalProgressIndicator extends StatelessWidget {
  const TotalProgressIndicator({super.key, required this.elapsedTime, required this.totalTime});

  final int elapsedTime;
  final int totalTime;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 300,
      width: 8,
      child: RotatedBox(
        quarterTurns: 3,
        child: LinearProgressIndicator(
          value: elapsedTime / totalTime,
          backgroundColor: colorScheme.surfaceContainer,
          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(9999), bottomRight: Radius.circular(9999)),
        ),
      ),
    );
  }
}