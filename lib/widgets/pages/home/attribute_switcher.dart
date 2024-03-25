import 'package:flutter/material.dart';

import '../../../common/app_text_style.dart';
import '../../../common/enum/attribute.dart';
import '../../measure_widget.dart';

class AttributeSwitcher extends StatefulWidget {
  const AttributeSwitcher(
      {super.key, required this.selected, this.onSelected});

  final Phase selected;
  final void Function(Phase)? onSelected;

  @override
  State<AttributeSwitcher> createState() => _AttributeSwitcherState();
}

class _AttributeSwitcherState extends State<AttributeSwitcher> {

  final Map<Phase, (Size, Offset)> _btnInfos = {
    Phase.focus: const (Size.zero, Offset.zero),
    Phase.shortBreak:  const (Size.zero, Offset.zero),
    Phase.longBreak: const (Size.zero, Offset.zero),
  };
  Offset? _rowPos;

  Offset _getLocPos(Phase index) {
    var btnInfo = _getBtnInfo(index);
    if (btnInfo == null || _rowPos == null) return Offset.zero;
    var btnPos = btnInfo.$2;
    var rowPos = _rowPos!;
    return Offset(btnPos.dx - rowPos.dx, btnPos.dy - rowPos.dy);
  }

  Size _getBtnSize(Phase index) {
    var btnInfo = _getBtnInfo(index);
    return btnInfo?.$1 ?? Size.zero;
  }

  (Size, Offset)? _getBtnInfo(Phase index) {
    if (_btnInfos.length != 3) return null;
    return _btnInfos[index];
  }

  bool get _isReady {
    return _btnInfos.values.every((element) => element.$1 != Size.zero) &&
        _btnInfos.values.every((element) => element.$2 != Offset.zero);
  }

  void _onPressed(Phase index) {
    if (widget.onSelected != null) {
      widget.onSelected!(index);
    }
  }

  void _onButtonSizeChange(Phase index, Size size, Offset pos) {
    setState(() {
      _btnInfos[index] = (size, pos);
    });
  }

  void _onRowSizeChange(Size size, Offset pos) {
    setState(() {
      _rowPos = pos;
    });
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
              top: _getLocPos(widget.selected).dy,
              left: _getLocPos(widget.selected).dx,
              child: UnconstrainedBox(
                child: Container(
                  height: _getBtnSize(widget.selected).height,
                  width: _getBtnSize(widget.selected).width,
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
            onChange: _onRowSizeChange,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AttributeBtn(
                  onSizeChange: (size, pos) => _onButtonSizeChange(Phase.focus, size, pos),
                  text: '专注',
                  onPressed: () => _onPressed(Phase.focus),
                ),
                const AttributeSplitter(),
                AttributeBtn(
                  text: '小休息',
                  onSizeChange: (size, pos) => _onButtonSizeChange(Phase.shortBreak, size, pos),
                  onPressed: () => _onPressed(Phase.shortBreak),
                ),
                const AttributeSplitter(),
                AttributeBtn(
                  onSizeChange: (size, pos) => _onButtonSizeChange(Phase.longBreak, size, pos),
                  text: '大休息',
                  onPressed: () => _onPressed(Phase.longBreak),
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