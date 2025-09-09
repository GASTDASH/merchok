import 'package:merchok/theme/theme.dart';

abstract interface class SettingsRepository {
  ThemeStyle get getCurrentThemeStyle;
  Future<void> setThemeStyle(ThemeStyle themeStyle);
}
