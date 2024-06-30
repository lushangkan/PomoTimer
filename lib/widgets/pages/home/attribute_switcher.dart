import 'dart:math';

import 'package:boxy/boxy.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../common/app_text_style.dart';
import '../../../common/enum/attribute.dart';

class AttributeSwitcher extends StatefulWidget {
  const AttributeSwitcher({super.key, required this.selected, this.onSelected});

  final Phase selected;
  final void Function(Phase)? onSelected;

  @override
  State<AttributeSwitcher> createState() => _AttributeSwitcherState();
}

class _AttributeSwitcherState extends State<AttributeSwitcher>
    with SingleTickerProviderStateMixin {

  late AnimationController _animationController;
  late Animation<double> _animation;
  final AttributeSwitcherDelegate delegate = AttributeSwitcherDelegate();

  // bg大小: height, width
  (double, double) bgSize = (0, 0);
  bool enableAnimation = false;

  @override
  void initState() {
    super.initState();

    delegate.lastSelected = widget.selected;

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          delegate.lastSelected = widget.selected;
        }
      });
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.ease);
  }

  void _onPressed(Phase index) {
    if (widget.onSelected != null) {
      widget.onSelected!(index);
    }
  }

  void setBgSize(double height, double width) {
    setState(() {
      bgSize = (height, width);
    });
  }

  void setEnableAnimation(bool enable) {
    setState(() {
      enableAnimation = enable;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    const duration = Duration(milliseconds: 200);

    var bgColor = colorScheme.primaryContainer;

    return CustomBoxy(
      delegate: delegate,
      children: [
        BoxyId(
          id: #bg,
          child: AnimatedContainer(
            duration: enableAnimation ? duration : Duration.zero,
            height: bgSize.$1,
            width: bgSize.$2,
            child: Container(
              decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(9999),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.primary.withOpacity(0.25),
                      spreadRadius: 4,
                      blurRadius: 5,
                      offset: Offset.zero,
                    ),
                  ]),
              constraints: const BoxConstraints.expand(),
              margin: const EdgeInsets.symmetric(horizontal: 4),
            ),
          ),
        ),
        BoxyId(
          id: Phase.focus,
          child: AttributeBtn(
            text: '专注',
            onPressed: () => _onPressed(Phase.focus),
          ),
        ),
        const AttributeSplitter(),
        BoxyId(
          id: Phase.shortBreak,
          child: AttributeBtn(
            text: '小休息',
            onPressed: () => _onPressed(Phase.shortBreak),
          ),
        ),
        const AttributeSplitter(),
        BoxyId(
          id: Phase.longBreak,
          child: AttributeBtn(
            text: '大休息',
            onPressed: () => _onPressed(Phase.longBreak),
          ),
        ),
      ],
    );
  }

  @override
  void didUpdateWidget(covariant AttributeSwitcher oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selected != widget.selected) {
      _animationController.forward(from: 0);
    }
  }
}

class AttributeSwitcherDelegate extends BoxyDelegate {
  //TODO: 无用的设为私人
  Phase lastSelected = Phase.focus;
  BoxyChild? bg;
  _AttributeSwitcherState? _state;

  (Phase, BoxyChild)? selectedChild;
  BoxyChild? lastSelectedWidget;
  Animation? tween;
  double? heightCenter;

  @override
  Size layout() {
    var height = 0.0;
    var width = 0.0;

    // 获取最大的高度
    for (var child in children) {
      child.layout(constraints);

      height = max(height.toDouble(), child.size.height);
    }

    // 获取中心高度
    heightCenter = height / 2;

    // 计算除了bg之外的所有child的宽度
    children.where((child) => child.id != #bg).forEach((child) {
      child.position(Offset(width, heightCenter! - child.size.height / 2));
      width += child.size.width;
    });

    var attributeSwitcher =
      buildContext.findAncestorWidgetOfExactType<AttributeSwitcher>();

    var currentButton = getChild(attributeSwitcher!.selected);

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _state!.setBgSize(currentButton.size.height, currentButton.size.width);
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _state!.setEnableAnimation(true);
      });
    });

    return Size(width, height);
  }

  @override
  void paint() {
    super.paint();

    bg ??= getChild(#bg);

    var attributeSwitcher =
        buildContext.findAncestorWidgetOfExactType<AttributeSwitcher>();

    // 当前选择的按钮
    var selected = attributeSwitcher!.selected;

    // 获取_AttributeSwitcherState
    _state ??= buildContext.findAncestorStateOfType<_AttributeSwitcherState>();

    // 获取animation相关
    var (animation, _) = (_state!._animation, _state!._animationController);

    // 如果选择了另一个按钮，那么就更新lastSelectedWidget和selectedChild还有tween
    if (selectedChild == null ||
        lastSelectedWidget == null ||
        selectedChild?.$1 != selected) {

      selectedChild = (selected, getChild(selected));
      lastSelectedWidget = getChild(lastSelected);

      // 当前选择Widget的x位置
      var x = selectedChild!.$2.offset.dx;
      // 上一次选择Widget的x位置
      var lastX = lastSelectedWidget!.offset.dx;
      // 获取对应的tween
      tween = Tween<double>(begin: lastX, end: x).animate(animation);
    }

    // 如果当前选择的按钮大小和bg大小不一样，那么就更新bg的大小
    if (_state!.bgSize.$1 != selectedChild!.$2.size.height ||
        _state!.bgSize.$2 != selectedChild!.$2.size.width) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _state!.setBgSize(
            selectedChild!.$2.size.height, selectedChild!.$2.size.width);
      });
    }

    // 设置bg的位置
    if (tween!.value != bg!.offset.dx) {
      if (bg!.size.height != 0) {
        bg!.position(Offset(tween!.value, heightCenter! - bg!.size.height / 2));
      } else {
        bg!.position(Offset(selectedChild!.$2.offset.dx,
            heightCenter! - selectedChild!.$2.size.height / 2));
      }
    }


  }
}

class AttributeBtn extends StatelessWidget {
  const AttributeBtn({super.key, this.onPressed, required this.text});

  final void Function()? onPressed;
  final String text;

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
          minWidth: 75,
        ),
        child: TextButton(
            onPressed: onPressed,
            child: Text(
              text,
              style: AppTextStyle.generateWithTextStyle(textTheme.bodyLarge!),
            )),
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
        color: colorScheme.surfaceContainerHigh,
        shape: BoxShape.circle,
      ),
      height: 4,
      width: 4,
    );
  }
}
