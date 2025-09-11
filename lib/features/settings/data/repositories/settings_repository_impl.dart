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
  static const _selectedFestivalIdKey = 'selected_festival_id';

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

  //
  // Festival
  //
  @override
  String? get selectedFestivalId => prefs.getString(_selectedFestivalIdKey);

  @override
  Future<void> setSelectedFestivalId(String? selectedFestivalId) async {
    if (selectedFestivalId != null) {
      await prefs.setString(_selectedFestivalIdKey, selectedFestivalId);
    } else {
      await prefs.remove(_selectedFestivalIdKey);
    }
  }

  @override
  Future<void> clearSelectedFestivalId() async =>
      await prefs.remove(_selectedFestivalIdKey);
}
