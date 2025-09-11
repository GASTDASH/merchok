import 'package:merchok/theme/theme.dart';

abstract interface class SettingsRepository {
  // Theme
  ThemeStyle get currentThemeStyle;
  Future<void> setThemeStyle(ThemeStyle themeStyle);

  // Language
  String? get currentLanguageCode;
  Future<void> setLanguageCode(String? languageCode);

  // Festival
  String? get selectedFestivalId;
  Future<void> setSelectedFestivalId(String? selectedFestivalId);
  Future<void> clearSelectedFestivalId();
}
