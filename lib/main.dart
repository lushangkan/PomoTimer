import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logger/logger.dart';
import 'package:pomotimer/common/preferences/preference_manager.dart';
import 'package:pomotimer/common/timer/timer.dart';
import 'package:pomotimer/main.reflectable.dart';
import 'package:pomotimer/routes/app_routes.dart';
import 'package:pomotimer/states/app_states.dart';
import 'package:pomotimer/states/timer_states.dart';
import 'package:pomotimer/themes/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/channel/flutter_method_channel.dart';
import 'common/permission_handle.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kDebugMode) {
    Logger.level = Level.trace;
  }

  initializeReflectable();

  // 初始化PreferenceManager
  PreferenceManager();

  // 初始化State，因为获取储存是异步的，需要在MaterialApp之前初始化
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final TimerStates timerStates = TimerStates.loadFromStorage(prefs);
  final AppStates appStates = AppStates();

  // 初始化PermissionHandle
  await PermissionHandle.instance.checkAllPermissionStatus();

  // 初始化Intl
  await S.load(Locale(PreferenceManager.instance.language!));

  // 初始化FlutterMethodChannel
  FlutterMethodChannel();

  // 初始化Timer
  AppTimer(timerStates, appStates);

  runApp(App(timerStates: timerStates, appStates: appStates));
}

class App extends StatelessWidget {
  const App({super.key, required this.timerStates, required this.appStates});

  final TimerStates timerStates;
  final AppStates appStates;

  static ThemeData? themeData;

  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = AppTheme();

    Locale? locale;

    if (PreferenceManager.instance.language != null) {
      locale = Locale(PreferenceManager.instance.language!);
    }

    ThemeMode? themeMode;

    if (PreferenceManager.instance.themeMode == 1) {
      themeMode = ThemeMode.light;
    } else if (PreferenceManager.instance.themeMode == 2) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.system;
    }

    ThemeData themeData;
    ThemeData darkThemeData;

    if (PreferenceManager.instance.themeName == null) {
      themeData = appTheme.getThemeData('default', false);
      darkThemeData = appTheme.getThemeData('default', true);
    } else {
      themeData = appTheme.getThemeData(PreferenceManager.instance.themeName!, false);
      darkThemeData = appTheme.getThemeData(PreferenceManager.instance.themeName!, true);
    }

    App.themeData = themeData;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TimerStates>.value(value: timerStates),
        ChangeNotifierProvider<AppStates>.value(value: appStates),
      ],
      child: MaterialApp.router(
        title: 'PomoTimer',
        routerConfig: routes,
        // TODO: 用户自定义主题
        theme: themeData,
        darkTheme: darkThemeData,
        themeMode: themeMode,

        // i18n
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: locale,

        debugShowCheckedModeBanner: false,
      ),
    );
  }
}


