import 'package:flutter/material.dart';

abstract class TimerController extends StatefulWidget {
  const TimerController({super.key});

  @override
  TimerControllerState createState();
}

abstract class TimerControllerState extends State<TimerController>
    with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context);
}
