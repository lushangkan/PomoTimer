import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../../common/app_text_style.dart';
import '../../../common/constants.dart';
import '../../../common/enum/attribute.dart';

class AttributeSelector extends StatelessWidget {
  const AttributeSelector({super.key, required this.selected, required this.customTimes, required this.onSelected, });

  final Attribute selected;
  final Map<Attribute, int> customTimes;
  final Function(int) onSelected;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    const double sliderSize = 238;
    const double progressBarWidth = 32;
    const double innerSize = sliderSize - progressBarWidth * 2;

    return SleekCircularSlider(
      min: Constants.timeRange[selected]!.item1.toDouble(),
      max: Constants.timeRange[selected]!.item2.toDouble(),
      initialValue: customTimes[selected]!.toDouble(),
      innerWidget: (double value) => CircularSliderInner(size: innerSize, minute: value.round(), selected: selected),
      appearance: AppCircularSliderAppearance(
          sliderSize: sliderSize,
          progressWidth: progressBarWidth,
          colorScheme: colorScheme
      ),
      onChange: (double value) {
        onSelected(value.round());
      }
    );
  }
}

class CircularSliderInner extends StatelessWidget {
  const CircularSliderInner({super.key, required this.size, required this.minute, required this.selected});

  final double size;
  final int minute;
  final Attribute selected;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    TextStyle? textTheme = AppTextStyle.generateWithTextStyle(theme.textTheme.headlineMedium!.copyWith(
        fontWeight: FontWeight.w400
    ));

    TextStyle? recTextStyle = AppTextStyle.generateWithTextStyle(theme.textTheme.bodySmall!.copyWith(
      fontWeight: FontWeight.w200,
      fontSize: 11,
    ));

    int recTimeMinute = (Constants.defaultTime[selected]!).floor();

    var showMinute = minute < 10 ? '0$minute' : '$minute';
    var showSecond = '00';

    var showText = '$showMinute:$showSecond';
    var recText = '推荐设置为$recTimeMinute分钟';

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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      showText,
                      style: textTheme,
                    ),
                    Text(
                      recText,
                      style: recTextStyle,
                    )
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }

}

class AppCircularSliderAppearance extends CircularSliderAppearance {
  AppCircularSliderAppearance({
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


