import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:pomotimer/common/timer/timer.dart';
import 'package:pomotimer/widgets/pages/home/in_progress/in_progress_home_page.dart';
import 'package:pomotimer/widgets/pages/home/initial/initial_home_page.dart';

import '../widgets/pages/setting/setting_layout.dart';

final routes = GoRouter(
    routes: [
      GoRoute(
          path: '/',
          pageBuilder: (context, state) {
            return AppTransitionPage(
              key: state.pageKey,
              child: const InitialHomePage(),
            );
          }),
      GoRoute(
          path: '/in-progress',
          pageBuilder: (context, state) {
            return AppTransitionPage(
              key: state.pageKey,
              child: const InProgressHomePage(),
            );
          }),
      GoRoute(
          path: '/setting',
          builder: (context, state) {
            return const SettingPage();
          })
    ],
    redirect: (BuildContext context, GoRouterState state) {
      if (state.matchedLocation == '/setting') {
        return null;
      }

      var timer = AppTimer.instance;
      if (timer.isRunning && (state.path == '/' || state.path == null)) {
        return '/in-progress';
      } else if (!timer.isRunning &&
          (state.path == '/in-progress' || state.path == null)) {
        return '/';
      }
      return null;
    });

class AppTransitionPage extends CustomTransitionPage {
  AppTransitionPage({
    required LocalKey super.key,
    required super.child,
  }) : super(
          transitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.easeOut).animate(animation),
              child: child,
            );
          },
        );
}
