import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logger/logger.dart';
import 'package:pomotimer/common/permission_handle.dart';
import 'package:pomotimer/common/timer/timer.dart';
import 'package:pomotimer/main.reflectable.dart';
import 'package:pomotimer/routes/app_routes.dart';
import 'package:pomotimer/states/app_states.dart';
import 'package:pomotimer/states/timer_states.dart';
import 'package:pomotimer/themes/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/channel/flutter_method_channel.dart';
import 'common/utils/debug_utils.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (isDebugMode) {
    Logger.level = Level.trace;
  }

  initializeReflectable();

  // 初始化State，因为获取储存是异步的，需要在MaterialApp之前初始化
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final TimerStates timerStates = TimerStates.loadFromStorage(prefs);
  final AppStates appStates = AppStates();

  // 初始化PermissionHandle
  await permissionHandle.checkAllPermissionStatus();

  // 初始化Timer
  AppTimer(timerStates, appStates);

  runApp(App(timerStates: timerStates, appStates: appStates));

  // 初始化FlutterMethodChannel
  FlutterMethodChannel();
}

class App extends StatelessWidget {
  const App({super.key, required this.timerStates, required this.appStates});

  final TimerStates timerStates;
  final AppStates appStates;

  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = AppTheme();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TimerStates>.value(value: timerStates),
        ChangeNotifierProvider<AppStates>.value(value: appStates),
      ],
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
      ),
    );
  }
}

