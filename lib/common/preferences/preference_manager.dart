import 'package:pomotimer/common/logger.dart';
import 'package:pomotimer/common/preferences/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {

  late PreferenceManager instance;
  late final SharedPreferences prefs;

  PreferenceManager() {
    instance = this;

    _init();
  }

  // 检测首选项是否可空, 如果不可空则设置默认项
  void _check() {
    Preferences.defaultValues.forEach((key, value) {
      if (value != null) {
        // 选项不可为null
        if (prefs.get(key) == null) {
          logger.t('Set default value for $key: $value');

          // 选项为null
          if (value is String) {
            prefs.setString(key, value);
          } else if (value is int) {
            prefs.setInt(key, value);
          } else if (value is bool) {
            prefs.setBool(key, value);
          }
        }
      }
    });
  }

  void _init() async {
    logger.d('PreferenceManager init');

    prefs = await SharedPreferences.getInstance();

    _check();
  }

  void _setString(String key, String? value) {
    if (value == null) {
      prefs.remove(key);
    } else {
      prefs.setString(key, value);
    }
  }

  void _setInt(String key, int value) {
    prefs.setInt(key, value);
  }

  void _setBool(String key, bool value) {
    prefs.setBool(key, value);
  }

  set themeMode(int themeMode) {
    _setInt(Preferences.themeMode, themeMode);
  }

  set language(String? languageCode) {
    _setString(Preferences.language, languageCode);
  }

  set themeName(String? themeName) {
    _setString(Preferences.themeName, themeName);
  }

  set ringtonePath(String? ringtonePath) {
    _setString(Preferences.ringtonePath, ringtonePath);
  }

  set autoNext(bool autoNext) {
    _setBool(Preferences.autoNext, autoNext);
  }

}