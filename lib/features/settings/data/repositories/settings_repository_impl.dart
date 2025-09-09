import 'package:merchok/features/settings/settings.dart';
import 'package:merchok/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl({required this.prefs});

  final SharedPreferences prefs;

  static const _themeStyleKey = 'themeStyle';
  static const _defaultThemeStyle = ThemeStyle.light;

  @override
  ThemeStyle get getCurrentThemeStyle {
    final themeStyle = prefs.getString(_themeStyleKey);
    if (themeStyle == null) return _defaultThemeStyle;

    return ThemeStyle.values.byName(themeStyle);
  }

  @override
  Future<void> setThemeStyle(ThemeStyle themeStyle) async =>
      await prefs.setString(_themeStyleKey, themeStyle.name);
}
