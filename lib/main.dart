import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logger/logger.dart';
import 'package:pomotimer/common/debug_utils.dart';
import 'package:pomotimer/main.reflectable.dart';
import 'package:pomotimer/routes/app_routes.dart';
import 'package:pomotimer/states/main_states.dart';
import 'package:pomotimer/themes/app_theme.dart';
import 'package:provider/provider.dart';

import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (isDebugMode) {
    Logger.level = Level.trace;
  }

  initializeReflectable();

  // 初始化State，因为获取储存是异步的，需要在MaterialApp之前初始化
  MainStates mainStates = await MainStates.loadFromStorage();

  runApp(App(mainStates: mainStates));
}

class App extends StatelessWidget {
  const App({super.key, required this.mainStates});

  final MainStates mainStates;

  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = AppTheme();

    return ChangeNotifierProvider.value(
        value: mainStates,
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

