import 'package:flutter/material.dart';
import 'package:pomotimer/widgets/pages/home/secondary_control_button.dart';

class ResumeButton extends SecondaryControlButton {
  const ResumeButton({super.key, required super.onPressed}) : super(icon: Icons.play_arrow_rounded);
}