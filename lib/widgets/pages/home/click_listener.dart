import 'package:flutter/cupertino.dart';
import 'package:pomotimer/common/event/event_bus.dart';
import 'package:pomotimer/common/event/events.dart';

class ClickListener extends StatelessWidget {
  final Widget child;

  const ClickListener({super.key, required this.child});

  void onClick() {
    eventBus.fire(AppClickedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        onClick();
      },
      child: child,
    );
  }
}