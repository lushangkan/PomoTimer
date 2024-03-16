import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class AppCircularSlider extends StatelessWidget {
  const AppCircularSlider({super.key, this.sliderSize = 238, this.progressBarWidth = 32, required this.value, required this.min, required this.max, this.onChange, this.innerWidget, });

  final double sliderSize;
  final double progressBarWidth;
  final double value;
  final double min;
  final double max;
  final void Function(double)? onChange;
  final Widget Function(double)? innerWidget;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    double innerSize = sliderSize - progressBarWidth * 2;

    return SleekCircularSlider(
      min: min,
      max: max,
      initialValue: value,
      innerWidget: (double value) => _AppCircularSliderInner(size: innerSize, child: innerWidget != null? innerWidget!(value) : null),
      appearance: _AppCircularSliderAppearance(
        sliderSize: sliderSize,
        progressWidth: progressBarWidth,
        colorScheme: colorScheme
      ),
      onChange: onChange
    );
  }
}

class _AppCircularSliderInner extends StatelessWidget {
  const _AppCircularSliderInner({super.key, required this.size, this.child});

  final double size;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    return Center(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9999),
          boxShadow: [
            BoxShadow(
              color: colorScheme.surface.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 5,
            )
          ],
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colorScheme.primary.lighten(10).withOpacity(0.4),
              colorScheme.secondary.lighten(10).withOpacity(0.4),
            ],
          ),
        ),
        child: Center(
            child: Container(
              width: size - 26,
              height: size - 26,
              decoration: BoxDecoration(
                  color: colorScheme.background,
                  borderRadius: BorderRadius.circular(9999)
              ),
              child: Center(
                child: child,
              ),
            )
        ),
      ),
    );
  }
}

class _AppCircularSliderAppearance extends CircularSliderAppearance {
  _AppCircularSliderAppearance({
    required this.sliderSize,
    required this.progressWidth,
    required this.colorScheme
  }) : super(
    size: sliderSize,
    customWidths: CustomSliderWidths(
      trackWidth: progressWidth,
      progressBarWidth: progressWidth,
      shadowWidth: 30 * 1.4,
      handlerSize: 6,
    ),
    customColors: CustomSliderColors(
      // 背景颜色
      trackColor: colorScheme.surface,
      // 进度条颜色
      progressBarColors: [
        colorScheme.primary,
        colorScheme.secondary,
      ],
      gradientStartAngle: 270,
      gradientEndAngle: 270 + 180,
      dynamicGradient: false,
      dotColor: colorScheme.background,
      shadowColor: colorScheme.primary.withOpacity(0.25),
      shadowMaxOpacity: 0.19,
      shadowStep: 1.2,
    ),
    startAngle: 270,
    angleRange: 360,
  );

  final double sliderSize;
  final double progressWidth;
  final ColorScheme colorScheme;
}