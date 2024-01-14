import 'package:go_router/go_router.dart';
import 'package:pomotimer/widgets/pages/home_page.dart';

final routes = GoRouter(routes: [
  GoRoute(path: '/', builder: (context, state) => const HomePage()),
]);