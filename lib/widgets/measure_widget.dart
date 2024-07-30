import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';


typedef OnWidgetSizeChange = void Function(Size size, Offset pos);

class MeasureWidgetRenderObject extends RenderProxyBox {
  Size? oldSize;
  Offset? oldPos;
  OnWidgetSizeChange onChange;

  MeasureWidgetRenderObject(this.onChange);

  @override
  void performLayout() {
    super.performLayout();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      Size newSize = child!.size;
      Offset newPos = child!.localToGlobal(Offset.zero);
      if (oldSize == newSize && oldPos == newPos) return;

      oldSize = newSize;
      oldPos = newPos;

      onChange(newSize, newPos);
    });
  }
}

class MeasureWidget extends SingleChildRenderObjectWidget {
  final OnWidgetSizeChange onChange;

  const MeasureWidget({
    super.key,
    required this.onChange,
    required Widget super.child,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return MeasureWidgetRenderObject(onChange);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant MeasureWidgetRenderObject renderObject) {
    renderObject.onChange = onChange;
  }
}