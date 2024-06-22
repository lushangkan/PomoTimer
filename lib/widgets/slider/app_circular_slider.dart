import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class AppCircularSlider extends StatefulWidget {
  const AppCircularSlider(
      {super.key,
      this.sliderSize = 238,
      this.progressBarWidth = 32,
      required this.value,
      required this.min,
      required this.max,
      this.onChange,
      this.innerWidget,
      this.animationEnabled = true,
      this.animationDuration = 500,
      bool? selectMode})
      : selectMode = selectMode ?? (onChange != null);

  final double sliderSize;
  final double progressBarWidth;
  final double value;
  final double min;
  final double max;
  final void Function(double)? onChange;
  final Widget Function(double)? innerWidget;
  final bool animationEnabled;
  final int animationDuration;
  final bool selectMode;

  @override
  State createState() => _AppCircularSliderState();
}

class _AppCircularSliderState extends State<AppCircularSlider> with SingleTickerProviderStateMixin{

  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: widget.animationDuration), );
    CurvedAnimation curve = CurvedAnimation(parent: _animationController, curve: Curves.elasticOut);
    _animation = Tween<double>(begin: 0, end: 6).animate(curve);
    playAnimation();
  }
  
  @override
  void didUpdateWidget(covariant AppCircularSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (oldWidget.selectMode != widget.selectMode) {
      playAnimation();
    }
  }

  void playAnimation() {
    if (widget.selectMode) {
      _animationController.forward();
    } else {
      _animationController.reverse(from: _animationController.upperBound);
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    double innerSize = widget.sliderSize - widget.progressBarWidth * 2;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return SleekCircularSlider(
            min: widget.min,
            max: widget.max,
            initialValue: widget.value,
            innerWidget: (double value) => _AppCircularSliderInner(
                size: innerSize,
                child: widget.innerWidget != null ? widget.innerWidget!(value) : null),
            appearance: _AppCircularSliderAppearance(
              animationEnabled: widget.animationEnabled,
              sliderSize: widget.sliderSize,
              progressWidth: widget.progressBarWidth,
              colorScheme: colorScheme,
              selectMode: widget.selectMode,
              handlerSize: _animation.value,
            ),
            onChange: widget.onChange);
      }
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
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
              color: colorScheme.surfaceContainer.withOpacity(0.2),
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
              borderRadius: BorderRadius.circular(9999)),
          child: Center(
            child: child,
          ),
        )),
      ),
    );
  }
}

class _AppCircularSliderAppearance extends CircularSliderAppearance {
  _AppCircularSliderAppearance(
      {required this.sliderSize,
      required this.progressWidth,
      required this.colorScheme,
      required this.animationEnabled,
        required this.handlerSize,
      required this.selectMode})
      : super(
          size: sliderSize,
          customWidths: CustomSliderWidths(
            trackWidth: progressWidth,
            progressBarWidth: progressWidth,
            shadowWidth: 30 * 1.4,
            handlerSize: handlerSize,
          ),
          customColors: CustomSliderColors(
            // 背景颜色
            trackColor: colorScheme.surfaceContainer,
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
          animationEnabled: animationEnabled,
          animDurationMultiplier: 1.05,
        );

  final double sliderSize;
  final double progressWidth;
  final ColorScheme colorScheme;
  final bool animationEnabled;
  final double handlerSize;
  final bool selectMode;
}
