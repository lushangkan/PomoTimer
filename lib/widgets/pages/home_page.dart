import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:pomotimer/app_text_style.dart';
import 'package:pomotimer/widgets/measure_widget.dart';
import 'package:tuple/tuple.dart';

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
  var selected = 0;
  var switchKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AttributeSwitcher(
          key: switchKey,
          selected: selected,
          onSelected: (selected) => setState(() {
            this.selected = selected;
          }),
        ),
      ],
    );
  }
}

class AttributeSwitcher extends StatefulWidget {
  AttributeSwitcher(
      {super.key, required this.selected, required this.onSelected}) {
    if (selected < 0 || selected > 2) {
      throw Exception('selected must be in [0, 2]');
    }
  }

  final int selected;
  final void Function(int) onSelected;

  @override
  State<AttributeSwitcher> createState() => _AttributeSwitcherState();
}

class _AttributeSwitcherState extends State<AttributeSwitcher> with AutomaticKeepAliveClientMixin  {
  var _selected = 0;
  final List<Tuple2<Size, Offset>> _btnInfos = [
    const Tuple2(Size.zero, Offset.zero),
    const Tuple2(Size.zero, Offset.zero),
    const Tuple2(Size.zero, Offset.zero),
  ];
  Offset? _rowPos;

  set setSelect(int index) {
    setState(() {
      _selected = index;
    });
  }

  get getSelect => _selected;

  Offset _globalToLocal(Offset pos, Offset rowPos) {
    return Offset(pos.dx - rowPos.dx, pos.dy - rowPos.dy);
  }

  Offset _getLocPos(int index) {
    if (_btnInfos.length != 3) return Offset.zero;
    if (_rowPos == null) return Offset.zero;

    var btnInfo = _btnInfos[index];
    var btnPos = btnInfo.item2;
    var rowPos = _rowPos!;
    return _globalToLocal(btnPos, rowPos);
  }

  Size _getBtnSize(int index) {
    if (_btnInfos.length != 3) return Size.zero;
    return _btnInfos[index].item1;
  }

  bool _isReady() {
    return _btnInfos.every((element) => element.item1 != Size.zero) &&
        _btnInfos.every((element) => element.item2 != Offset.zero);
  }

  void _onPressed(int index) {
    setState(() {
      _selected = index;
    });
    widget.onSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        Visibility(
          visible: _isReady(),
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
                      _btnInfos[0] = Tuple2(size, pos);
                    });
                  },
                  text: '专注',
                  onPressed: () {
                    _onPressed(0);
                  },
                ),
                const AttributeSplitter(),
                AttributeBtn(
                  text: '小休息',
                  onSizeChange: (size, pos) {
                    setState(() {
                      _btnInfos[1] = Tuple2(size, pos);
                    });
                  },
                  onPressed: () {
                    _onPressed(1);
                  },
                ),
                const AttributeSplitter(),
                AttributeBtn(
                  onSizeChange: (size, pos) {
                    setState(() {
                      _btnInfos[2] = Tuple2(size, pos);
                    });
                  },
                  text: '大休息',
                  onPressed: () {
                    _onPressed(2);
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
