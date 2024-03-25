import 'package:pomotimer/widgets/pages/home/home_layout.dart';
import 'package:pomotimer/widgets/pages/home/in_progress/in_progress_time_controller.dart';

class InProgressHomePage extends HomePage {
  const InProgressHomePage({super.key})
      : super(timerController: const InProgressTimeController());
}