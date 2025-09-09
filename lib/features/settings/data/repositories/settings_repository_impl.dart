import 'package:merchok/features/settings/settings.dart';
import 'package:merchok/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl({required this.prefs});

  final SharedPreferences prefs;

  //
  // Theme
  //
  static const _themeStyleKey = 'themeStyle';
  static const _defaultThemeStyle = ThemeStyle.light;

  @override
  ThemeStyle get currentThemeStyle {
    final themeStyle = prefs.getString(_themeStyleKey);
    if (themeStyle == null) return _defaultThemeStyle;

    return ThemeStyle.values.byName(themeStyle);
  }

  @override
  Future<void> setThemeStyle(ThemeStyle themeStyle) async =>
      await prefs.setString(_themeStyleKey, themeStyle.name);

  //
  // Language
  //
  static const _languageCodeKey = 'languageCode';

  @override
  String? get currentLanguageCode => prefs.getString(_languageCodeKey);

  @override
  Future<void> setLanguageCode(String? languageCode) async {
    if (languageCode != null) {
      await prefs.setString(_languageCodeKey, languageCode);
    } else {
      await prefs.remove(_languageCodeKey);
    }
  }
}
