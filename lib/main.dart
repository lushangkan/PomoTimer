import 'package:flutter/material.dart';
import 'package:pomotimer/widgets/pages/home_page.dart';
import 'package:pomotimer/widgets/states/main_states.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainStates(),
      child: MaterialApp(
        title: 'PomoTimer',
        theme: ThemeData(
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomePage()
      )
    );
  }
}
