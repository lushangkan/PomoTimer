import 'package:pomotimer/widgets/pages/home/home_layout.dart';
import 'package:pomotimer/widgets/pages/home/initial/initial_timer_controller.dart';

class InitialHomePage extends HomePage {
  const InitialHomePage({super.key}) : super(timerController: const InitialTimerController());
}