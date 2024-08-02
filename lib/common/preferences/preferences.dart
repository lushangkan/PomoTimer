class Preferences {
  // 常量

  // 明亮主题还是深色
  static const String themeMode = 'theme_mode';

  // 主题名称, null为默认
  static const String themeName = 'theme_name';

  // 语言, null为系统
  static const String language = 'language';

  // 铃声位置, null为默认
  static const String ringtonePath = 'ringtone_path';

  // 自动开启下一个番茄
  static const String autoNext = 'auto_next';

  static var defaultValues = {
    themeMode: ThemeMode.system,
    themeName: null,
    language: null,
    ringtonePath: null,
    autoNext: false,
  };
}

class ThemeMode {
  // 常量

  // 跟随系统
  static const int system = 0;

  // 明亮
  static const int light = 1;

  // 深色
  static const int dark = 2;

}