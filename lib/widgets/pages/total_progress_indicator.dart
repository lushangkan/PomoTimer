import 'package:flutter/material.dart';

class TotalProgressIndicator extends StatelessWidget {
  const TotalProgressIndicator({super.key, required this.elapsedTime, required this.totalTime});

  final int elapsedTime;
  final int totalTime;

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: elapsedTime / totalTime,
      borderRadius: BorderRadius.circular(8),
    );
  }
}