import 'package:flutter/cupertino.dart';
import 'package:pomotimer/common/event/event_bus.dart';
import 'package:pomotimer/common/event/events.dart';

abstract class AppPage extends StatefulWidget {
  const AppPage({super.key});

}

abstract class AppPageState<T extends AppPage> extends State<T> with WidgetsBindingObserver{

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    eventBus.fire(AppLifecycleChangeEvent(state));
  }
}

