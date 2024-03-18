import 'package:event_bus/event_bus.dart';

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

  print(msg); // hello
}