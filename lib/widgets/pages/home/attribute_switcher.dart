import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import '../../../common/app_text_style.dart';
import '../../../common/enum/attribute.dart';
import '../../measure_widget.dart';

class AttributeSwitcher extends StatefulWidget {
  const AttributeSwitcher(
      {super.key, required this.selected, required this.onSelected});

  final Phase selected;
  final void Function(Phase) onSelected;

  @override
  State<AttributeSwitcher> createState() => _AttributeSwitcherState();
}

class _AttributeSwitcherState extends State<AttributeSwitcher> {

  late Phase _selected;
  final Map<Phase, Tuple2<Size, Offset>> _btnInfos = {
    Phase.focus: const Tuple2(Size.zero, Offset.zero),
    Phase.shortBreak:  const Tuple2(Size.zero, Offset.zero),
    Phase.longBreak: const Tuple2(Size.zero, Offset.zero),
  };
  Offset? _rowPos;

  @override
  void initState() {
    super.initState();
    _selected = widget.selected;
  }

  set setSelect(Phase index) {
    setState(() {
      _selected = index;
    });
  }

  get getSelect => _selected;

  Offset _getLocPos(Phase index) {
    var btnInfo = _getBtnInfo(index);
    if (btnInfo == null || _rowPos == null) return Offset.zero;
    var btnPos = btnInfo.item2;
    var rowPos = _rowPos!;
    return Offset(btnPos.dx - rowPos.dx, btnPos.dy - rowPos.dy);
  }

  Size _getBtnSize(Phase index) {
    var btnInfo = _getBtnInfo(index);
    return btnInfo?.item1 ?? Size.zero;
  }

  Tuple2<Size, Offset>? _getBtnInfo(Phase index) {
    if (_btnInfos.length != 3) return null;
    return _btnInfos[index];
  }

  bool get _isReady {
    return _btnInfos.values.every((element) => element.item1 != Size.zero) &&
        _btnInfos.values.every((element) => element.item2 != Offset.zero);
  }

  void _onPressed(Phase index) {
    setState(() {
      _selected = index;
    });
    widget.onSelected(index);
  }

  @override
  Widget build(BuildContext context) {
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
                      _btnInfos[Phase.focus] = Tuple2(size, pos);
                    });
                  },
                  text: '专注',
                  onPressed: () {
                    _onPressed(Phase.focus);
                  },
                ),
                const AttributeSplitter(),
                AttributeBtn(
                  text: '小休息',
                  onSizeChange: (size, pos) {
                    setState(() {
                      _btnInfos[Phase.shortBreak] = Tuple2(size, pos);
                    });
                  },
                  onPressed: () {
                    _onPressed(Phase.shortBreak);
                  },
                ),
                const AttributeSplitter(),
                AttributeBtn(
                  onSizeChange: (size, pos) {
                    setState(() {
                      _btnInfos[Phase.longBreak] = Tuple2(size, pos);
                    });
                  },
                  text: '大休息',
                  onPressed: () {
                    _onPressed(Phase.longBreak);
                  },
                ),
              ],
            ))
      ],
    );
  }
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