import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:pomotimer/states/app_states.dart';
import 'package:pomotimer/widgets/pages/home/in_progress/in_progress_home_page.dart';
import 'package:pomotimer/widgets/pages/home/initial/initial_home_page.dart';
import 'package:provider/provider.dart';

final routes = GoRouter(
    routes: [
      GoRoute(
          path: '/',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: InitialHomePage())),
      GoRoute(
          path: '/in-progress',
          pageBuilder: (context, state) => const NoTransitionPage(
                child: InProgressHomePage(),
              )),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      var timer = context.read<AppStates>().timer;
      if (timer.isRunning && state.path == '/') {
        return '/in-progress';
      } else if (!timer.isRunning && state.path == '/in-progress') {
        return '/';
      }
      return null;
    });
