import 'package:go_router/go_router.dart';

import '../widgets/pages/home/home_layout.dart';

final routes = GoRouter(routes: [
  GoRoute(path: '/', builder: (context, state) => const HomePage()),
]);