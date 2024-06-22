import 'package:event_bus/event_bus.dart';
import 'package:flutter/foundation.dart';

var eventBus = EventBus(sync: true);

class TestEvent {
  String msg;
  TestEvent(this.msg);
}

String msg = '';

void main() {
  eventBus.on<TestEvent>().listen((event) {
    msg = event.msg;
  });

  eventBus.fire(TestEvent('hello'));

  if (kDebugMode) {
    print(msg);
  } // hello
}