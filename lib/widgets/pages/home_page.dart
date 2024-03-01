import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:pomotimer/app_text_style.dart';
import 'package:pomotimer/common/constants.dart';
import 'package:pomotimer/states/main_states.dart';
import 'package:pomotimer/widgets/measure_widget.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:tuple/tuple.dart';

import '../../common/attribute.dart';
import '../../generated/l10n.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: TopBar(theme),
      body: const HomeBody(),
    );
  }
}

class TopBar extends AppBar {
  TopBar(ThemeData theme, {super.key})
      : super(
            backgroundColor: Colors.transparent,
            leading: Container(
              margin: const EdgeInsets.only(left: 15),
              child: IconButton(
                iconSize: 25,
                tooltip: S.current.settingBtnTooltip,
                icon: Icon(LucideIcons.settings,
                    color: theme.colorScheme.onBackground),
                onPressed: () {
                  // TODO 跳转到设置
                },
              ),
            ));
}

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      child: Center(
        child: Container(
            constraints: const BoxConstraints.tightFor(width: 300, height: 500),
            child: const TimerController()),
      ),
    );
  }
}

class TimerController extends StatefulWidget {
  const TimerController({super.key});

  @override
  State<StatefulWidget> createState() => _TimerControllerState();
}

class _TimerControllerState extends State<TimerController> {
  Attribute selected = Attribute.focus;
  var switchKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    var mainStates = context.watch<MainStates>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AttributeSwitcher(
          key: switchKey,
          selected: selected,
          onSelected: (selected) => setState(() {
            this.selected = selected;
          }),
        ),
        Builder(builder: (context) {
          if (mainStates.timerRunning == true) {
            return const TimeDisplay();
          } else {
            return AttributeSelector(selected: selected);
          }
        })
      ],
    );
  }
}

class AttributeSwitcher extends StatefulWidget {
  const AttributeSwitcher(
      {super.key, required this.selected, required this.onSelected});

  final Attribute selected;
  final void Function(Attribute) onSelected;

  @override
  State<AttributeSwitcher> createState() => _AttributeSwitcherState();
}

class _AttributeSwitcherState extends State<AttributeSwitcher>
    with AutomaticKeepAliveClientMixin {

  late Attribute _selected;

  final Map<Attribute, Tuple2<Size, Offset>> _btnInfos = {
    Attribute.focus: const Tuple2(Size.zero, Offset.zero),
    Attribute.shortBreak:  const Tuple2(Size.zero, Offset.zero),
    Attribute.longBreak: const Tuple2(Size.zero, Offset.zero),
  };

  Offset? _rowPos;

  @override
  void initState() {
    super.initState();
    _selected = widget.selected;
  }

  set setSelect(Attribute index) {
    setState(() {
      _selected = index;
    });
  }

  get getSelect => _selected;

  Offset _globalToLocal(Offset pos, Offset rowPos) {
    return Offset(pos.dx - rowPos.dx, pos.dy - rowPos.dy);
  }

  Offset _getLocPos(Attribute index) {
    if (_btnInfos.length != 3) return Offset.zero;
    if (_rowPos == null) return Offset.zero;

    var btnInfo = _btnInfos[index];
    var btnPos = btnInfo!.item2;
    var rowPos = _rowPos!;
    return _globalToLocal(btnPos, rowPos);
  }

  Size _getBtnSize(Attribute index) {
    if (_btnInfos.length != 3) return Size.zero;
    return _btnInfos[index]!.item1;
  }

  bool get _isReady {
    return _btnInfos.values.every((element) => element.item1 != Size.zero) &&
        _btnInfos.values.every((element) => element.item2 != Offset.zero);
  }

  void _onPressed(Attribute index) {
    setState(() {
      _selected = index;
    });
    widget.onSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    return Stack(
      children: [
        Visibility(
          visible: _isReady,
          child: AnimatedPositioned(
              curve: Curves.ease,
              duration: const Duration(milliseconds: 200),
              top: _getLocPos(_selected).dy,
              left: _getLocPos(_selected).dx,
              child: UnconstrainedBox(
                child: Container(
                  height: _getBtnSize(_selected).height,
                  width: _getBtnSize(_selected).width,
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(80),
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.primary.withOpacity(0.25),
                        spreadRadius: 4,
                        blurRadius: 5,
                        offset: Offset.zero,
                      ),
                    ],
                  ),
                ),
              )),
        ),
        MeasureWidget(
            onChange: (size, pos) {
              setState(() {
                _rowPos = pos;
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AttributeBtn(
                  onSizeChange: (size, pos) {
                    setState(() {
                      _btnInfos[Attribute.focus] = Tuple2(size, pos);
                    });
                  },
                  text: '专注',
                  onPressed: () {
                    _onPressed(Attribute.focus);
                  },
                ),
                const AttributeSplitter(),
                AttributeBtn(
                  text: '小休息',
                  onSizeChange: (size, pos) {
                    setState(() {
                      _btnInfos[Attribute.shortBreak] = Tuple2(size, pos);
                    });
                  },
                  onPressed: () {
                    _onPressed(Attribute.shortBreak);
                  },
                ),
                const AttributeSplitter(),
                AttributeBtn(
                  onSizeChange: (size, pos) {
                    setState(() {
                      _btnInfos[Attribute.longBreak] = Tuple2(size, pos);
                    });
                  },
                  text: '大休息',
                  onPressed: () {
                    _onPressed(Attribute.longBreak);
                  },
                ),
              ],
            ))
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class AttributeBtn extends StatelessWidget {
  const AttributeBtn(
      {super.key,
      required this.onSizeChange,
      this.onPressed,
      required this.text});

  final void Function()? onPressed;
  final String text;
  final OnWidgetSizeChange onSizeChange;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: double.infinity,
          minHeight: 0,
          maxWidth: double.infinity,
          minWidth: 70,
        ),
        child: MeasureWidget(
          onChange: onSizeChange,
          child: TextButton(
              onPressed: onPressed,
              child: Text(
                text,
                style: AppTextStyle.generateWithTextStyle(textTheme.bodyLarge!),
              )),
        ),
      ),
    );
  }
}

class AttributeSplitter extends StatelessWidget {
  const AttributeSplitter({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        shape: BoxShape.circle,
      ),
      height: 4,
      width: 4,
    );
  }
}

// TODO: 专注次数显示

class AttributeSelector extends StatelessWidget {
  const AttributeSelector({super.key, required this.selected});

  final Attribute selected;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    MainStates mainStates = context.watch<MainStates>();

    const double sliderSize = 238;
    const double progressBarWidth = 32;
    const double innerSize = sliderSize - progressBarWidth * 2;

    return SleekCircularSlider(
      min: Constants.timeRange[selected]!.item1.toDouble(),
      max: Constants.timeRange[selected]!.item2.toDouble(),
      initialValue: mainStates.customTimes[selected]!.toDouble(),
      innerWidget: (double value) => CircularSliderInner(size: innerSize, minute: value.round(), selected: selected),
      appearance: AppCircularSliderAppearance(
        sliderSize: sliderSize,
        progressWidth: progressBarWidth,
        colorScheme: colorScheme
      ),
      onChange: (double value) {
        print(value);
      },
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
                color: colorScheme.surface.lighten(3).withOpacity(0.3),
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
      trackColor: colorScheme.surface.withOpacity(0.35),
      // 进度条颜色
      progressBarColors: [
        colorScheme.primary,
        colorScheme.secondary,
      ],
      gradientStartAngle: 270,
      gradientEndAngle: 270 + 180,
      dynamicGradient: false,
      dotColor: fromCssColor('#F3F3F3'),
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

class TimeDisplay extends StatelessWidget {
  const TimeDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('TimeDisplay'),
    );
  }
}
