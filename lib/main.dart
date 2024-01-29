import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pomotimer/routes/app_routes.dart';
import 'package:pomotimer/themes/app_theme.dart';
import 'package:pomotimer/widgets/states/main_states.dart';
import 'package:provider/provider.dart';

import 'generated/l10n.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = AppTheme();

    return ChangeNotifierProvider(
      create: (context) => MainStates(),
      child: MaterialApp.router(
        title: 'PomoTimer',
        routerConfig: routes,
        // TODO: 用户自定义主题
        theme: appTheme.getThemeData('default', false),
        darkTheme: appTheme.getThemeData('default', true),
        // TODO: 调试完后切换回system
        themeMode: ThemeMode.light,

        // i18n
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        // TODO: 用户自定义语言
        locale: const Locale('zh'),

        debugShowCheckedModeBanner: false,
      )
    );
  }
}
