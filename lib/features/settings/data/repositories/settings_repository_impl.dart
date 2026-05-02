import 'package:merchok/features/settings/settings.dart';
import 'package:merchok/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl({required this.prefs});

  final SharedPreferences prefs;

  static const _themeStyleKey = 'themeStyle';
  static const _defaultThemeStyle = ThemeStyle.light;
  static const _selectedFestivalIdKey = 'selected_festival_id';
  static const _languageCodeKey = 'languageCode';
  static const _onboardingShownKey = 'onboarding_shown';
  static const _analyticsEnabledKey = 'analytics_enabled';

  //
  // Theme
  //
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

  //
  // Onboarding
  //
  @override
  bool get isOnboardingShown => prefs.getBool(_onboardingShownKey) ?? false;

  @override
  Future<void> setOnboardingShown(bool shown) async =>
      await prefs.setBool(_onboardingShownKey, shown);

  //
  // Analytics
  //
  @override
  bool get isAnalyticsEnabled => prefs.getBool(_analyticsEnabledKey) ?? false;

  @override
  Future<void> setAnalyticsEnabled(bool enabled) async =>
      await prefs.setBool(_analyticsEnabledKey, enabled);
}
