import 'package:flutter/material.dart';
import 'package:pomotimer/widgets/pages/home/secondary_control_button.dart';

class PauseButton extends SecondaryControlButton {
  const PauseButton({super.key, required super.onPressed}) : super(icon: Icons.pause_rounded);
}